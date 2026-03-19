import 'package:dio/dio.dart';
import '../config/api_config.dart';

/// OpenClaw API 服务
class OpenClawService {
  late final Dio _dio;

  OpenClawService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  /// 更新基础 URL
  void updateBaseUrl(String host, String port) {
    ApiConfig.updateHost(host, port);
  }

  /// 发送聊天消息
  Future<String> sendMessage(String message) async {
    try {
      final response = await _dio.post('/chat', data: {'message': message});
      return response.data['reply'] ?? '无法获取回复';
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 获取系统状态
  Future<Map<String, dynamic>> getStatus() async {
    try {
      final response = await _dio.get('/status');
      return response.data ?? {};
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 获取技能列表
  Future<List<dynamic>> getSkills() async {
    try {
      final response = await _dio.get('/skills');
      return response.data['skills'] ?? [];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 安装技能
  Future<bool> installSkill(String skillId) async {
    try {
      final response = await _dio.post('/skills/install', data: {'id': skillId});
      return response.data['success'] ?? false;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 卸载技能
  Future<bool> uninstallSkill(String skillId) async {
    try {
      final response = await _dio.post('/skills/uninstall', data: {'id': skillId});
      return response.data['success'] ?? false;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 获取可用模型列表
  Future<List<dynamic>> getModels() async {
    try {
      final response = await _dio.get('/models');
      return response.data['models'] ?? [];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 切换模型
  Future<bool> switchModel(String modelId) async {
    try {
      final response = await _dio.post('/models/switch', data: {'model': modelId});
      return response.data['success'] ?? false;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return '连接超时，请检查网络';
      case DioExceptionType.connectionError:
        return '无法连接到服务器，请检查 GC OS 是否在线';
      case DioExceptionType.badResponse:
        return '服务器错误: ${e.response?.statusCode}';
      default:
        return '网络错误: ${e.message}';
    }
  }
}