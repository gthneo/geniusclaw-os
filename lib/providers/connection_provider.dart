/// 连接状态管理 - Riverpod
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import '../config/api_config.dart';
import '../services/settings_service.dart';

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  error,
}

class OpenClawConnectionState {
  final ConnectionStatus status;
  final String? host;
  final int? port;
  final String? errorMessage;
  final DateTime? connectedAt;
  
  const OpenClawConnectionState({
    this.status = ConnectionStatus.disconnected,
    this.host,
    this.port,
    this.errorMessage,
    this.connectedAt,
  });
  
  OpenClawConnectionState copyWith({
    ConnectionStatus? status,
    String? host,
    int? port,
    String? errorMessage,
    DateTime? connectedAt,
  }) {
    return OpenClawConnectionState(
      status: status ?? this.status,
      host: host ?? this.host,
      port: port ?? this.port,
      errorMessage: errorMessage,
      connectedAt: connectedAt ?? this.connectedAt,
    );
  }
  
  bool get isConnected => status == ConnectionStatus.connected;
  bool get isConnecting => status == ConnectionStatus.connecting;
}

class ConnectionNotifier extends StateNotifier<OpenClawConnectionState> {
  final SettingsService _settings;
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;
  
  ConnectionNotifier(this._settings) : super(const OpenClawConnectionState());
  
  Future<void> init() async {
    final host = _settings.getSavedHost();
    final port = int.tryParse(_settings.getSavedPort()) ?? 18790;
    state = state.copyWith(host: host, port: port);
  }
  
  Future<bool> connect([String? host, int? port]) async {
    final targetHost = host ?? state.host ?? ApiConfig.kDefaultHost;
    final targetPort = port ?? state.port ?? 18790;
    
    state = state.copyWith(
      status: ConnectionStatus.connecting,
      host: targetHost,
      port: targetPort,
      errorMessage: null,
    );
    
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://$targetHost:$targetPort/ws'),
      );
      
      await _channel!.ready.timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Connection timeout');
        },
      );
      
      _settings.saveHost(targetHost, targetPort.toString());
      
      state = state.copyWith(
        status: ConnectionStatus.connected,
        connectedAt: DateTime.now(),
      );
      
      _startListening();
      _startHeartbeat();
      
      return true;
    } catch (e) {
      state = state.copyWith(
        status: ConnectionStatus.error,
        errorMessage: _getErrorMessage(e),
      );
      return false;
    }
  }
  
  String _getErrorMessage(dynamic error) {
    final msg = error.toString();
    if (msg.contains('Connection refused')) {
      return '无法连接到服务器，请确认 OpenClaw 服务已启动';
    }
    if (msg.contains('timeout')) {
      return '连接超时，请检查网络';
    }
    if (msg.contains('SocketException')) {
      return '网络错误，请检查网络连接';
    }
    return '连接失败: $msg';
  }
  
  void _startListening() {
    _channel!.stream.listen(
      (data) {
        // Handle incoming messages
      },
      onDone: () {
        state = state.copyWith(
          status: ConnectionStatus.disconnected,
        );
        _scheduleReconnect();
      },
      onError: (e) {
        state = state.copyWith(
          status: ConnectionStatus.error,
          errorMessage: e.toString(),
        );
      },
    );
  }
  
  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _sendHeartbeat(),
    );
  }
  
  Future<void> _sendHeartbeat() async {
    if (state.isConnected) {
      try {
        _channel?.sink.add(jsonEncode({
          'type': 'ping',
          'timestamp': DateTime.now().toIso8601String(),
        }));
      } catch (e) {
        // Ignore heartbeat errors
      }
    }
  }
  
  void _scheduleReconnect() {
    _heartbeatTimer?.cancel();
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (state.status == ConnectionStatus.disconnected) {
        connect();
      }
    });
  }
  
  Future<void> disconnect() async {
    _heartbeatTimer?.cancel();
    _reconnectTimer?.cancel();
    await _channel?.sink.close();
    _channel = null;
    state = const OpenClawConnectionState();
  }
  
  Future<void> updateHost(String host, int port) async {
    await disconnect();
    await _settings.saveHost(host, port.toString());
    state = state.copyWith(host: host, port: port);
    await connect();
  }
  
  @override
  void dispose() {
    _heartbeatTimer?.cancel();
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    super.dispose();
  }
}

final settingsServiceProvider = Provider<SettingsService>((ref) {
  return SettingsService();
});

final connectionProvider = StateNotifierProvider<ConnectionNotifier, OpenClawConnectionState>((ref) {
  final settings = ref.read(settingsServiceProvider);
  return ConnectionNotifier(settings);
});
