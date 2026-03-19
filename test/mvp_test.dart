/// ========================================
/// GC OS MVP 客户端 - 测试代码
/// 
/// TDD 开发模式：先写测试，再写代码
/// ========================================

import 'package:flutter_test/flutter_test';
import 'package:geniusclaw_app/src/models/models.dart';
import 'package:geniusclaw_app/src/services/services.dart';

void main() {
  
  // ========================================
  // 模型层测试 (Models)
  // ========================================
  
  group('DeviceInfo Model', () {
    test('should create from JSON', () {
      final json = {
        'id': 'test-001',
        'name': 'Test Device',
        'ip': '192.168.1.100',
        'port': 18790,
        'status': 'online',
        'lastSeen': '2026-03-19T12:00:00.000Z',
      };
      
      final device = DeviceInfo.fromJson(json);
      
      expect(device.id, 'test-001');
      expect(device.name, 'Test Device');
      expect(device.ip, '192.168.1.100');
      expect(device.port, 18790);
      expect(device.status, 'online');
    });
    
    test('should convert to JSON', () {
      final device = DeviceInfo(
        id: 'test-001',
        name: 'Test Device',
        ip: '192.168.1.100',
        port: 18790,
        status: 'online',
      );
      
      final json = device.toJson();
      
      expect(json['id'], 'test-001');
      expect(json['name'], 'Test Device');
      expect(json['ip'], '192.168.1.100');
    });
  });
  
  group('ChatMessage Model', () {
    test('should create text message', () {
      final message = ChatMessage(
        id: 'msg-001',
        content: 'Hello',
        sender: 'user',
        timestamp: DateTime(2026, 3, 19, 12, 0, 0),
        type: MessageType.text,
      );
      
      expect(message.content, 'Hello');
      expect(message.sender, 'user');
      expect(message.type, MessageType.text);
    });
    
    test('should serialize to JSON', () {
      final message = ChatMessage(
        id: 'msg-001',
        content: 'Test',
        sender: 'bot',
        timestamp: DateTime(2026, 3, 19, 12, 0, 0),
        type: MessageType.text,
      );
      
      final json = message.toJson();
      
      expect(json['content'], 'Test');
      expect(json['sender'], 'bot');
      expect(json['type'], 'text');
    });
  });
  
  // ========================================
  // 服务层测试 (Services)
  // ========================================
  
  group('DiscoveryService', () {
    late DiscoveryService discoveryService;
    
    setUp(() {
      discoveryService = DiscoveryService();
    });
    
    test('should have service type configured', () {
      // 这是一个简单的存在性测试
      expect(discoveryService, isNotNull);
    });
    
    test('discover method should return List<DeviceInfo>', () async {
      // 这个测试验证方法签名
      // 实际实现会扫描网络
      final result = discoveryService.discover();
      
      expect(result, isA<Future<List<DeviceInfo>>>());
    });
    
    test('addManual should accept IP and port', () async {
      // 验证方法签名
      final result = discoveryService.addManual('192.168.1.100', 18790);
      
      expect(result, isA<Future<DeviceInfo>>());
    });
  });
  
  group('ConnectionManager', () {
    late ConnectionManager connectionManager;
    
    setUp(() {
      connectionManager = ConnectionManager();
    });
    
    test('should start with isConnected = false', () {
      expect(connectionManager.isConnected, false);
    });
    
    test('should have connect method', () {
      expect(connectionManager.connect('localhost', 18790), 
        isA<Future<bool>>());
    });
    
    test('should have disconnect method', () async {
      // 先确保已连接才能断开
      await connectionManager.connect('localhost', 18790);
      expect(connectionManager.disconnect(), isA<Future<void>>());
    });
    
    test('should have send method', () {
      final result = connectionManager.send({'test': 'data'});
      expect(result, isA<Future<bool>>());
    });
    
    test('should have onMessage stream', () {
      expect(connectionManager.onMessage, isA<Stream<Map<String, dynamic>>>());
    });
  });
  
  group('MessageChannel', () {
    late MessageChannel messageChannel;
    late ConnectionManager connectionManager;
    
    setUp(() {
      connectionManager = ConnectionManager();
      messageChannel = MessageChannel(connectionManager);
    });
    
    test('should have connect method', () {
      expect(messageChannel.connect('localhost', 18790), 
        isA<Future<bool>>());
    });
    
    test('should have send method', () {
      expect(messageChannel.send('test message'), 
        isA<Future<bool>>());
    });
    
    test('should have messageStream', () {
      expect(messageChannel.messageStream, 
        isA<Stream<ChatMessage>>());
    });
    
    test('should have dispose method', () {
      expect(messageChannel.dispose, isA<Function>());
    });
  });
  
  group('DeviceState', () {
    late DeviceState deviceState;
    
    setUp(() {
      deviceState = DeviceState();
    });
    
    test('should have getCpuUsage method', () {
      expect(deviceState.getCpuUsage(), isA<Future<double>>());
    });
    
    test('should have getMemoryUsage method', () {
      expect(deviceState.getMemoryUsage(), isA<Future<MemoryInfo>>());
    });
    
    test('should have getStorageUsage method', () {
      expect(deviceState.getStorageUsage(), isA<Future<StorageInfo>>());
    });
    
    test('should have getNetworkStatus method', () {
      expect(deviceState.getNetworkStatus(), isA<Future<NetworkStatus>>());
    });
    
    test('should have getAllStatus method', () {
      final result = deviceState.getAllStatus();
      expect(result, isA<Future<Map<String, dynamic>>>());
    });
  });
  
  // ========================================
  // 异常测试 (Exceptions)
  // ========================================
  
  group('Exceptions', () {
    test('DiscoveryException should have message', () {
      final exception = DiscoveryException('Test error');
      expect(exception.message, 'Test error');
      expect(exception.toString(), contains('DiscoveryException'));
    });
    
    test('DiscoveryTimeoutException should be throwable', () {
      expect(() => throw DiscoveryTimeoutException(), 
        throwsA(isA<Exception>()));
    });
    
    test('NotConnectedException should have message', () {
      final exception = NotConnectedException('Not connected');
      expect(exception.message, 'Not connected');
    });
  });
  
  // ========================================
  // 集成测试 (Integration)
  // ========================================
  
  group('Integration: Full Connection Flow', () {
    late ConnectionManager connectionManager;
    late MessageChannel messageChannel;
    late DeviceState deviceState;
    
    setUp(() {
      connectionManager = ConnectionManager();
      messageChannel = MessageChannel(connectionManager);
      deviceState = DeviceState(connectionManager);
    });
    
    test('should connect and get device status', () async {
      // 这个测试模拟完整流程
      // 1. 连接
      final connected = await connectionManager.connect('192.168.1.100', 18790);
      
      // 连接可能失败（如果没有服务器），但API应该工作
      expect(connected, isA<bool>());
      
      // 2. 获取状态
      final status = await deviceState.getAllStatus();
      expect(status, isA<Map<String, dynamic>>());
      expect(status.containsKey('cpu'), true);
      expect(status.containsKey('memory'), true);
      expect(status.containsKey('storage'), true);
      expect(status.containsKey('network'), true);
    });
    
    test('should handle send message when not connected', () async {
      // 未连接时发送消息应该抛出异常
      expect(
        () => messageChannel.send('test'),
        throwsA(isA<NotConnectedException>()),
      );
    });
  });
}