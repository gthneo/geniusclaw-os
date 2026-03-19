import 'package:flutter/material.dart';

/// 设备模型
class Device {
  final String id;
  final String name;
  final String domain; // light, switch, climate, sensor
  final String state;
  final Map<String, dynamic> attributes;
  final bool isOnline;

  Device({
    required this.id,
    required this.name,
    required this.domain,
    required this.state,
    this.attributes = const {},
    this.isOnline = true,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['entity_id'] ?? json['id'] ?? '',
      name: json['attributes']?['friendly_name'] ?? json['name'] ?? '',
      domain: json['entity_id']?.split('.')[0] ?? '',
      state: json['state'] ?? 'unknown',
      attributes: json['attributes'] ?? {},
      isOnline: json['state'] != 'unavailable',
    );
  }

  bool get isOn => state == 'on' || state == 'playing' || state == 'heat';

  IconData get icon {
    switch (domain) {
      case 'light':
        return isOn ? Icons.lightbulb : Icons.lightbulb_outline;
      case 'switch':
        return isOn ? Icons.toggle_on : Icons.toggle_off;
      case 'climate':
        return Icons.thermostat;
      case 'sensor':
        return Icons.sensors;
      case 'camera':
        return Icons.videocam;
      default:
        return Icons.device_hub;
    }
  }
}