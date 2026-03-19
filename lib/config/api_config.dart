/// API 配置
class ApiConfig {
  // 默认配置（可通过设置页面修改）
  static String defaultHost = '192.168.1.100';
  static String defaultPort = '8080';
  
  // 基础 URL
  static String get baseUrl => 'http://$defaultHost:$defaultPort/api';
  
  // WebSocket URL
  static String get wsUrl => 'ws://$defaultHost:$defaultPort/ws';
  
  // 更新连接配置
  static void updateHost(String host, String port) {
    defaultHost = host;
    defaultPort = port;
  }
  
  // HA (HomeAssistant) 配置
  static String haUrl = 'http://192.168.1.101:8123';
  static String haToken = '';
  
  // NAS 配置
  static String nasUrl = 'smb://192.168.1.102/nas';
  static String nasUsername = '';
  static String nasPassword = '';
}