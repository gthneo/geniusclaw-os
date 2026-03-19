import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/device.dart';

/// HomeAssistant 服务
class HAService {
  late final Dio _dio;

  HAService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.haUrl,
      connectTimeout: const Duration(seconds: 10),
      headers: {
        'Authorization': 'Bearer ${ApiConfig.haToken}',
        'Content-Type': 'application/json',
      },
    ));
  }

  /// 更新 HA 配置
  void updateConfig(String url, String token) {
    ApiConfig.haUrl = url;
    ApiConfig.haToken = token;
    _dio.options.baseUrl = url;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// 获取所有设备
  Future<List<Device>> getDevices() async {
    try {
      final response = await _dio.get('/api/states');
      final List<dynamic> data = response.data;
      return data
          .map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 获取特定域的设备
  Future<List<Device>> getDevicesByDomain(String domain) async {
    final devices = await getDevices();
    return devices.where((d) => d.domain == domain).toList();
  }

  /// 调用服务
  Future<void> callService(String domain, String service, 
      {String? entityId, Map<String, dynamic>? data}) async {
    try {
      final payload = {
        if (entityId != null) 'entity_id': entityId,
        ...?data,
      };
      await _dio.post('/api/services/$domain/$service', data: payload);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 开关灯
  Future<void> toggleLight(String entityId, bool on) async {
    final service = on ? 'turn_on' : 'turn_off';
    await callService('light', service, entityId: entityId);
  }

  /// 开关插座
  Future<void> toggleSwitch(String entityId, bool on) async {
    final service = on ? 'turn_on' : 'turn_off';
    await callService('switch', service, entityId: entityId);
  }

  /// 设置温度
  Future<void> setTemperature(String entityId, double temp) async {
    await callService('climate', 'set_temperature', 
        entityId: entityId, data: {'temperature': temp});
  }

  /// 获取实体状态
  Future<Device> getEntity(String entityId) async {
    try {
      final response = await _dio.get('/api/states/$entityId');
      return Device.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      return 'HA 认证失败，请检查 Token';
    }
    if (e.type == DioExceptionType.connectionError) {
      return '无法连接到 HomeAssistant';
    }
    return 'HA 错误: ${e.message}';
  }
}