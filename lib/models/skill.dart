/// 技能模型
class Skill {
  final String id;
  final String name;
  final String description;
  final String category;
  final String icon;
  final double rating;
  final int downloads;
  final bool isInstalled;
  final String version;

  Skill({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.icon = '🤖',
    this.rating = 0.0,
    this.downloads = 0,
    this.isInstalled = false,
    this.version = '1.0.0',
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? 'general',
      icon: json['icon'] ?? '🤖',
      rating: (json['rating'] ?? 0).toDouble(),
      downloads: json['downloads'] ?? 0,
      isInstalled: json['isInstalled'] ?? false,
      version: json['version'] ?? '1.0.0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'icon': icon,
      'rating': rating,
      'downloads': downloads,
      'isInstalled': isInstalled,
      'version': version,
    };
  }
}

/// 技能分类
class SkillCategory {
  static const String home = '🏠 智能家居';
  static const String office = '💼 办公';
  static const String entertainment = '🎮 娱乐';
  static const String education = '📚 教育';
  static const String health = '🏥 健康';
  static const String general = '🔧 通用';

  static List<String> get all => [
    home, office, entertainment, education, health, general
  ];
}