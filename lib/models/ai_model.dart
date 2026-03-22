/// AI 模型数据模型
class AIModel {
  final String id;
  final String name;
  final String description;
  final int size; // MB
  final bool isDownloaded;
  final double downloadProgress;
  final String status; // ready, downloading, error

  AIModel({
    required this.id,
    required this.name,
    required this.description,
    required this.size,
    this.isDownloaded = false,
    this.downloadProgress = 0.0,
    this.status = 'ready',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'size': size,
    'isDownloaded': isDownloaded,
    'downloadProgress': downloadProgress,
    'status': status,
  };

  factory AIModel.fromJson(Map<String, dynamic> json) => AIModel(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    size: json['size'],
    isDownloaded: json['isDownloaded'] ?? false,
    downloadProgress: json['downloadProgress'] ?? 0.0,
    status: json['status'] ?? 'ready',
  );

  AIModel copyWith({
    String? id,
    String? name,
    String? description,
    int? size,
    bool? isDownloaded,
    double? downloadProgress,
    String? status,
  }) {
    return AIModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      size: size ?? this.size,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      status: status ?? this.status,
    );
  }
}
