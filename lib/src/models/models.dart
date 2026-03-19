/// ========================================
/// MVP 客户端 - 数据模型
/// ========================================

/// 设备信息
class DeviceInfo {
  final String id;
  final String name;
  final String ip;
  final int port;
  final String status;
  final DateTime? lastSeen;

  DeviceInfo({
    required this.id,
    required this.name,
    required this.ip,
    required this.port,
    required this.status,
    this.lastSeen,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'ip': ip,
    'port': port,
    'status': status,
    'lastSeen': lastSeen?.toIso8601String(),
  };

  factory DeviceInfo.fromJson(Map<String, dynamic> json) => DeviceInfo(
    id: json['id'],
    name: json['name'],
    ip: json['ip'],
    port: json['port'],
    status: json['status'],
    lastSeen: json['lastSeen'] != null 
      ? DateTime.parse(json['lastSeen']) 
      : null,
  );
}

/// 内存信息
class MemoryInfo {
  final int total;
  final int used;
  final int free;
  final double percentage;

  MemoryInfo({
    required this.total,
    required this.used,
    required this.free,
    required this.percentage,
  });

  factory MemoryInfo.fromJson(Map<String, dynamic> json) => MemoryInfo(
    total: json['total'] ?? 0,
    used: json['used'] ?? 0,
    free: json['free'] ?? 0,
    percentage: (json['percentage'] ?? 0).toDouble(),
  );
}

/// 存储信息
class StorageInfo {
  final int total;
  final int used;
  final int free;
  final double percentage;

  StorageInfo({
    required this.total,
    required this.used,
    required this.free,
    required this.percentage,
  });

  factory StorageInfo.fromJson(Map<String, dynamic> json) => StorageInfo(
    total: json['total'] ?? 0,
    used: json['used'] ?? 0,
    free: json['free'] ?? 0,
    percentage: (json['percentage'] ?? 0).toDouble(),
  );
}

/// 网络状态
class NetworkStatus {
  final String connectionType;
  final String? ipAddress;
  final bool isConnected;
  final int uploadSpeed;
  final int downloadSpeed;

  NetworkStatus({
    required this.connectionType,
    this.ipAddress,
    required this.isConnected,
    required this.uploadSpeed,
    required this.downloadSpeed,
  });

  factory NetworkStatus.fromJson(Map<String, dynamic> json) => NetworkStatus(
    connectionType: json['connectionType'] ?? 'unknown',
    ipAddress: json['ipAddress'],
    isConnected: json['isConnected'] ?? false,
    uploadSpeed: json['uploadSpeed'] ?? 0,
    downloadSpeed: json['downloadSpeed'] ?? 0,
  );
}

/// 消息
class ChatMessage {
  final String id;
  final String content;
  final String sender;
  final DateTime timestamp;
  final MessageType type;

  ChatMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    required this.type,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    id: json['id'] ?? '',
    content: json['content'] ?? '',
    sender: json['sender'] ?? 'unknown',
    timestamp: json['timestamp'] != null 
      ? DateTime.parse(json['timestamp']) 
      : DateTime.now(),
    type: MessageType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => MessageType.text,
    ),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'sender': sender,
    'timestamp': timestamp.toIso8601String(),
    'type': type.name,
  };
}

enum MessageType { text, image, file, system }

/// 认证 Token
class AuthToken {
  final String token;
  final DateTime expiresAt;
  final String? refreshToken;

  AuthToken({
    required this.token,
    required this.expiresAt,
    this.refreshToken,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  factory AuthToken.fromJson(Map<String, dynamic> json) => AuthToken(
    token: json['token'],
    expiresAt: DateTime.parse(json['expiresAt']),
    refreshToken: json['refreshToken'],
  );
}