/// ========================================
/// GC OS MVP 客户端 - 核心服务实现
/// 
/// TDD 开发模式：测试驱动实现
/// ========================================

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/models.dart';

// ========================================
// 异常定义
// ========================================

class DiscoveryException implements Exception {
  final String message;
  DiscoveryException(this.message);
  
  @override
  String toString() => 'DiscoveryException: $message';
}

class DiscoveryTimeoutException implements Exception {
  @override
  String toString() => 'Discovery timeout';
}

class NotConnectedException implements Exception {
  final String message;
  NotConnectedException(this.message);
  
  @override
  String toString() => 'NotConnectedException: $message';
}

// ========================================
// 设备发现服务 - 实现
// ========================================

class DiscoveryService {
  final String _serviceType = '_openclaw._tcp';
  final Duration _timeout = const Duration(seconds: 3);
  final http.Client _httpClient = http.Client();
  
  /// 发现局域网中的 OpenClaw 设备
  Future<List<DeviceInfo>> discover() async {
    final devices = <DeviceInfo>[];
    
    try {
      final localIp = await _getLocalIp();
      if (localIp == null) return [];
      
      // 扫描 /24 网段 (可优化为并发)
      final subnet = localIp.substring(0, localIp.lastIndexOf('.'));
      
      for (int i = 1; i <= 254; i++) {
        final ip = '$subnet.$i';
        final device = await _checkDevice(ip);
        if (device != null) {
          devices.add(device);
          if (devices.length >= 10) break; // 最多发现10个
        }
      }
    } catch (e) {
      // 返回已发现的设备
    }
    
    return devices;
  }

  /// 检查单个设备是否在线
  Future<DeviceInfo?> _checkDevice(String ip) async {
    try {
      final response = await _httpClient
        .get(Uri.parse('http://$ip:18790/api/status'))
        .timeout(_timeout);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DeviceInfo(
          id: data['deviceId'] ?? ip,
          name: data['name'] ?? 'OpenClaw',
          ip: ip,
          port: 18790,
          status: data['status'] ?? 'online',
          lastSeen: DateTime.now(),
        );
      }
    } catch (e) {
      // 设备不在线
    }
    return null;
  }

  /// 获取本机 IP
  Future<String?> _getLocalIp() async {
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLoopback: false,
      );
      
      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (!addr.isLoopback && 
              addr.type == InternetAddressType.IPv4 &&
              !addr.address.startsWith('169.254')) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      // 忽略
    }
    return null;
  }

  /// 手动添加设备
  Future<DeviceInfo> addManual(String ip, int port) async {
    try {
      final response = await _httpClient
        .get(Uri.parse('http://$ip:$port/api/status'))
        .timeout(_timeout);
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DeviceInfo(
          id: data['deviceId'] ?? ip,
          name: data['name'] ?? 'OpenClaw',
          ip: ip,
          port: port,
          status: 'online',
          lastSeen: DateTime.now(),
        );
      }
      throw DiscoveryException('Device not found at $ip:$port');
    } catch (e) {
      throw DiscoveryException('Failed to connect: $e');
    }
  }
  
  void dispose() {
    _httpClient.close();
  }
}

// ========================================
// 连接管理器 - 实现
// ========================================

class ConnectionManager {
  WebSocketChannel? _channel;
  String? _currentHost;
  int? _currentPort;
  bool _isConnected = false;
  Timer? _heartbeatTimer;
  
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();
  final _disconnectController = StreamController<bool>.broadcast();
  
  bool get isConnected => _isConnected;
  String? get currentHost => _currentHost;
  Stream<Map<String, dynamic>> get onMessage => _messageController.stream;
  Stream<bool> get onDisconnect => _disconnectController.stream;
  
  /// 连接到 OpenClaw
  Future<bool> connect(String host, int port) async {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://$host:$port/ws'),
      );
      
      await _channel!.ready;
      _currentHost = host;
      _currentPort = port;
      _isConnected = true;
      
      // 监听消息
      _channel!.stream.listen(
        (data) {
          try {
            final msg = jsonDecode(data as String) as Map<String, dynamic>;
            _messageController.add(msg);
          } catch (e) {
            _messageController.add({'type': 'raw', 'data': data});
          }
        },
        onDone: () {
          _isConnected = false;
          _disconnectController.add(true);
          _stopHeartbeat();
        },
        onError: (e) {
          _isConnected = false;
          _disconnectController.add(true);
          _stopHeartbeat();
        },
      );
      
      // 启动心跳
      _startHeartbeat();
      
      return true;
    } catch (e) {
      _isConnected = false;
      return false;
    }
  }

  /// 断开连接
  Future<void> disconnect() async {
    _stopHeartbeat();
    await _channel?.sink.close();
    _channel = null;
    _isConnected = false;
    _currentHost = null;
    _currentPort = null;
  }

  /// 发送消息
  Future<bool> send(Map<String, dynamic> data) async {
    if (!_isConnected || _channel == null) {
      throw NotConnectedException('Not connected to server');
    }
    
    try {
      _channel!.sink.add(jsonEncode(data));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 发送心跳
  Future<void> sendHeartbeat() async {
    if (_isConnected) {
      await send({'type': 'ping', 'timestamp': DateTime.now().toIso8601String()});
    }
  }

  /// 启动心跳定时器
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => sendHeartbeat(),
    );
  }

  /// 停止心跳
  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }
  
  void dispose() {
    _stopHeartbeat();
    _messageController.close();
    _disconnectController.close();
  }
}

// ========================================
// 消息通道 - 实现
// ========================================

class MessageChannel {
  final ConnectionManager _connectionManager;
  final _messageController = StreamController<ChatMessage>.broadcast();
  
  MessageChannel(this._connectionManager);
  
  /// 连接
  Future<bool> connect(String host, int port) async {
    return await _connectionManager.connect(host, port);
  }

  /// 断开
  Future<void> disconnect() async {
    await _connectionManager.disconnect();
  }

  /// 发送消息
  Future<bool> send(String content) async {
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      sender: 'user',
      timestamp: DateTime.now(),
      type: MessageType.text,
    );
    
    return await _connectionManager.send({
      'type': 'message',
      'content': message.content,
      'sender': message.sender,
      'timestamp': message.timestamp.toIso8601String(),
    });
  }

  /// 监听服务器消息
  void _listenToConnection() {
    _connectionManager.onMessage.listen((data) {
      if (data['type'] == 'message') {
        final message = ChatMessage(
          id: data['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
          content: data['content'] ?? '',
          sender: data['sender'] ?? 'bot',
          timestamp: data['timestamp'] != null 
            ? DateTime.parse(data['timestamp'])
            : DateTime.now(),
          type: MessageType.text,
        );
        _messageController.add(message);
      }
    });
  }
  
  /// 消息流
  Stream<ChatMessage> get messageStream {
    _listenToConnection();
    return _messageController.stream;
  }
  
  void dispose() {
    _messageController.close();
  }
}

// ========================================
// 设备状态服务 - 实现
// ========================================

class DeviceState {
  final ConnectionManager? _connectionManager;
  final http.Client _httpClient = http.Client();
  
  DeviceState([this._connectionManager]);
  
  /// 获取 CPU 使用率
  Future<double> getCpuUsage() async {
    try {
      if (Platform.isLinux) {
        final stat = await File('/proc/stat').readAsString();
        final lines = stat.split('\n');
        final cpuLine = lines.firstWhere(
          (l) => l.startsWith('cpu '),
          orElse: () => '',
        );
        
        if (cpuLine.isEmpty) return 0;
        
        final parts = cpuLine.split(RegExp(r'\s+')).sublist(1);
        final values = parts.map((s) => int.tryParse(s) ?? 0).toList();
        final total = values.reduce((a, b) => a + b);
        final idle = values.length > 3 ? values[3] : 0;
        
        if (total == 0) return 0;
        return ((total - idle) / total * 100 * 10).round() / 10;
      } else if (Platform.isWindows) {
        final result = await Process.run('wmic', ['cpu', 'get', 'loadpercentage']);
        final output = result.stdout.toString();
        final match = RegExp(r'(\d+)').firstMatch(output);
        return match != null ? double.parse(match.group(1)!) : 0.0;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  /// 获取内存使用
  Future<MemoryInfo> getMemoryUsage() async {
    try {
      if (Platform.isLinux) {
        final meminfo = await File('/proc/meminfo').readAsString();
        final lines = meminfo.split('\n');
        
        int getValue(String key) {
          final line = lines.firstWhere(
            (l) => l.startsWith(key),
            orElse: () => '',
          );
          final match = RegExp(r'(\d+)').firstMatch(line);
          return match != null ? (int.parse(match.group(1)!) * 1024) : 0;
        }
        
        final total = getValue('MemTotal:');
        final free = getValue('MemAvailable:');
        final used = total - free;
        final percentage = total > 0 ? (used / total * 100 * 10).round() / 10 : 0.0;
        
        return MemoryInfo(
          total: total,
          used: used,
          free: free,
          percentage: percentage,
        );
      } else if (Platform.isWindows) {
        final result = await Process.run('wmic', ['OS', 'get', 'FreePhysicalMemory,TotalVisibleMemorySize', '/format:list']);
        final output = result.stdout.toString();
        
        final freeMatch = RegExp(r'FreePhysicalMemory=(\d+)').firstMatch(output);
        final totalMatch = RegExp(r'TotalVisibleMemorySize=(\d+)').firstMatch(output);
        
        final total = (int.tryParse(totalMatch?.group(1) ?? '0') ?? 0) * 1024;
        final free = (int.tryParse(freeMatch?.group(1) ?? '0') ?? 0) * 1024;
        final used = total - free;
        final percentage = total > 0 ? (used / total * 100 * 10).round() / 10 : 0.0;
        
        return MemoryInfo(
          total: total,
          used: used,
          free: free,
          percentage: percentage,
        );
      }
      return MemoryInfo(total: 0, used: 0, free: 0, percentage: 0);
    } catch (e) {
      return MemoryInfo(total: 0, used: 0, free: 0, percentage: 0);
    }
  }

  /// 获取存储使用
  Future<StorageInfo> getStorageUsage() async {
    try {
      if (Platform.isLinux) {
        final result = await Process.run('df', ['-B1', '/']);
        final lines = result.stdout.toString().split('\n');
        
        if (lines.length < 2) {
          return StorageInfo(total: 0, used: 0, free: 0, percentage: 0);
        }
        
        final parts = lines[1].split(RegExp(r'\s+'));
        final total = int.tryParse(parts[1]) ?? 0;
        final used = int.tryParse(parts[2]) ?? 0;
        final free = int.tryParse(parts[3]) ?? 0;
        final percentage = total > 0 ? (used / total * 100 * 10).round() / 10 : 0.0;
        
        return StorageInfo(
          total: total,
          used: used,
          free: free,
          percentage: percentage,
        );
      } else if (Platform.isWindows) {
        final result = await Process.run('wmic', ['logicaldisk', 'where', 'DeviceID="C:"', 'get', 'Size,FreeSpace']);
        final output = result.stdout.toString();
        
        final freeMatch = RegExp(r'FreeSpace=(\d+)').firstMatch(output);
        final sizeMatch = RegExp(r'Size=(\d+)').firstMatch(output);
        
        final total = int.tryParse(sizeMatch?.group(1) ?? '0') ?? 0;
        final free = int.tryParse(freeMatch?.group(1) ?? '0') ?? 0;
        final used = total - free;
        final percentage = total > 0 ? (used / total * 100 * 10).round() / 10 : 0.0;
        
        return StorageInfo(
          total: total,
          used: used,
          free: free,
          percentage: percentage,
        );
      }
      return StorageInfo(total: 0, used: 0, free: 0, percentage: 0);
    } catch (e) {
      return StorageInfo(total: 0, used: 0, free: 0, percentage: 0);
    }
  }

  /// 获取网络状态
  Future<NetworkStatus> getNetworkStatus() async {
    try {
      // 尝试从 OpenClaw 获取
      if (_connectionManager?.isConnected == true) {
        final response = await _httpClient
          .get(Uri.parse('http://localhost:18790/api/network'))
          .timeout(const Duration(seconds: 2));
        
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return NetworkStatus.fromJson(data);
        }
      }
      
      // 本地获取
      return NetworkStatus(
        connectionType: 'dhcp',
        ipAddress: await _getLocalIp(),
        isConnected: await _checkConnectivity(),
        uploadSpeed: 0,
        downloadSpeed: 0,
      );
    } catch (e) {
      return NetworkStatus(
        connectionType: 'unknown',
        isConnected: false,
        uploadSpeed: 0,
        downloadSpeed: 0,
      );
    }
  }

  /// 获取所有状态
  Future<Map<String, dynamic>> getAllStatus() async {
    return {
      'cpu': await getCpuUsage(),
      'memory': await getMemoryUsage(),
      'storage': await getStorageUsage(),
      'network': await getNetworkStatus(),
    };
  }
  
  Future<String?> _getLocalIp() async {
    try {
      final interfaces = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
        includeLoopback: false,
      );
      
      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (!addr.isLoopback && 
              addr.type == InternetAddressType.IPv4 &&
              !addr.address.startsWith('169.254')) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      // 忽略
    }
    return null;
  }
  
  Future<bool> _checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress != null;
    } catch (e) {
      return false;
    }
  }
  
  void dispose() {
    _httpClient.close();
  }
}