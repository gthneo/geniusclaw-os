/// API 配置
class ApiConfig {
  static const String kDefaultHost = '192.168.31.156';
  static const String kDefaultPort = '18790';
  static const String kRestApiPort = '8080';
  
  static String defaultHost = kDefaultHost;
  static String defaultPort = kDefaultPort;
  
  static String get baseUrl => 'http://$defaultHost:$kRestApiPort/api';
  
  static String get wsUrl => 'ws://$defaultHost:$defaultPort/ws';
  
  static void updateHost(String host, String port) {
    defaultHost = host;
    defaultPort = port;
  }
  
  static void resetToDefault() {
    defaultHost = kDefaultHost;
    defaultPort = kDefaultPort;
  }
  
  static String haUrl = 'http://192.168.1.101:8123';
  static String haToken = '';
  
  static String nasUrl = 'smb://192.168.1.102/nas';
  static String nasUsername = '';
  static String nasPassword = '';
}

/// IP 地址验证工具
class IpValidator {
  static final RegExp _ipRegex = RegExp(
    r'^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}$',
  );
  
  static bool isValidIp(String ip) {
    return _ipRegex.hasMatch(ip);
  }
  
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入 IP 地址';
    }
    if (!isValidIp(value)) {
      return 'IP 地址格式无效';
    }
    return null;
  }
}

/// 端口验证工具
class PortValidator {
  static bool isValidPort(String port) {
    final p = int.tryParse(port);
    return p != null && p >= 1 && p <= 65535;
  }
  
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入端口号';
    }
    if (!isValidPort(value)) {
      return '端口号无效 (1-65535)';
    }
    return null;
  }
}
