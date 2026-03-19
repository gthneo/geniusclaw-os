/// ========================================
/// MVP 客户端 - 连接首页
/// 
/// 功能: 自动发现 + 手动连接 OpenClaw
/// ========================================

import 'package:flutter/material.dart';
import '../services/mvp_services.dart';
import '../models/models.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  final DiscoveryService _discoveryService = DiscoveryService();
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController(text: '18790');
  
  List<DeviceInfo> _devices = [];
  bool _isLoading = false;
  bool _isConnecting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _discoverDevices();
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    _discoveryService.dispose();
    super.dispose();
  }

  /// 发现设备
  Future<void> _discoverDevices() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final devices = await _discoveryService.discover();
      setState(() {
        _devices = devices;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  /// 手动添加设备
  Future<void> _addManualDevice() async {
    final ip = _ipController.text.trim();
    final port = int.tryParse(_portController.text) ?? 18790;

    if (ip.isEmpty) {
      _showError('请输入 IP 地址');
      return;
    }

    setState(() {
      _isConnecting = true;
      _error = null;
    });

    try {
      final device = await _discoveryService.addManual(ip, port);
      setState(() {
        // 添加到列表
        if (!_devices.any((d) => d.ip == device.ip)) {
          _devices.add(device);
        }
        _isConnecting = false;
      });
      _showSuccess('设备添加成功');
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isConnecting = false;
      });
    }
  }

  /// 连接设备
  Future<void> _connectToDevice(DeviceInfo device) async {
    setState(() {
      _isConnecting = true;
      _error = null;
    });

    try {
      final connectionManager = ConnectionManager();
      final success = await connectionManager.connect(device.ip, device.port);

      if (success) {
        _showSuccess('已连接到 ${device.name}');
        // TODO: 跳转到主界面
      } else {
        _showError('连接失败');
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isConnecting = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('连接 OpenClaw'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _discoverDevices,
          ),
        ],
      ),
      body: Column(
        children: [
          // 手动添加区域
          _buildManualAddSection(),
          
          const Divider(),
          
          // 设备列表
          Expanded(
            child: _buildDeviceList(),
          ),
        ],
      ),
    );
  }

  Widget _buildManualAddSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '手动添加设备',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _ipController,
                  decoration: const InputDecoration(
                    labelText: 'IP 地址',
                    hintText: '例如: 192.168.1.100',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.computer),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _portController,
                  decoration: const InputDecoration(
                    labelText: '端口',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _isConnecting ? null : _addManualDevice,
                icon: _isConnecting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.add),
                label: const Text('添加'),
              ),
            ],
          ),
          
          // 错误提示
          if (_error != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDeviceList() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在搜索设备...'),
          ],
        ),
      );
    }

    if (_devices.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.devices_other,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              '未发现设备',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              '请手动添加设备',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _devices.length,
      itemBuilder: (context, index) {
        final device = _devices[index];
        return _buildDeviceCard(device);
      },
    );
  }

  Widget _buildDeviceCard(DeviceInfo device) {
    final isOnline = device.status == 'online';
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isOnline ? Colors.green : Colors.grey,
          child: Icon(
            isOnline ? Icons.computer : Icons.computer_outlined,
            color: Colors.white,
          ),
        ),
        title: Text(
          device.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('IP: ${device.ip}:${device.port}'),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  isOnline ? '在线' : '离线',
                  style: TextStyle(
                    color: isOnline ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: ElevatedButton.icon(
          onPressed: isOnline ? () => _connectToDevice(device) : null,
          icon: const Icon(Icons.link),
          label: const Text('连接'),
        ),
      ),
    );
  }
}