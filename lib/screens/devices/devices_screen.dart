import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../providers/device_provider.dart';

/// 设备控制页面
class DevicesScreen extends ConsumerWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devicesAsync = ref.watch(devicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('📱 设备控制'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(devicesProvider),
          ),
        ],
      ),
      body: devicesAsync.when(
        data: (devices) {
          if (devices.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('📱', style: TextStyle(fontSize: 64)),
                  SizedBox(height: 16),
                  Text('未发现设备'),
                  SizedBox(height: 8),
                  Text(
                    '请确保 HomeAssistant 已连接',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          
          // 按域分组
          final grouped = <String, List<dynamic>>{};
          for (final device in devices) {
            grouped.putIfAbsent(device.domain, () => []).add(device);
          }
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 灯光
              if (grouped.containsKey('light'))
                _buildSection(context, ref, '💡 灯光', grouped['light']!),
              // 开关
              if (grouped.containsKey('switch'))
                _buildSection(context, ref, '🔌 开关', grouped['switch']!),
              // 空调
              if (grouped.containsKey('climate'))
                _buildSection(context, ref, '🌡️ 空调', grouped['climate']!),
              // 传感器
              if (grouped.containsKey('sensor'))
                _buildSection(context, ref, '📊 传感器', grouped['sensor']!),
              // 其他
              for (final entry in grouped.entries)
                if (!['light', 'switch', 'climate', 'sensor'].contains(entry.key))
                  _buildSection(context, ref, entry.key, entry.value),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('错误: $e'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, WidgetRef ref, String title, List devices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final device = devices[index];
            return _DeviceCard(
              device: device,
              onToggle: (on) {
                if (device.domain == 'light') {
                  ref.read(deviceControllerProvider.notifier)
                      .toggleLight(device.id, on);
                } else if (device.domain == 'switch') {
                  ref.read(deviceControllerProvider.notifier)
                      .toggleSwitch(device.id, on);
                }
              },
            );
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final dynamic device;
  final Function(bool) onToggle;

  const _DeviceCard({
    required this.device,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isOn = device.isOn;

    return Card(
      child: InkWell(
        onTap: () => onToggle(!isOn),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    device.icon,
                    size: 28,
                    color: isOn ? AppTheme.primaryColor : Colors.grey,
                  ),
                  Switch(
                    value: isOn,
                    onChanged: onToggle,
                    activeColor: AppTheme.primaryColor,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    device.state,
                    style: TextStyle(
                      fontSize: 12,
                      color: isOn ? AppTheme.primaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}