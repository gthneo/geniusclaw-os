/// ========================================
/// MVP 客户端 - 连接首页
/// 
/// 功能: 自动发现 + 手动连接 OpenClaw
/// ========================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/connection_provider.dart';
import '../providers/device_provider.dart';
import '../config/api_config.dart';

class ConnectScreen extends ConsumerStatefulWidget {
  const ConnectScreen({super.key});

  @override
  ConsumerState<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends ConsumerState<ConnectScreen> {
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _portController = TextEditingController(text: '18790');
  
  @override
  void initState() {
    super.initState();
    _initSettings();
  }
  
  Future<void> _initSettings() async {
    final settings = ref.read(settingsServiceProvider);
    await settings.init();
    _ipController.text = settings.getSavedHost();
    _portController.text = settings.getSavedPort();
    ref.read(connectionProvider.notifier).init();
  }

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: '排查',
          textColor: Colors.white,
          onPressed: _showTroubleshooting,
        ),
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

  void _showTroubleshooting() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('连接排查'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('请检查以下事项:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text('1. 设备与手机在同一局域网'),
              Text('2. OpenClaw 服务已启动'),
              Text('3. 防火墙已允许 18790 端口'),
              Text('4. IP 地址是否正确'),
              SizedBox(height: 12),
              Text('测试地址: 192.168.3.156:18790', 
                style: TextStyle(fontFamily: 'monospace')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }

  Future<void> _connect() async {
    final ip = _ipController.text.trim();
    final port = int.tryParse(_portController.text) ?? 18790;

    if (ip.isEmpty) {
      _showError('请输入 IP 地址');
      return;
    }

    if (!IpValidator.isValidIp(ip)) {
      _showError('IP 地址格式无效');
      return;
    }

    final success = await ref.read(connectionProvider.notifier).connect(ip, port);
    
    if (success) {
      _showSuccess('已连接到 $ip:$port');
    } else {
      final error = ref.read(connectionProvider).errorMessage;
      _showError(error ?? '连接失败');
    }
  }

  Future<void> _disconnect() async {
    await ref.read(connectionProvider.notifier).disconnect();
    _showSuccess('已断开连接');
  }

  @override
  Widget build(BuildContext context) {
    final connState = ref.watch(connectionProvider);
    final isConnected = connState.isConnected;
    final isConnecting = connState.isConnecting;

    return Scaffold(
      appBar: AppBar(
        title: const Text('连接 OpenClaw'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildConnectionStatus(connState),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildManualInput(isConnected, isConnecting),
                  const SizedBox(height: 24),
                  _buildQuickConnect(isConnecting),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionStatus(ConnectionState state) {
    Color statusColor;
    String statusText;
    IconData statusIcon;
    
    switch (state.status) {
      case ConnectionStatus.connected:
        statusColor = Colors.green;
        statusText = '已连接 ${state.host}:${state.port}';
        statusIcon = Icons.cloud_done;
        break;
      case ConnectionStatus.connecting:
        statusColor = Colors.orange;
        statusText = '连接中...';
        statusIcon = Icons.cloud_sync;
        break;
      case ConnectionStatus.error:
        statusColor = Colors.red;
        statusText = state.errorMessage ?? '连接失败';
        statusIcon = Icons.cloud_off;
        break;
      case ConnectionStatus.disconnected:
      default:
        statusColor = Colors.grey;
        statusText = '未连接';
        statusIcon = Icons.cloud_outlined;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      color: statusColor.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(statusIcon, color: statusColor, size: 28),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManualInput(bool isConnected, bool isConnecting) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '手动连接',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _ipController,
                    enabled: !isConnecting,
                    decoration: const InputDecoration(
                      labelText: 'IP 地址',
                      hintText: '192.168.x.x',
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
                    enabled: !isConnecting,
                    decoration: const InputDecoration(
                      labelText: '端口',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: isConnected
                  ? OutlinedButton.icon(
                      onPressed: isConnecting ? null : _disconnect,
                      icon: const Icon(Icons.link_off),
                      label: const Text('断开连接'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    )
                  : ElevatedButton.icon(
                      onPressed: isConnecting ? null : _connect,
                      icon: isConnecting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.link),
                      label: Text(isConnecting ? '连接中...' : '连接'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickConnect(bool isConnecting) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '快速连接',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: isConnecting ? null : () {
                    _ipController.text = ApiConfig.kDefaultHost;
                    _portController.text = ApiConfig.kDefaultPort;
                  },
                  icon: const Icon(Icons.restore, size: 18),
                  label: const Text('恢复默认'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '默认地址: 192.168.3.156:18790',
              style: TextStyle(color: Colors.grey, fontFamily: 'monospace'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: isConnecting ? null : () async {
                  await ref.read(connectionProvider.notifier).connect(
                    ApiConfig.kDefaultHost,
                    int.tryParse(ApiConfig.kDefaultPort) ?? 18790,
                  );
                  final state = ref.read(connectionProvider);
                  if (state.isConnected) {
                    _showSuccess('已连接到默认服务器');
                  } else {
                    _showError(state.errorMessage ?? '连接失败');
                  }
                },
                icon: const Icon(Icons.bolt),
                label: const Text('连接默认服务器'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
