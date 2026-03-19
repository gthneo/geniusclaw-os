import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/file_item.dart';

/// NAS 文件服务
class NASService {
  late final Dio _dio;

  NASService() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.nasUrl,
      connectTimeout: const Duration(seconds: 30),
    ));
  }

  /// 更新 NAS 配置
  void updateConfig(String url, String username, String password) {
    ApiConfig.nasUrl = url;
    ApiConfig.nasUsername = username;
    ApiConfig.nasPassword = password;
    _dio.options.baseUrl = url;
    // 如果需要认证，在这里设置
  }

  /// 列出文件
  Future<List<FileItem>> listFiles(String path) async {
    try {
      // 这里使用示例 API，实际需要根据后端接口调整
      final response = await _dio.get('/api/files', queryParameters: {'path': path});
      final List<dynamic> data = response.data['files'] ?? [];
      return data.map((e) => FileItem.fromJson(e)).toList();
    } on DioException catch (e) {
      throw '获取文件列表失败: ${e.message}';
    }
  }

  /// 上传文件
  Future<void> uploadFile(String localPath, String remotePath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(localPath),
        'path': remotePath,
      });
      await _dio.post('/api/files/upload', data: formData);
    } on DioException catch (e) {
      throw '上传文件失败: ${e.message}';
    }
  }

  /// 下载文件
  Future<void> downloadFile(String remotePath, String localPath) async {
    try {
      await _dio.download(
        '/api/files/download',
        localPath,
        queryParameters: {'path': remotePath},
      );
    } on DioException catch (e) {
      throw '下载文件失败: ${e.message}';
    }
  }

  /// 删除文件
  Future<void> deleteFile(String path) async {
    try {
      await _dio.delete('/api/files', data: {'path': path});
    } on DioException catch (e) {
      throw '删除文件失败: ${e.message}';
    }
  }

  /// 创建文件夹
  Future<void> createFolder(String path, String name) async {
    try {
      await _dio.post('/api/files/folder', data: {
        'path': path,
        'name': name,
      });
    } on DioException catch (e) {
      throw '创建文件夹失败: ${e.message}';
    }
  }
}