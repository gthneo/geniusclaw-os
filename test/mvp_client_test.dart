import 'package:flutter_test/flutter_test';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([DiscoveryService, WebSocketClient])
import 'discovery_test.mocks.dart';

@GenerateMocks([WebSocketClient])
import 'connection_test.mocks.dart';

/// ========================================
/// MVP 客户端 - 测试用例 (TDD)
/// ========================================

/// 测试组: 设备发现服务 (DiscoveryService)
/// 
/// 功能: 局域网自动发现 OpenClaw 节点
/// 技术: mDNS/Bonjour
group('DiscoveryService Tests', () {
  
  /// 用例: 成功发现设备
  test('should discover OpenClaw node in LAN', () async {
    // Arrange
    final mockClient = MockDiscoveryService();
    when(mockClient.discover()).thenAnswer(
      (_) async => [
        DeviceInfo(
          id: 'openclaw-001',
          name: 'GeniusClaw',
          ip: '192.168.1.100',
          port: 18790,
          status: 'online',
        )
      ],
    );
    
    // Act
    final devices = await mockClient.discover();
    
    // Assert
    expect(devices.length, 1);
    expect(devices.first.name, 'GeniusClaw');
    expect(devices.first.ip, '192.168.1.100');
  });
  
  /// 用例: 发现多个设备
  test('should discover multiple devices', () async {
    final mockClient = MockDiscoveryService();
    when(mockClient.discover()).thenAnswer(
      (_) async => [
        DeviceInfo(id: '1', name: 'GC-1', ip: '192.168.1.10', port: 18790, status: 'online'),
        DeviceInfo(id: '2', name: 'GC-2', ip: '192.168.1.20', port: 18790, status: 'online'),
        DeviceInfo(id: '3', name: 'GC-3', ip: '192.168.1.30', port: 18790, status: 'offline'),
      ],
    );
    
    final devices = await mockClient.discover();
    
    expect(devices.length, 3);
    expect(devices.where((d) => d.status == 'online').length, 2);
  });
  
  /// 用例: 无设备发现
  test('should return empty list when no devices', () async {
    final mockClient = MockDiscoveryService();
    when(mockClient.discover()).thenAnswer((_) async => []);
    
    final devices = await mockClient.discover();
    
    expect(devices, isEmpty);
  });
  
  /// 用例: 手动添加设备
  test('should add device manually by IP', () async {
    final mockClient = MockDiscoveryService();
    when(mockClient.addManual('192.168.1.200', 18790)).thenAnswer(
      (_) async => DeviceInfo(
        id: 'manual-001',
        name: 'Manual-GC',
        ip: '192.168.1.200',
        port: 18790,
        status: 'online',
      ),
    );
    
    final device = await mockClient.addManual('192.168.1.200', 18790);
    
    expect(device.ip, '192.168.1.200');
    expect(device.name, 'Manual-GC');
  });
  
  /// 用例: 发现超时
  test('should timeout after 3 seconds', () async {
    final mockClient = MockDiscoveryService();
    when(mockClient.discover()).thenAnswer(
      (_) => Future.delayed(
        const Duration(seconds: 5),
        () => throw DiscoveryTimeoutException(),
      ),
    );
    
    expect(
      () => mockClient.discover(),
      throwsA(isA<DiscoveryTimeoutException>()),
    );
  });
});

/// 测试组: 连接管理 (ConnectionManager)
group('ConnectionManager Tests', () {
  
  /// 用例: 成功连接
  test('should connect to OpenClaw successfully', () async {
    final mockWs = MockWebSocketClient();
    when(mockWs.connect('ws://192.168.1.100:18790/ws')).thenAnswer((_) async => true);
    
    final manager = ConnectionManager(webSocketClient: mockWs);
    final result = await manager.connect('192.168.1.100', 18790);
    
    expect(result, true);
    expect(manager.isConnected, true);
  });
  
  /// 用例: 连接失败
  test('should handle connection failure', () async {
    final mockWs = MockWebSocketClient();
    when(mockWs.connect(any)).thenAnswer((_) async => false);
    
    final manager = ConnectionManager(webSocketClient: mockWs);
    final result = await manager.connect('192.168.1.100', 18790);
    
    expect(result, false);
    expect(manager.isConnected, false);
  });
  
  /// 用例: 断开连接
  test('should disconnect properly', () async {
    final mockWs = MockWebSocketClient();
    when(mockWs.connect(any)).thenAnswer((_) async => true);
    when(mockWs.disconnect()).thenAnswer((_) async {});
    
    final manager = ConnectionManager(webSocketClient: mockWs);
    await manager.connect('192.168.1.100', 18790);
    await manager.disconnect();
    
    expect(manager.isConnected, false);
    verify(mockWs.disconnect()).called(1);
  });
  
  /// 用例: 心跳保活
  test('should send heartbeat every 30 seconds', () async {
    final mockWs = MockWebSocketClient();
    when(mockWs.connect(any)).thenAnswer((_) async => true);
    when(mockWs.send({'type': 'ping'})).thenAnswer((_) async {});
    
    final manager = ConnectionManager(webSocketClient: mockWs);
    await manager.connect('192.168.1.100', 18790);
    
    // Simulate heartbeat
    await manager.sendHeartbeat();
    
    verify(mockWs.send({'type': 'ping'})).called(1);
  });
  
  /// 用例: 自动重连
  test('should auto-reconnect on disconnect', () async {
    final mockWs = MockWebSocketClient();
    when(mockWs.connect(any)).thenAnswer((_) async => true);
    when(mockWs.onDisconnect).thenAnswer(
      (_) => Stream.periodic(const Duration(seconds: 1)).map((_) => true),
    );
    
    final manager = ConnectionManager(webSocketClient: mockWs);
    await manager.connect('192.168.1.100', 18790);
    
    // Wait for disconnect event
    await Future.delayed(const Duration(seconds: 2));
    
    // Should attempt reconnect
    verify(mockWs.connect(any)).called(greaterThan(1));
  });
});

/// 测试组: 消息通道 (MessageChannel)
group('MessageChannel Tests', () {
  
  /// 用例: 发送消息
  test('should send message successfully', () async {
    final mockWs = MockWebSocketClient();
    when(mockWs.connect(any)).thenAnswer((_) async => true);
    when(mockWs.send(any)).thenAnswer((_) async => true);
    
    final channel = MessageChannel(mockWs);
    await channel.connect('192.168.1.100', 18790);
    
    final result = await channel.send('Hello OpenClaw');
    
    expect(result, true);
    verify(mockWs.send(any)).called(1);
  });
  
  /// 用例: 接收消息
  test('should receive message', () async {
    final mockWs = MockWebSocketClient();
    when(mockWs.connect(any)).thenAnswer((_) async => true);
    when(mockWs.onMessage).thenAnswer(
      (_) => Stream.value({
        'type': 'message',
        'content': 'Hello from OpenClaw',
        'from': 'bot',
      }),
    );
    
    final channel = MessageChannel(mockWs);
    await channel.connect('192.168.1.100', 18790);
    
    final messages = await channel.messageStream.first;
    
    expect(messages['content'], 'Hello from OpenClaw');
  });
  
  /// 用例: 未连接时发送消息
  test('should throw when sending without connection', () async {
    final mockWs = MockWebSocketClient();
    final channel = MessageChannel(mockWs);
    
    expect(
      () => channel.send('test'),
      throwsA(isA<NotConnectedException>()),
    );
  });
});

/// 测试组: 设备状态 (DeviceState)
group('DeviceState Tests', () {
  
  /// 用例: 获取 CPU 使用率
  test('should get CPU usage', () async {
    final state = DeviceState();
    
    final cpu = await state.getCpuUsage();
    
    expect(cpu, greaterThanOrEqualTo(0));
    expect(cpu, lessThanOrEqualTo(100));
  });
  
  /// 用例: 获取内存使用
  test('should get memory usage', () async {
    final state = DeviceState();
    
    final memory = await state.getMemoryUsage();
    
    expect(memory.total, greaterThan(0));
    expect(memory.used, greaterThanOrEqualTo(0));
    expect(memory.percentage, greaterThanOrEqualTo(0));
  });
  
  /// 用例: 获取存储使用
  test('should get storage usage', () async {
    final state = DeviceState();
    
    final storage = await state.getStorageUsage();
    
    expect(storage.total, greaterThan(0));
    expect(storage.used, greaterThanOrEqualTo(0));
  });
  
  /// 用例: 获取设备列表
  test('should get all device status', () async {
    final state = DeviceState();
    
    final status = await state.getAllStatus();
    
    expect(status.containsKey('cpu'), true);
    expect(status.containsKey('memory'), true);
    expect(status.containsKey('storage'), true);
    expect(status.containsKey('network'), true);
  });
});