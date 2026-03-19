# GeniusClaw OS - Flutter App 开发计划

## 📋 文档信息

| 项目 | 内容 |
|------|------|
| 项目名称 | GeniusClaw Operation System |
| 模块 | Flutter 移动端 App |
| 版本 | v1.0 |
| 创建日期 | 2026-03-19 |

---

## 1. 开发目标

### 1.1 目标平台

| 平台 | 状态 | 打包格式 |
|------|------|----------|
| Android 平板 | ⏳ 待开发 | .apk / .aab |
| Windows 电脑 | ⏳ 待开发 | .exe / .msi |
| iOS | ⏳ 后续支持 | .ipa |

### 1.2 核心功能（首批）

| 功能 | 说明 | 优先级 |
|------|------|--------|
| **AI 对话** | 自然语言控制 GC OS | P0 |
| **设备控制** | 控制 HomeAssistant 设备 | P0 |
| **文件管理** | NAS 文件浏览/上传/下载 | P1 |
| **技能市场** | Skills Hub 浏览与安装 | P1 |
| **系统设置** | 网络、存储、账户设置 | P2 |

---

## 2. 技术架构

### 2.1 技术栈

| 层级 | 技术 |
|------|------|
| 框架 | Flutter 3.x |
| 状态管理 | Riverpod / BLoC |
| HTTP | Dio |
| WebSocket | web_socket_channel |
| 本地存储 | Hive / SharedPreferences |
| UI 组件 | Material Design 3 |

### 2.2 架构图

```
┌─────────────────────────────────────────────────────────┐
│                     Flutter App                          │
├─────────────────────────────────────────────────────────┤
│  UI 层 (Screens / Widgets)                               │
│     ├── 首页 (AI 对话)                                    │
│     ├── 设备控制                                         │
│     ├── 文件管理                                         │
│     ├── 技能市场                                         │
│     └── 设置                                             │
├─────────────────────────────────────────────────────────┤
│  业务层 (Providers / BLoCs)                             │
│     ├── AIProvider (对话逻辑)                            │
│     ├── DeviceProvider (设备状态)                       │
│     ├── FileProvider (文件操作)                          │
│     └── SkillProvider (技能管理)                        │
├─────────────────────────────────────────────────────────┤
│  数据层 (Services)                                       │
│     ├── OpenClawService (API 调用)                      │
│     ├── HAService (HomeAssistant)                       │
│     ├── NASService (文件服务)                           │
│     └── P2PService (P2P 连接)                           │
├─────────────────────────────────────────────────────────┤
│  网络层                                                  │
│     ├── REST API                                         │
│     ├── WebSocket (实时通信)                            │
│     └── MQTT (可选)                                      │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                   GC OS Backend                          │
│     ├── OpenClaw API                                     │
│     ├── HomeAssistant (本地)                            │
│     ├── NAS (SMB/WebDAV)                               │
│     └── P2P 网络                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 3. 页面设计

### 3.1 页面结构

```
App
├── 首页 (HomeScreen)
│   └── AI 对话 + 快捷操作
├── 设备 (DevicesScreen)
│   ├── 灯光
│   ├── 空调
│   ├── 传感器
│   └── 更多
├── 文件 (FilesScreen)
│   ├── 我的文件
│   ├── 共享文件
│   └── 最近访问
├── 技能 (SkillsScreen)
│   ├── 推荐
│   ├── 已安装
│   └── 分类
└── 设置 (SettingsScreen)
    ├── 网络连接
    ├── 账户
    ├── 主题
    └── 关于
```

### 3.2 首页布局

```
┌─────────────────────────────────────┐
│  🦞 GeniusClaw              ⚙️    │
├─────────────────────────────────────┤
│                                     │
│  ┌─────────────────────────────┐   │
│  │  🤖                          │   │
│  │  您好！有什么可以帮您？       │   │
│  │                             │   │
│  │  🟢 在线                     │   │
│  └─────────────────────────────┘   │
│                                     │
│  ┌─────────────────────────────┐   │
│  │ 请输入指令...               │   │
│  └─────────────────────────────┘   │
│                              🎤    │
├─────────────────────────────────────┤
│  🏠    📱    📁    📦    ⚙️       │
│  首页  设备  文件  技能  设置      │
└─────────────────────────────────────┘
```

---

## 4. API 对接

### 4.1 OpenClaw API

```dart
// API 基础配置
class ApiConfig {
  static const String baseUrl = 'http://GC_OS_IP:8080/api';
  static const String wsUrl = 'ws://GC_OS_IP:8080/ws';
}

// 示例：发送 AI 对话
Future<String> sendMessage(String text) async {
  final response = await Dio().post(
    '${ApiConfig.baseUrl}/chat',
    data: {'message': text},
  );
  return response.data['reply'];
}
```

### 4.2 HomeAssistant API

```dart
// HA 设备控制
class HAService {
  // 获取设备列表
  Future<List<HAEntity>> getEntities() async { ... }
  
  // 控制设备
  Future<void> callService(String domain, String service, 
                          Map<String, dynamic> data) async { ... }
  
  // 监听状态变化
  Stream<HAEvent> subscribeEvents() async* { ... }
}
```

### 4.3 NAS 文件操作

```dart
// 文件服务
class NASService {
  // 浏览文件
  Future<List<FileItem>> listFiles(String path) async { ... }
  
  // 上传文件
  Future<void> uploadFile(File file, String path) async { ... }
  
  // 下载文件
  Future<void> downloadFile(String remotePath, 
                           String localPath) async { ... }
}
```

---

## 5. 开发计划

### Phase 1: 基础框架

| 任务 | 状态 |
|------|------|
| [ ] Flutter 环境搭建 | ⏳ |
| [ ] 项目结构创建 | ⏳ |
| [ ] 基础页面框架 | ⏳ |
| [ ] 主题/样式配置 | ⏳ |

### Phase 2: 核心功能

| 任务 | 状态 |
|------|------|
| [ ] OpenClaw 连接 | ⏳ |
| [ ] AI 对话功能 | ⏳ |
| [ ] WebSocket 实时通信 | ⏳ |

### Phase 3: 业务功能

| 任务 | 状态 |
|------|------|
| [ ] 设备控制页面 | ⏳ |
| [ ] 文件管理页面 | ⏳ |
| [ ] 技能市场页面 | ⏳ |

### Phase 4: 打包发布

| 任务 | 状态 |
|------|------|
| [ ] Android 打包 (.apk) | ⏳ |
| [ ] Windows 打包 (.exe) | ⏳ |
| [ ] 测试验证 | ⏳ |

---

## 6. 项目结构

```
geniusclaw_app/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── config/
│   │   ├── theme.dart
│   │   ├── routes.dart
│   │   └── api_config.dart
│   ├── models/
│   │   ├── message.dart
│   │   ├── device.dart
│   │   ├── file_item.dart
│   │   └── skill.dart
│   ├── providers/
│   │   ├── ai_provider.dart
│   │   ├── device_provider.dart
│   │   ├── file_provider.dart
│   │   └── skill_provider.dart
│   ├── services/
│   │   ├── openclaw_service.dart
│   │   ├── ha_service.dart
│   │   ├── nas_service.dart
│   │   └── p2p_service.dart
│   ├── screens/
│   │   ├── home/
│   │   ├── devices/
│   │   ├── files/
│   │   ├── skills/
│   │   └── settings/
│   └── widgets/
│       ├── chat_bubble.dart
│       ├── device_card.dart
│       └── file_tile.dart
├── assets/
│   ├── images/
│   └── icons/
├── pubspec.yaml
└── README.md
```

---

## 7. 依赖库

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # 网络
  dio: ^5.3.0
  web_socket_channel: ^2.4.0
  
  # 状态管理
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0
  
  # 本地存储
  hive: ^2.2.3
  shared_preferences: ^2.2.0
  
  # UI
  flutter_markdown: ^0.6.18
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0
  
  # 工具
  path_provider: ^2.1.0
  file_picker: ^6.1.0
  permission_handler: ^11.1.0
  intl: ^0.18.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.4.0
  riverpod_generator: ^2.3.0
```

---

## 8. 测试用例

| 功能 | 测试场景 |
|------|----------|
| AI 对话 | 发送消息、接收回复、错误处理 |
| 设备控制 | 开关灯、调节温度、状态同步 |
| 文件管理 | 上传、下载、删除、浏览 |
| 技能市场 | 搜索、安装、卸载 |
| 网络 | 断线重连、后台上线 |

---

*文档版本: v1.0*
*最后更新: 2026-03-19*