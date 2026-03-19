import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/device.dart';
import '../services/ha_service.dart';

/// HA 服务提供者
final haServiceProvider = Provider((ref) => HAService());

/// 设备列表
final devicesProvider = FutureProvider<List<Device>>((ref) async {
  final service = ref.read(haServiceProvider);
  return service.getDevices();
});

/// 设备分组（按域）
final groupedDevicesProvider = Provider<Map<String, List<Device>>>((ref) {
  final asyncDevices = ref.watch(devicesProvider);
  return asyncDevices.when(
    data: (devices) {
      final grouped = <String, List<Device>>{};
      for (final device in devices) {
        grouped.putIfAbsent(device.domain, () => []).add(device);
      }
      return grouped;
    },
    loading: () => {},
    error: (_, __) => {},
  );
});

/// 灯光设备
final lightsProvider = Provider<List<Device>>((ref) {
  final grouped = ref.watch(groupedDevicesProvider);
  return grouped['light'] ?? [];
});

/// 开关设备
final switchesProvider = Provider<List<Device>>((ref) {
  final grouped = ref.watch(groupedDevicesProvider);
  return grouped['switch'] ?? [];
});

/// 空调设备
final climatesProvider = Provider<List<Device>>((ref) {
  final grouped = ref.watch(groupedDevicesProvider);
  return grouped['climate'] ?? [];
});

/// 设备控制服务
class DeviceController extends StateNotifier<AsyncValue<void>> {
  final HAService _service;
  final Ref _ref;

  DeviceController(this._service, this._ref) : super(const AsyncValue.data(null));

  /// 切换灯光
  Future<void> toggleLight(String entityId, bool on) async {
    state = const AsyncValue.loading();
    try {
      await _service.toggleLight(entityId, on);
      // 刷新设备列表
      _ref.invalidate(devicesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 切换开关
  Future<void> toggleSwitch(String entityId, bool on) async {
    state = const AsyncValue.loading();
    try {
      await _service.toggleSwitch(entityId, on);
      _ref.invalidate(devicesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 设置温度
  Future<void> setTemperature(String entityId, double temp) async {
    state = const AsyncValue.loading();
    try {
      await _service.setTemperature(entityId, temp);
      _ref.invalidate(devicesProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final deviceControllerProvider = StateNotifierProvider<DeviceController, AsyncValue<void>>((ref) {
  return DeviceController(ref.read(haServiceProvider), ref);
});