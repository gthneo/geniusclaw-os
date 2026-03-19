/// ========================================
/// GC OS MVP 客户端 - 简化测试
/// ========================================

import 'package:flutter_test/flutter_test.dart';
import 'package:geniusclaw_app/src/models/models.dart';
import 'package:geniusclaw_app/src/services/mvp_services.dart';

void main() {
  
  group('DeviceInfo Model', () {
    test('should create from JSON', () {
      final json = {
        'id': 'test-001',
        'name': 'Test Device',
        'ip': '192.168.1.100',
        'port': 18790,
        'status': 'online',
      };
      
      final device = DeviceInfo.fromJson(json);
      
      expect(device.id, 'test-001');
      expect(device.name, 'Test Device');
      expect(device.ip, '192.168.1.100');
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
    });
  });
  
  group('ChatMessage Model', () {
    test('should create message', () {
      final message = ChatMessage(
        id: 'msg-001',
        content: 'Hello',
        sender: 'user',
        timestamp: DateTime(2026, 3, 19),
        type: MessageType.text,
      );
      
      expect(message.content, 'Hello');
      expect(message.type, MessageType.text);
    });
  });
  
  group('DiscoveryService', () {
    test('should be instantiable', () {
      final service = DiscoveryService();
      expect(service, isNotNull);
    });
    
    test('discover returns Future', () {
      final service = DiscoveryService();
      final result = service.discover();
      expect(result, isA<Future<List<DeviceInfo>>>());
    });
  });
  
  group('ConnectionManager', () {
    test('should start disconnected', () {
      final manager = ConnectionManager();
      expect(manager.isConnected, false);
    });
    
    test('connect returns Future<bool>', () {
      final manager = ConnectionManager();
      expect(manager.connect('localhost', 18790), isA<Future<bool>>());
    });
  });
  
  group('MessageChannel', () {
    test('should be instantiable', () {
      final manager = ConnectionManager();
      final channel = MessageChannel(manager);
      expect(channel, isNotNull);
    });
  });
  
  group('DeviceState', () {
    test('should be instantiable', () {
      final state = DeviceState();
      expect(state, isNotNull);
    });
    
    test('getCpuUsage returns Future<double>', () {
      final state = DeviceState();
      expect(state.getCpuUsage(), isA<Future<double>>());
    });
    
    test('getMemoryUsage returns Future<MemoryInfo>', () {
      final state = DeviceState();
      expect(state.getMemoryUsage(), isA<Future<MemoryInfo>>());
    });
    
    test('getAllStatus returns Future<Map>', () {
      final state = DeviceState();
      expect(state.getAllStatus(), isA<Future<Map<String, dynamic>>>());
    });
  });
  
  group('Exceptions', () {
    test('DiscoveryException', () {
      final e = DiscoveryException('test');
      expect(e.message, 'test');
    });
    
    test('NotConnectedException', () {
      final e = NotConnectedException('test');
      expect(e.message, 'test');
    });
  });
}