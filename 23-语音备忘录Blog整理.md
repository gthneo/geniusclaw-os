# GeniusClaw OS - 语音备忘录 Blog 整理模块

## 📋 文档信息

| 项目 | 内容 |
|------|------|
| 项目名称 | GeniusClaw Operation System |
| 模块 | 语音备忘录 Blog 整理 |
| 版本 | v1.0 |
| 创建日期 | 2026-03-19 |

---

## 🎯 模块概述

### 功能定位
将用户的语音备忘录自动采集、整理、转化为结构化 Blog 内容，作为脑件 Blog 系统的核心数据输入源之一。

### 核心价值
- **自动采集**：通过 iPhone 语音备忘录或 Mac 语音备忘录自动同步
- **AI 整理**：使用大模型将语音转换为文字，并进行结构化整理
- **Blog 发布**：自动生成符合 Blog 规范的图文内容
- **多端同步**：支持 Web/App 多端查看和管理

---

## 📱 数据采集方案

### 采集源

| 设备 | 采集方式 | 状态 |
|------|----------|------|
| **iPhone** | iCloud 同步 + 本地文件访问 | 🔧 开发中 |
| **iPad** | iCloud 同步 + 本地文件访问 | 🔧 开发中 |
| **Mac** | 语音备忘录应用访问 | 🔧 开发中 |
| **Android** | 语音备忘录应用（未来支持）| 📋 规划中 |

### 采集技术实现

```dart
// 语音备忘录采集服务 - Flutter iOS 示例
class VoiceMemoService {
  // 1. iOS 设备配对与访问
  Future<bool> pairWithIOS(String deviceId) async {
    // 通过 OpenClaw iOS 配对功能连接设备
    // 使用 BlueBubbles 或 native iOS API 访问语音备忘录
  }
  
  // 2. 获取语音备忘录列表
  Future<List<VoiceMemo>> getMemos() async {
    // 访问设备上的语音备忘录应用
    // 返回录音文件列表（m4a 格式）
  }
  
  // 3. 下载语音文件到本地
  Future<File> downloadMemo(VoiceMemo memo) async {
    // 将语音文件下载到 GeniusClaw OS 本地存储
    // 路径: /data/voice_memos/{date}/{id}.m4a
  }
}
```

---

## 🤖 AI 整理流程

### 处理流程

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  语音备忘录     │───▶│  语音转文字     │───▶│  AI 内容整理    │
│  (m4a/m4r)     │    │  (Whisper API)  │    │  (LLM 处理)     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                                      │
                                                      ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Blog 发布     │◀───│  结构化存储     │◀───│  摘要+标签      │
│  (多端展示)     │    │  (数据库)       │    │  (后处理)       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### AI 整理步骤

| 步骤 | 说明 | 技术 |
|------|------|------|
| **1. 语音转文字** | 将音频转为文字 | OpenAI Whisper |
| **2. 内容理解** | 分析语音内容 | 大模型 (MiniMax/Ollama) |
| **3. 结构化** | 提取标题、时间、地点、人物 | 大模型 Prompt |
| **4. 摘要生成** | 生成简短摘要 | 大模型 |
| **5. 标签提取** | 自动打标签 | 大模型 |
| **6. Blog 格式化** | 转换为 Blog 格式 | 模板引擎 |

### 整理 Prompt 示例

```yaml
# 语音内容整理 Prompt
system_prompt: |
  你是一个专业的博客编辑，负责将语音备忘录整理成结构化的博客文章。
  
  请按照以下格式整理内容：
  - 标题：从内容中提取简洁有力的标题
  - 日期：录音日期
  - 摘要：用 2-3 句话总结内容要点
  - 正文：保持语音原意，适当分段
  - 标签：提取 3-5 个相关标签
  
  注意事项：
  - 保持口语化表达的自然流畅
  - 删除重复和废话
  - 关键信息保留完整
```

---

## 💾 数据存储

### 存储结构

```
/data/
└── voice_memos/
    ├── 2026-03/
    │   ├── memo_001.m4a      # 原始语音
    │   ├── memo_001.json      # 转录结果
    │   └── memo_001_blog.md  # 整理后的 Blog
    └── ...
```

### 数据库模型

```sql
-- 语音备忘录表
CREATE TABLE voice_memos (
    id              UUID PRIMARY KEY,
    title           VARCHAR(255),
    original_text   TEXT,           -- 原始转录
    processed_text  TEXT,           -- 整理后正文
    summary         VARCHAR(500),   -- 摘要
    tags            JSON,            -- 标签数组
    recorded_at     TIMESTAMP,       -- 录音时间
    imported_at     TIMESTAMP,       -- 导入时间
    blog_published  BOOLEAN DEFAULT FALSE,
    source_device   VARCHAR(50),     -- 来源设备
    audio_url       VARCHAR(500),   -- 音频文件路径
    user_id         UUID REFERENCES users(id)
);

-- Blog 内容表
CREATE TABLE blog_posts (
    id              UUID PRIMARY KEY,
    voice_memo_id   UUID REFERENCES voice_memos(id),
    title           VARCHAR(255),
    content         TEXT,
    published_at    TIMESTAMP,
    status          VARCHAR(20),     -- draft/published
    view_count      INTEGER DEFAULT 0
);
```

---

## 🎨 界面设计

### 移动端界面 (Flutter)

| 页面 | 功能 |
|------|------|
| **首页** | 显示最近语音备忘录列表 |
| **详情页** | 显示单条备忘录内容和 AI 整理结果 |
| **设置页** | 设备配对、导入设置 |

### Web 端界面

| 页面 | 功能 |
|------|------|
| **Blog 列表** | 所有整理后的 Blog 文章 |
| **Blog 详情** | 阅读完整文章 |
| **管理后台** | 审核、编辑、发布 |

---

## 🔧 开发计划

### Phase 1: MVP（2周）

| 任务 | 工期 | 状态 |
|------|------|------|
| iOS 语音备忘录访问接口 | 3天 | ⏳ |
| 语音转文字服务 | 2天 | ⏳ |
| AI 整理 Pipeline | 3天 | ⏳ |
| 基础存储与数据库 | 2天 | ⏳ |
| Flutter 移动端展示 | 3天 | ⏳ |
| Web 端 Blog 展示 | 3天 | ⏳ |

### Phase 2: 增强（2周）

| 任务 | 工期 | 状态 |
|------|------|------|
| 多设备支持（iPad/Mac）| 3天 | 📋 |
| 自动化导入定时任务 | 2天 | 📋 |
| 高级编辑功能 | 3天 | 📋 |
| 分享与导出 | 2天 | 📋 |

### Phase 3: 生态（4周）

| 任务 | 工期 | 状态 |
|------|------|------|
| 社区分享功能 | 2周 | 📋 |
| 语音评论互动 | 1周 | 📋 |
| AI 写作助手增强 | 1周 | 📋 |

---

## 🔐 权限与安全

### 隐私保护

| 措施 | 说明 |
|------|------|
| **本地处理优先** | 语音文件本地存储，不上传第三方 |
| **端到端加密** | 传输过程加密存储 |
| **用户授权** | 需用户明确授权访问语音备忘录 |
| **数据隔离** | 每个用户数据独立存储 |

### 权限请求

```dart
// iOS 权限请求
Future<bool> requestMicrophonePermission() async {
  // 请求麦克风权限（用于录音）
}

Future<bool> requestVoiceMemoAccess() async {
  // 请求语音备忘录访问权限
  // 需要用户授权
}
```

---

## 📦 依赖技术栈

| 层级 | 技术 | 说明 |
|------|------|------|
| **移动端** | Flutter | 跨平台 App |
| **后端** | Dart/Futter | API 服务 |
| **AI** | Whisper | 语音转文字 |
| **AI** | MiniMax/Ollama | 内容整理 |
| **存储** | 本地文件系统 + SQLite | 数据持久化 |
| **同步** | iCloud API | iOS 语音备忘录同步 |

---

## 🚀 商业价值

### 变现模式

| 模式 | 说明 |
|------|------|
| **高级整理** | AI 高级整理功能付费 |
| **云存储套餐** | 额外存储空间付费 |
| **导出功能** | PDF/电子书导出付费 |
| **社区分享** | 付费展示/推广 |

### 市场定位

- **目标用户**：习惯用语音记录想法的用户
- **使用场景**：日常灵感记录、学习笔记、会议纪要、生活随想
- **差异化**：纯本地隐私 + AI 智能整理 + 一键 Blog 发布

---

## 📝 待办事项

- [ ] 确认 iOS 语音备忘录 API 访问方案
- [ ] 集成 OpenAI Whisper API
- [ ] 设计 AI 整理 Prompt
- [ ] 开发 Flutter 移动端
- [ ] 开发 Web 端 Blog 展示
- [ ] 隐私政策与用户协议

---

*文档版本: v1.0*
*最后更新: 2026-03-19*
*模块状态: 🔧 开发中*