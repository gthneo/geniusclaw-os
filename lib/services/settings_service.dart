/// 本地设置服务 - 持久化存储
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class SettingsService {
  static const String _keyHost = 'openclaw_host';
  static const String _keyPort = 'openclaw_port';
  static const String _keyDeviceList = 'device_list';
  
  SharedPreferences? _prefs;
  
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  /// 获取保存的 Host
  String getSavedHost() {
    return _prefs?.getString(_keyHost) ?? ApiConfig.kDefaultHost;
  }
  
  /// 获取保存的 Port
  String getSavedPort() {
    return _prefs?.getString(_keyPort) ?? ApiConfig.kDefaultPort;
  }
  
  /// 保存 Host 和 Port
  Future<bool> saveHost(String host, String port) async {
    await _prefs?.setString(_keyHost, host);
    await _prefs?.setString(_keyPort, port);
    ApiConfig.updateHost(host, port);
    return true;
  }
  
  /// 获取保存的设备列表
  List<String> getSavedDevices() {
    return _prefs?.getStringList(_keyDeviceList) ?? [];
  }
  
  /// 保存设备列表
  Future<bool> saveDevices(List<String> devices) async {
    await _prefs?.setStringList(_keyDeviceList, devices);
    return true;
  }
  
  /// 添加设备到列表
  Future<bool> addDevice(String deviceJson) async {
    final devices = getSavedDevices();
    if (!devices.contains(deviceJson)) {
      devices.add(deviceJson);
      await saveDevices(devices);
    }
    return true;
  }
  
  /// 清除所有设置
  Future<bool> clear() async {
    await _prefs?.clear();
    ApiConfig.resetToDefault();
    return true;
  }
}
