import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/api_config.dart';

/// 设置页面
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _hostController = TextEditingController(text: ApiConfig.defaultHost);
  final _portController = TextEditingController(text: ApiConfig.defaultPort);
  final _haUrlController = TextEditingController(text: ApiConfig.haUrl);
  final _haTokenController = TextEditingController(text: ApiConfig.haToken);
  final _openClawApiKeyController = TextEditingController(text: ApiConfig.openClawApiKey);

  @override
  void dispose() {
    _hostController.dispose();
    _portController.dispose();
    _haUrlController.dispose();
    _haTokenController.dispose();
    _openClawApiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ 设置'),
      ),
      body: ListView(
        children: [
          _buildSection(
            title: 'OpenClaw 连接',
            children: [
              TextField(
                controller: _hostController,
                decoration: const InputDecoration(
                  labelText: 'GC OS IP 地址',
                  hintText: '192.168.1.100',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _portController,
                decoration: const InputDecoration(
                  labelText: '端口',
                  hintText: '8080',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _openClawApiKeyController,
                decoration: const InputDecoration(
                  labelText: 'Access Token',
                  hintText: 'OpenClaw API Key',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveOpenClawConfig,
                child: const Text('保存并重连'),
              ),
            ],
          ),
          _buildSection(
            title: 'HomeAssistant',
            children: [
              TextField(
                controller: _haUrlController,
                decoration: const InputDecoration(
                  labelText: 'HA URL',
                  hintText: 'http://192.168.1.101:8123',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _haTokenController,
                decoration: const InputDecoration(
                  labelText: '长期访问 Token',
                  hintText: '请输入 HA 的 Long-Lived Access Token',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveHAConfig,
                child: const Text('保存 HA 配置'),
              ),
            ],
          ),
          _buildSection(
            title: '外观',
            children: [
              ListTile(
                leading: const Icon(Icons.dark_mode),
                title: const Text('深色模式'),
                trailing: Switch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    // 切换主题
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('主题切换功能开发中...')),
                    );
                  },
                ),
              ),
            ],
          ),
          _buildSection(
            title: '关于',
            children: [
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('GeniusClaw App'),
                subtitle: Text('版本 1.0.0'),
              ),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('开源许可证'),
                onTap: () => _showLicenseDialog(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children.map((child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: child,
        )),
        const Divider(),
      ],
    );
  }

  void _saveOpenClawConfig() async {
    ApiConfig.updateHost(_hostController.text, _portController.text);
    ApiConfig.openClawApiKey = _openClawApiKeyController.text;
    
    // 保存到本地存储
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gc_host', _hostController.text);
    await prefs.setString('gc_port', _portController.text);
    await prefs.setString('openclaw_apikey', _openClawApiKeyController.text);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OpenClaw 配置已保存')),
      );
    }
  }

  void _saveHAConfig() async {
    ApiConfig.haUrl = _haUrlController.text;
    ApiConfig.haToken = _haTokenController.text;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ha_url', _haUrlController.text);
    await prefs.setString('ha_token', _haTokenController.text);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('HA 配置已保存')),
      );
    }
  }

  void _showLicenseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('开源许可证'),
        content: const SingleChildScrollView(
          child: Text('''
MIT License

Copyright (c) 2026 BrianWare

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
'''),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}