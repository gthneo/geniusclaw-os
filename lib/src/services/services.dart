/// ========================================
/// MVP 客户端 - 服务层
/// ========================================

import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/models.dart';

/// 设备发现服务
/// 
/// 功能: 局域网自动发现 OpenClaw 节点
/// 技术: mDNS/Bonjour + HTTP REST API
class DiscoveryService {
  final String _serviceType = '_openclaw._tcp';
  final Duration _timeout = const Duration(seconds: 3);
  
  /// 发现局域网中的 OpenClaw 设备
  Future<List<DeviceInfo>> discover() async {
    try {
      // 方式1: 使用 mDNS 发现 (需要 bonjour 库)
      // final mdns = MDnsService();
      // return await mdns.discover(_serviceType);
      
      // 方式2: 扫描本地网络常见 IP 段
      final devices = <DeviceInfo>[];
      final localIp = await _getLocalIp();
      if (localIp == null) return [];
      
      // 并发扫描 /24 网段
      final subnet = localIp.substring(0, localIp.lastIndexOf('.'));
      final futures = List.generate(254, (i) => _checkDevice('$subnet.${i + 1}'));
      final results = await Future.wait(futures);
      
      for (final device in results) {
        if (device != null) devices.add(device);
      }
      
      return devices;
    } catch (e) {
      throw DiscoveryException('Failed to discover devices: $e');
    }
  }

  /// 检查单个设备
  Future<DeviceInfo?> _checkDevice(String ip) async {
    try {
      final response = await http.get(
        Uri.parse('http://$ip:18790/api/status'),
      ).timeout(_timeout);
      
      if (response.statusCode == 200) {
        final data = await response.json();
        return DeviceInfo(
          id: data['deviceId'] ?? ip,
          name: data['name'] ?? 'OpenClaw',
          ip: ip,
          port: 18790,
          status: 'online',
          lastSeen: DateTime.now(),
        );
      }
    } catch (e) {
      // 设备不在线或未开启
    }
    return null;
  }

  /// 获取本机 IP
  Future<String?> _getLocalIp() async {
    final interfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
      includeLoopback: false,
    );
    
    for (final interface in interfaces) {
      for (final addr in interface.addresses) {
        if (!addr.isLoopback && addr.type == InternetAddressType.IPv4) {
          return addr.address;
        }
      }
    }
    return null;
  }

  /// 手动添加设备
  Future<DeviceInfo> addManual(String ip, int port) async {
    try {
      final response = await http.get(
        Uri.parse('http://$ip:$port/api/status'),
      ).timeout(_timeout);
      
      if (response.statusCode == 200) {
        final data = await response.json();
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
      throw DiscoveryException('Failed to connect to device: $e');
    }
  }
}

/// 设备发现异常
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

/// 连接管理器
class ConnectionManager {
  WebSocket? _socket;
  String? _currentHost;
  int? _currentPort;
  bool _isConnected = false;
  Timer? _heartbeatTimer;
  
  bool get isConnected => _isConnected;
  String? get currentHost => _currentHost;
  
  /// 连接到 OpenClaw
  Future<bool> connect(String host, int port) async {
    try {
      _socket = await WebSocket.connect('ws://$host:$port/ws');
      _currentHost = host;
      _currentPort = port;
      _isConnected = true;
      
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
    _heartbeatTimer?.cancel();
    await _socket?.close();
    _socket = null;
    _isConnected = false;
    _currentHost = null;
    _currentPort = null;
  }

  /// 发送消息
  Future<bool> send(Map<String, dynamic> data) async {
    if (!_isConnected || _socket == null) {
      throw NotConnectedException('Not connected to server');
    }
    
    try {
      _socket!.add(data.toJsonString());
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 发送心跳
  Future<void> sendHeartbeat() async {
    await send({'type': 'ping', 'timestamp': DateTime.now().toIso8601String()});
  }

  /// 启动心跳定时器
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => sendHeartbeat(),
    );
  }

  /// 监听消息
  Stream<Map<String, dynamic>> get onMessage {
    return _socket?.cast<String>().map((data) {
      return Map<String, dynamic>.from(
        const JsonDecoder().convert(data),
      );
    }) ?? const Stream.empty();
  }

  /// 监听断开
  Stream<bool> get onDisconnect {
    return _socket?.closeCode.map((code) => true) ?? const Stream.empty();
  }
}

/// 未连接异常
class NotConnectedException implements Exception {
  final String message;
  NotConnectedException(this.message);
  
  @override
  String toString() => 'NotConnectedException: $message';
}

/// 消息通道
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
      'content': message.toJson(),
    });
  }

  /// 消息流
  Stream<ChatMessage> get messageStream => _messageController.stream;
  
  void dispose() {
    _messageController.close();
  }
}

/// 设备状态服务
class DeviceState {
  final ConnectionManager _connectionManager;
  
  DeviceState([ConnectionManager? cm]) : _connectionManager = cm ?? ConnectionManager();
  
  /// 获取 CPU 使用率
  Future<double> getCpuUsage() async {
    try {
      // 从 /proc/stat 读取 CPU 信息
      final stat = await File('/proc/stat').readAsString();
      final lines = stat.split('\n');
      final cpuLine = lines.firstWhere((l) => l.startsWith('cpu '));
      
      // 简单解析 (实际需要计算差值)
      final parts = cpuLine.split(RegExp(r'\s+'));
      final total = parts.sublist(1).map((s) => int.parse(s)).reduce((a, b) => a + b);
      
      return total > 0 ? (total - int.parse(parts[4])) / total * 100 : 0;
    } catch (e) {
      return 0;
    }
  }

  /// 获取内存使用
  Future<MemoryInfo> getMemoryUsage() async {
    try {
      final meminfo = await File('/proc/meminfo').readAsString();
      final lines = meminfo.split('\n');
      
      int parseMem(String key) {
        final line = lines.firstWhere((l) => l.startsWith(key), orElse: () => '');
        final match = RegExp(r'(\d+)').firstMatch(line);
        return match != null ? int.parse(match.group(1)!) * 1024 : 0;
      }
      
      final total = parseMem('MemTotal:');
      final free = parseMem('MemAvailable:');
      final used = total - free;
      final percentage = total > 0 ? (used / total) * 100 : 0;
      
      return MemoryInfo(
        total: total,
        used: used,
        free: free,
        percentage: percentage,
      );
    } catch (e) {
      return MemoryInfo(total: 0, used: 0, free: 0, percentage: 0);
    }
  }

  /// 获取存储使用
  Future<StorageInfo> getStorageUsage() async {
    try {
      final result = await Process.run('df', ['-B1', '/']);
      final lines = result.stdout.toString().split('\n');
      if (lines.length < 2) {
        return StorageInfo(total: 0, used: 0, free: 0, percentage: 0);
      }
      
      final parts = lines[1].split(RegExp(r'\s+'));
      final total = int.parse(parts[1]);
      final used = int.parse(parts[2]);
      final free = int.parse(parts[3]);
      final percentage = total > 0 ? (used / total) * 100 : 0;
      
      return StorageInfo(
        total: total,
        used: used,
        free: free,
        percentage: percentage,
      );
    } catch (e) {
      return StorageInfo(total: 0, used: 0, free: 0, percentage: 0);
    }
  }

  /// 获取网络状态
  Future<NetworkStatus> getNetworkStatus() async {
    try {
      // 简化实现
      return NetworkStatus(
        connectionType: 'dhcp',
        ipAddress: await _getLocalIp(),
        isConnected: true,
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
    final interfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
      includeLoopback: false,
    );
    
    for (final interface in interfaces) {
      for (final addr in interface.addresses) {
        if (!addr.isLoopback && addr.type == InternetAddressType.IPv4) {
          return addr.address;
        }
      }
    }
    return null;
  }
}

import 'dart:convert';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';