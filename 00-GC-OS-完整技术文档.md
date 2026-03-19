# 🦞 GeniusClaw Operation System 完整技术文档

> 版本: v2.0 | 创建日期: 2026-03-19 | 作者: PT (Prometheus Trump)
> 飞书文档: https://feishu.cn/docx/OrLIddwscoEWGUxIoaPcPuC5nVD

---

## 📋 目录

1. [项目概述](#1-项目概述)
2. [用户场景](#2-用户场景)
3. [产品需求规格](#3-产品需求规格)
4. [界面设计](#4-界面设计)
5. [技术架构](#5-技术架构)
6. [测试用例](#6-测试用例)
7. [交付手册](#7-交付手册)
8. [维护手册](#8-维护手册)
9. [用户手册](#9-用户手册)
10. [营销手册](#10-营销手册)
11. [源码文档](#11-源码文档)

---

## 1. 项目概述

### 1.1 项目背景

**GeniusClaw Operation System (GC OS)** 是 BrainWare 脑件项目的核心操作系统产品，基于 Ubuntu Linux 进行裁剪优化，集成了 OpenClaw 智能助手框架，打包为可安装镜像固件。

### 1.2 核心定位

| 维度 | 定位 |
|------|------|
| **产品形态** | 渠道型 OS（IT 供应链平台）|
| **目标硬件** | x86/ARM 小主机、工控机、NUC |
| **核心价值** | 本地化 AI + 隐私保护 + 算料存储 |

### 1.3 功能模块一览

```
┌─────────────────────────────────────────────────────────────────┐
│                    GeniusClaw OS v1.0                           │
├─────────────┬─────────────┬─────────────┬───────────────────────┤
│ Skills/HUB  │ LLM Manager │    NAS      │     Router            │
│ 技能市场    │ 大模型供应链 │  算料存储    │     路由出口           │
├─────────────┴─────────────┴─────────────┴───────────────────────┤
│  Peripherals  │   Agent Market   │   Blockchain/Web3           │
│  外设驱动     │  智能体交易市场   │   区块链对接                │
└─────────────┴─────────────────────┴─────────────────────────────┘
```

### 1.4 与 OpenClaw 的关系

- **OpenClaw**: AI Agent 框架（软件层面）
- **GeniusClaw OS**: 基于 Ubuntu + OpenClaw 的操作系统产品
- GC OS 是 OpenClaw 的载体和分发形式

---

## 2. 用户场景

### 2.1 场景一：家庭 AI 助手

**场景描述**：家庭用户希望拥有本地化的 AI 助手，保护隐私的同时享受 AI 便利

**用户画像**：
- 35-55 岁中高收入家庭
- 对数据隐私敏感
- 有智能家居需求

**需求要点**：
- 一键安装，开机即用
- 本地大模型运行（无需联网）
- 家庭成员多账号支持
- 智能家居控制中控

**痛点**：
- 现有方案依赖云端，隐私担忧
- 配置复杂，学习成本高
- 数据存储不稳定

### 2.2 场景二：中小企业私有 AI 部署

**场景描述**：中小企业需要私有化 AI 能力，用于客服、数据分析

**用户画像**：
- 50人以下的中小企业
- IT 预算有限
- 有数据合规要求

**需求要点**：
- 一键部署私有 AI
- 成本可控（相比云服务）
- 数据不出本地
- 技能可定制

**痛点**：
- 公有云成本高
- 数据安全合规难
- 缺乏技术运维能力

### 2.3 场景三：行业垂直解决方案

**场景描述**：特定行业（如医疗、制造、零售）需要定制化 AI 解决方案

**行业示例**：
- 医疗：患者随访、健康监测
- 制造：设备监控、预测维护
- 零售：智能客服、库存管理

**需求要点**：
- 预装行业 Skills
- 外设驱动支持
- 稳定可靠

### 2.4 场景四：算料存储与分发

**场景描述**：用户需要本地化存储影音、数据，并支持多设备访问

**需求要点**：
- NAS 文件存储
- 跨设备同步
- 影音串流服务
- 隐私保护

### 2.5 场景五：隐私上网与跨境办公

**场景描述**：需要安全上网、跨境访问的企业或个人

**需求要点**：
- VPN/代理集成
- 数据加密传输
- 广告拦截
- 隐私保护

### 2.6 场景六：居家养老（详细）

**场景描述**：独居老人需要健康监测、紧急呼叫、用药提醒

**功能列表**：
- 心率/血压数据采集
- 用药提醒（时间+剂量）
- 异常预警（自动通知家属）
- 紧急呼叫一键 SOS
- 语音交互（简化操作）
- 视频监控（可选）

### 2.7 场景七：网约车司机

**场景描述**：网约车司机需要行程规划、收益统计、订单管理

**功能列表**：
- 订单聚合（多平台）
- 收益统计日报/月报
- 热门目的地推荐
- 行程记录与分析

---

## 3. 产品需求规格

### 3.1 功能需求

#### 3.1.1 Skills 与 HUB 模块

| 需求ID | 功能描述 | 优先级 | 状态 |
|--------|----------|--------|------|
| SKL-001 | Skills 市场浏览与搜索 | P0 | 待开发 |
| SKL-002 | Skills 一键安装/卸载 | P0 | 待开发 |
| SKL-003 | Skills 分类筛选（行业/场景）| P1 | 待开发 |
| SKL-004 | Skill 配置与参数调整 | P1 | 待开发 |
| SKL-005 | Skill 训练与优化 | P2 | 待开发 |
| SKL-006 | Skill 加密与授权管理 | P2 | 待开发 |
| SKL-007 | Skills 分享与协作 | P3 | 待开发 |
| SKL-008 | Skill 版本管理 | P2 | 待开发 |
| SKL-009 | Skill 依赖自动安装 | P1 | 待开发 |

#### 3.1.2 大模型供应链管理

| 需求ID | 功能描述 | 优先级 | 状态 |
|--------|----------|--------|------|
| LLM-001 | Ollama 本地模型管理 | P0 | 待开发 |
| LLM-002 | OpenRouter 云模型集成 | P0 | 待开发 |
| LLM-003 | 模型热插拔切换 | P0 | 待开发 |
| LLM-004 | 模型性能监控 | P1 | 待开发 |
| LLM-005 | 模型下载与更新 | P1 | 待开发 |
| LLM-006 | 模型量化与优化 | P2 | 待开发 |
| LLM-007 | 模型自动选择（根据任务） | P2 | 待开发 |
| LLM-008 | 本地 Embedding 向量 | P1 | 待开发 |

#### 3.1.3 NAS 算料存储

| 需求ID | 功能描述 | 优先级 | 状态 |
|--------|----------|--------|------|
| NAS-001 | SMB/NFS 文件共享 | P0 | 待开发 |
| NAS-002 | 影音串流服务 (Plex/Jellyfin) | P0 | 待开发 |
| NAS-003 | 多设备同步 | P1 | 待开发 |
| NAS-004 | 存储配额管理 | P1 | 待开发 |
| NAS-005 | 数据备份与恢复 | P2 | 待开发 |
| NAS-006 | 外接存储管理 | P1 | 待开发 |
| NAS-007 | 磁盘健康监控 | P1 | 待开发 |
| NAS-008 | RAID 配置支持 | P2 | 待开发 |

#### 3.1.4 路由出口

| 需求ID | 功能描述 | 优先级 | 状态 |
|--------|----------|--------|------|
| RTR-001 | OpenWrt 集成 | P0 | 待开发 |
| RTR-002 | VPN 服务器 | P0 | 待开发 |
| RTR-003 | 广告拦截 (AdGuard) | P1 | 待开发 |
| RTR-004 | 流量监控与统计 | P1 | 待开发 |
| RTR-005 | 访客网络隔离 | P2 | 待开发 |
| RTR-006 | DDNS 动态域名 | P2 | 待开发 |
| RTR-007 | PPPoE 拨号支持 | P0 | 待开发 |
| RTR-008 | 家长控制 | P2 | 待开发 |

#### 3.1.5 外设驱动

| 需求ID | 功能描述 | 优先级 | 状态 |
|--------|----------|--------|------|
| PRD-001 | 常用外设驱动预装 | P0 | 待开发 |
| PRD-002 | 驱动在线下载 | P1 | 待开发 |
| PRD-003 | USB 设备自动识别 | P1 | 待开发 |
| PRD-004 | 智能家居协议支持 (MQTT) | P1 | 待开发 |
| PRD-005 | 工业设备协议支持 (Modbus) | P2 | 待开发 |
| PRD-006 | 外设状态监控 | P2 | 待开发 |
| PRD-007 | Zigbee/Z-Wave 支持 | P2 | 待开发 |
| PRD-008 | 摄像头/麦克风管理 | P0 | 待开发 |

#### 3.1.6 Agent 智能体市场

| 需求ID | 功能描述 | 优先级 | 状态 |
|--------|----------|--------|------|
| AG-001 | Agent 分类浏览 | P1 | 待开发 |
| AG-002 | Agent 部署与管理 | P1 | 待开发 |
| AG-003 | 采购工作流 | P2 | 待开发 |
| AG-004 | 支付网关集成 | P2 | 待开发 |
| AG-005 | Agent 协作编排 | P3 | 待开发 |
| AG-006 | HTTP 402 协议支持 | P2 | 待开发 |

#### 3.1.7 区块链对接

| 需求ID | 功能描述 | 优先级 | 状态 |
|--------|----------|--------|------|
| BC-001 | 区块链钱包集成 | P2 | 待开发 |
| BC-002 | 智能合约调用 | P2 | 待开发 |
| BC-003 | 稳定币支付 | P3 | 待开发 |
| BC-004 | 代币资产管理 | P3 | 待开发 |
| BC-005 | x402 协议支持 | P2 | 待开发 |

### 3.2 非功能需求

| 类别 | 需求 |
|------|------|
| **性能** | 启动时间 < 30s；响应延迟 < 200ms |
| **稳定性** | MTBF > 30天；MTTR < 30min |
| **安全** | 数据加密传输；权限分级管理；安全启动 |
| **兼容性** | 支持 x86_64 / ARM64 |
| **可维护性** | 模块热更新；日志自动清理；OTA 升级 |
| **易用性** | 零配置启动；图形化配置；语音交互 |

---

## 4. 界面设计

### 4.1 整体布局

```
┌──────────────────────────────────────────────────────────────────┐
│  🦞 GeniusClaw OS          [用户头像] [设置] [关机]    ─ □ ✕    │
├─────────────┬────────────────────────────────────────────────────┤
│             │                                                    │
│  📊 仪表盘   │              主内容区域                            │
│  🧠 Skills  │                                                    │
│  🤖 大模型   │                                                    │
│  💾 存储    │                                                    │
│  🌐 网络    │                                                    │
│  🔌 外设    │                                                    │
│  🛒 市场    │                                                    │
│  ⚙️ 设置    │                                                    │
│             │                                                    │
├─────────────┴────────────────────────────────────────────────────┤
│  状态栏: CPU: 12% | 内存: 2.1GB | 存储: 45% | 🌐 在线             │
└──────────────────────────────────────────────────────────────────┘
```

### 4.2 核心页面设计

#### 4.2.1 仪表盘

- 系统概览卡片（CPU/内存/存储/网络）
- 最近活动时间线
- 快捷操作按钮
- 资源使用图表（实时）

#### 4.2.2 Skills 市场

- 分类筛选（左栏）：居家养老、企业管理、医疗健康等
- 搜索框（顶部）+ 标签筛选
- 技能卡片网格（图标+名称+描述+安装按钮）
- 安装进度条

#### 4.2.3 大模型管理

- 模型列表（已安装/可用）
- 模型大小、下载进度
- 性能指标图表
- 切换开关（启用/禁用）
- 模型详情面板

#### 4.2.4 网络设置（PPPoE 界面）

```
┌─────────────────────────────────────────┐
│  🌐 网络设置                            │
├─────────────────────────────────────────┤
│  接入方式: [DHCP ▼] [PPPoE ▼] [静态IP] │
│                                         │
│  ┌─ PPPoE 配置 ──────────────────────┐  │
│  │ 宽带账号: [____________]          │  │
│  │ 宽带密码: [************]          │  │
│  │ 服务名称: [____________] (可选)    │  │
│  │                                  │  │
│  │ 连接状态: ● 已连接                │  │
│  │            [连接] [断开] [保存]   │  │
│  └────────────────────────────────────│  │
│                                         │
│  📊 当前状态                            │
│  WAN: 192.168.1.100 | 上行: 50Mbps     │
│  下行: 200Mbps | 运行时间: 5天12小时   │
└─────────────────────────────────────────┘
```

#### 4.2.5 存储管理

- 存储卷列表
- 使用量可视化（饼图）
- SMB/NFS 共享配置
- 外接设备列表

#### 4.2.6 外设管理

- 设备分类（存储、显示、输入、智能家居）
- 设备状态（在线/离线）
- 驱动状态
- 快速操作

### 4.3 视觉风格

| 元素 | 规范 |
|------|------|
| 主色 | #6366F1 (靛蓝) |
| 辅色 | #10B981 (翠绿) |
| 背景-深色 | #1E1E2E |
| 背景-浅色 | #F8FAFC |
| 圆角 | 12px |
| 字体 | Ubuntu / Inter |
| 图标 | Material Icons |

### 4.4 响应式设计

- 桌面端：完整侧边栏
- 平板端：可折叠侧边栏
- 手机端：底部导航栏

---

## 5. 技术架构

### 5.1 系统架构图

```
┌────────────────────────────────────────────────────────────────────────┐
│                         应用层 (Application Layer)                     │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────────┐  │
│  │ Web UI      │ │ Mobile App  │ │ CLI         │ │ REST API       │  │
│  │ (Vue 3)     │ │ (Flutter)   │ │ (Terminal)  │ │ (Express)      │  │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────────┘  │
├────────────────────────────────────────────────────────────────────────┤
│                      OpenClaw 核心层 (Core Layer)                      │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────────┐  │
│  │ Channels    │ │ Skills      │ │ Agents      │ │ Memory         │  │
│  │ (多通道管理) │ │ (技能系统)   │ │ (AI 代理)   │ │ (记忆系统)      │  │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────────┘  │
├────────────────────────────────────────────────────────────────────────┤
│                      服务层 (Service Layer)                            │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────────┐  │
│  │ LLM Service │ │ NAS Service │ │ VPN Service │ │ Driver Service  │  │
│  │ (Ollama)    │ │ (Samba)     │ │ (OpenVPN)   │ │ (Linux Driver)  │  │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────────┘  │
├────────────────────────────────────────────────────────────────────────┤
│                      基础设施层 (Infrastructure)                         │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────────┐  │
│  │ Ubuntu      │ │ Docker      │ │ Kernel      │ │ Hardware       │  │
│  │ 22.04 LTS   │ │ Container   │ │ 5.15+       │ │ x86/ARM        │  │
│  └─────────────┘ └─────────────┘ └─────────────┘ └─────────────────┘  │
└────────────────────────────────────────────────────────────────────────┘
```

### 5.2 核心技术栈

| 层级 | 技术选型 | 说明 |
|------|----------|------|
| **OS** | Ubuntu 22.04 LTS (最小化) | 裁剪后的基础系统 |
| **Kernel** | Linux 5.15+ | 支持主流硬件 |
| **Runtime** | Node.js 22 + Rust | OpenClaw 运行时 |
| **Container** | Docker + Docker Compose | 服务容器化 |
| **Web UI** | Vue 3 + Tailwind CSS | 管理界面 |
| **Mobile** | Flutter | 移动端 App |
| **Database** | SQLite + Redis | 轻量级存储 |
| **LLM** | Ollama + OpenRouter | 模型管理 |
| **Storage** | Samba + NFS + OpenMediaVault | NAS 功能 |
| **Network** | OpenWrt + Clash Verge + AdGuard Home | 路由与代理 |

### 5.3 模块设计

#### 5.3.1 Skills 模块

```typescript
// Skills 结构定义
interface Skill {
  id: string;
  name: string;
  version: string;
  description: string;
  category: SkillCategory;
  author: string;
  tags: string[];
  
  // 运行时
  entry: string;
  config?: SkillConfig;
  permissions: string[];
  dependencies: string[];
  
  // 安全
  encrypted: boolean;
  signature?: string;
}

// 技能分类
enum SkillCategory {
  HOME_CARE = 'home_care',      // 居家养老
  TRANSPORT = 'transport',     // 交通出行
  ENTERPRISE = 'enterprise',    // 企业管理
  HEALTH = 'health',           // 健康医疗
  SMART_HOME = 'smart_home',   // 智能家居
  FINANCE = 'finance',         // 财税
  CUSTOM = 'custom'            // 自定义
}

// Skill 生命周期
enum SkillLifecycle {
  INSTALLED = 'installed',
  RUNNING = 'running',
  STOPPED = 'stopped',
  UPDATING = 'updating',
  ERROR = 'error'
}

// Skills 引擎核心类
class SkillEngine {
  // 加载并验证 Skill
  async loadSkill(skillPath: string): Promise<Skill>
  
  // 安装 Skill 到系统
  async installSkill(skill: Skill): Promise<void>
  
  // 卸载 Skill
  async uninstallSkill(skillId: string): Promise<void>
  
  // 运行 Skill
  async runSkill(skillId: string, context: SkillContext): Promise<SkillResult>
  
  // 停止 Skill
  async stopSkill(skillId: string): Promise<void>
  
  // 获取运行中的 Skills
  getRunningSkills(): SkillInstance[]
  
  // 验证 Skill 签名
  verifySignature(skill: Skill): Promise<boolean>
}
```

#### 5.3.2 大模型管理

```typescript
// LLM Provider 接口
interface LLMProvider {
  id: string;
  name: string;
  type: 'local' | 'cloud';
  
  // 连接
  connect(): Promise<void>;
  disconnect(): Promise<void>;
  test(): Promise<boolean>;
  
  // 模型操作
  listModels(): Promise<Model[]>;
  downloadModel(modelId: string): Promise<void>;
  removeModel(modelId: string): Promise<void>;
  
  // 推理
  generate(prompt: string, options?: GenerateOptions): Promise<string>;
  chat(messages: Message[]): Promise<Message>;
  
  // 状态
  getStatus(): ProviderStatus;
}

// 支持的模型类型
interface Model {
  id: string;
  name: string;
  size: number;        // 模型大小 (bytes)
  quantization?: string;
  contextLength: number;
  status: 'downloaded' | 'downloading' | 'available';
  downloadProgress?: number;
}

// 大模型管理器
class LLMManager {
  // 注册 LLM 提供商
  registerProvider(provider: LLMProvider): void
  
  // 卸载提供商
  unregisterProvider(providerId: string): void
  
  // 获取可用模型
  async listModels(providerId?: string): Promise<Model[]>
  
  // 下载模型
  async downloadModel(providerId: string, modelId: string): Promise<void>
  
  // 移除模型
  async removeModel(providerId: string, modelId: string): Promise<void>
  
  // 文本生成
  async generate(prompt: string, options?: GenerateOptions): Promise<string>
  
  // 对话
  async chat(messages: Message[]): Promise<Message>
  
  // 切换默认模型
  async setDefaultModel(providerId: string, modelId: string): Promise<void>
  
  // 自动选择模型（根据任务类型）
  autoSelectModel(taskType: string): Model
}

// 支持的 Provider
// - Ollama (本地) - 支持 llama2, mistral, codellama 等
// - OpenRouter (云) - 支持 Claude, GPT, Gemini 等
// - Anthropic (云)
// - OpenAI (云)
```

#### 5.3.3 存储服务

```typescript
// 存储卷定义
interface StorageVolume {
  id: string;
  name: string;
  path: string;
  type: 'local' | 'usb' | 'network';
  mountPoint: string;
  capacity: number;
  used: number;
  
  // 协议
  protocols: ('smb' | 'nfs' | 'afp')[];
  
  // 访问控制
  accessList: AccessEntry[];
}

// SMB 配置
interface SMBConfig {
  shareName: string;
  path: string;
  readonly: boolean;
  guestAccess: boolean;
  allowedUsers: string[];
  browsable: boolean;
  comment?: string;
}

// NAS 管理器
class NASManager {
  // 创建存储卷
  async createVolume(config: VolumeConfig): Promise<StorageVolume>
  
  // 删除存储卷
  async deleteVolume(volumeId: string): Promise<void>
  
  // 挂载存储
  async mountVolume(volumeId: string): Promise<void>
  
  // 卸载存储
  async unmountVolume(volumeId: string): Promise<void>
  
  // 配置 SMB 共享
  async configureSMB(volumeId: string, config: SMBConfig): Promise<void>
  
  // 配置 NFS 共享
  async configureNFS(volumeId: string, config: NFSConfig): Promise<void>
  
  // 启动 Plex 媒体服务
  async startPlex(mediaPath: string): Promise<void>
  
  // 停止 Plex
  async stopPlex(): Promise<void>
  
  // 获取 Plex 状态
  getPlexStatus(): PlexStatus
  
  // 磁盘健康检查
  async checkDiskHealth(deviceId: string): Promise<DiskHealth>
}

// 影音服务配置
interface MediaServerConfig {
  type: 'plex' | 'jellyfin' | 'emby';
  port: number;
  libraryPaths: string[];
  transcoderQuality: 'low' | 'medium' | 'high' | 'original';
}
```

#### 5.3.4 网络服务

```typescript
// 网络状态
interface NetworkStatus {
  connectionType: 'dhcp' | 'pppoe' | 'static';
  ipAddress?: string;
  subnetMask?: string;
  gateway?: string;
  dns?: string[];
  status: 'connected' | 'disconnected' | 'connecting';
  uptime?: number;  // 秒
  uploadSpeed?: number;  // bps
  downloadSpeed?: number;  // bps
}

// PPPoE 配置
interface PPPoEConfig {
  username: string;
  password: string;
  serviceName?: string;
  acName?: string;
}

// 静态 IP 配置
interface StaticIPConfig {
  ipAddress: string;
  subnetMask: string;
  gateway: string;
  dns: string[];
}

// 网络管理器
class NetworkManager {
  // 获取网络状态
  async getStatus(): Promise<NetworkStatus>
  
  // 配置 DHCP
  async configureDHCP(): Promise<void>
  
  // 配置 PPPoE
  async configurePPPoE(config: PPPoEConfig): Promise<void>
  
  // 连接 PPPoE
  async connectPPPoE(): Promise<void>
  
  // 断开 PPPoE
  async disconnectPPPoE(): Promise<void>
  
  // 配置静态 IP
  async configureStaticIP(config: StaticIPConfig): Promise<void>
  
  // 获取实时速度
  async getRealTimeSpeed(): Promise<{upload: number, download: number}>
  
  // 启动 VPN 服务
  async startVPN(config: VPNConfig): Promise<void>
  
  // 停止 VPN
  async stopVPN(): Promise<void>
  
  // 配置广告拦截
  async configureAdBlock(enabled: boolean): Promise<void>
  
  // 获取流量统计
  async getTrafficStats(period: 'day' | 'week' | 'month'): Promise<TrafficStats>
}

// VPN 配置
interface VPNConfig {
  type: 'openvpn' | 'wireguard' | 'pptp';
  configPath?: string;
  server?: string;
  port?: number;
}
```

#### 5.3.5 外设驱动

```typescript
// 设备类型
enum DeviceType {
  STORAGE = 'storage',           // 存储设备
  DISPLAY = 'display',           // 显示设备
  INPUT = 'input',               // 输入设备
  CAMERA = 'camera',            // 摄像头
  AUDIO = 'audio',              // 音频设备
  SMART_HOME = 'smart_home',    // 智能家居
  INDUSTRIAL = 'industrial',    // 工业设备
  NETWORK = 'network'            // 网络设备
}

// 设备信息
interface DeviceInfo {
  id: string;
  name: string;
  type: DeviceType;
  vendorId?: string;
  productId?: string;
  driver?: string;
  status: 'online' | 'offline' | 'error';
  capabilities: string[];
  metadata?: Record<string, any>;
}

// 智能家居协议配置
interface SmartHomeConfig {
  protocol: 'mqtt' | 'zigbee' | 'zwave' | 'matter';
  host: string;
  port: number;
  username?: string;
  password?: string;
  discoveryEnabled: boolean;
}

// 外设管理器
class PeripheralManager {
  // 扫描外设
  async scanDevices(): Promise<DeviceInfo[]>
  
  // 获取设备详情
  async getDeviceInfo(deviceId: string): Promise<DeviceInfo>
  
  // 安装驱动
  async installDriver(deviceId: string, driverId: string): Promise<void>
  
  // 移除驱动
  async removeDriver(deviceId: string): Promise<void>
  
  // 启用/禁用设备
  async setDeviceEnabled(deviceId: string, enabled: boolean): Promise<void>
  
  // 连接到智能家居
  async connectSmartHome(config: SmartHomeConfig): Promise<void>
  
  // 断开智能家居
  async disconnectSmartHome(): Promise<void>
  
  // 获取智能家居设备列表
  async getSmartHomeDevices(): Promise<SmartDevice[]>
  
  // 发送命令到智能家居设备
  async sendSmartHomeCommand(deviceId: string, command: any): Promise<void>
  
  // 工业设备通信 (Modbus)
  async communicateModbus(deviceId: string, command: ModbusCommand): Promise<Buffer>
}

// Modbus 命令
interface ModbusCommand {
  functionCode: number;  // 0x01-0x06, 0x0F, 0x10
  address: number;
  quantity?: number;
  value?: number;
}
```

#### 5.3.6 区块链对接

```typescript
// 区块链类型
type Blockchain = 'ethereum' | 'solana' | 'bitcoin';

// 钱包信息
interface Wallet {
  address: string;
  chain: Blockchain;
  balance: string;
  privateKeyEncrypted: string;
}

// 交易信息
interface Transaction {
  hash: string;
  from: string;
  to: string;
  value: string;
  status: 'pending' | 'confirmed' | 'failed';
  blockNumber?: number;
  timestamp: number;
}

// 智能合约
interface SmartContract {
  address: string;
  abi: any[];
  chain: Blockchain;
}

// 区块链管理器
class BlockchainManager {
  // 创建钱包
  async createWallet(chain: Blockchain): Promise<Wallet>
  
  // 导入钱包
  async importWallet(chain: Blockchain, privateKey: string): Promise<Wallet>
  
  // 导出钱包（需解密）
  async exportWallet(walletAddress: string, password: string): Promise<string>
  
  // 获取余额
  async getBalance(walletAddress: string): Promise<string>
  
  // 获取交易历史
  async getTransactionHistory(walletAddress: string): Promise<Transaction[]>
  
  // 转账
  async transfer(to: string, amount: string, password: string): Promise<Transaction>
  
  // 部署智能合约
  async deployContract(abi: any[], bytecode: string, constructorArgs: any[]): Promise<SmartContract>
  
  // 调用智能合约
  async callContract(contractAddress: string, method: string, args: any[]): Promise<any>
  
  // 监听合约事件
  watchContractEvents(contractAddress: string, event: string, callback: (event: any) => void): void
  
  // 停止监听
  stopWatching(contractAddress: string): void
  
  // 支持 x402 协议支付
  async createPaymentRequest(amount: string, token: string): Promise<PaymentRequest>
  async verifyPayment(paymentHash: string): Promise<boolean>
}
```

### 5.4 数据流架构

```
用户交互层
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│                        Web UI / Mobile App                       │
└─────────────────────────────────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│                      OpenClaw API Gateway                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐         │
│  │ /skills  │  │  /llm    │  │ /network │  │ /storage │         │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘         │
└─────────────────────────────────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│                      OpenClaw Core                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐         │
│  │ Skills   │  │ Channels │  │  Agents  │  │ Memory   │         │
│  │ Engine   │  │ Manager  │  │ Manager  │  │ System   │         │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘         │
└─────────────────────────────────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Service Layer                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐         │
│  │ Ollama   │  │  Samba   │  │ OpenVPN  │  │  Driver  │         │
│  │ Service  │  │  Service │  │  Service │  │  Service │         │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘         │
└─────────────────────────────────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Infrastructure                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐         │
│  │ Ubuntu   │  │  Docker  │  │  Kernel  │  │ Hardware │         │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘         │
└─────────────────────────────────────────────────────────────────┘
```

### 5.5 API 接口规范

#### 5.5.1 Skills API

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| GET | /api/skills | 获取所有 Skills | ✓ |
| GET | /api/skills/:id | 获取 Skill 详情 | ✓ |
| POST | /api/skills | 安装 Skill | ✓ |
| DELETE | /api/skills/:id | 卸载 Skill | ✓ |
| POST | /api/skills/:id/run | 运行 Skill | ✓ |
| POST | /api/skills/:id/stop | 停止 Skill | ✓ |
| POST | /api/skills/:id/config | 更新配置 | ✓ |
| GET | /api/skills/market | 浏览市场 | ✓ |

#### 5.5.2 LLM API

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| GET | /api/llm/providers | 获取所有提供商 | ✓ |
| GET | /api/llm/models | 获取模型列表 | ✓ |
| POST | /api/llm/download | 下载模型 | ✓ |
| DELETE | /api/llm/models/:id | 删除模型 | ✓ |
| POST | /api/llm/generate | 文本生成 | ✓ |
| POST | /api/llm/chat | 对话推理 | ✓ |
| POST | /api/llm/embed | 向量嵌入 | ✓ |

#### 5.5.3 网络 API

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| GET | /api/network/status | 获取网络状态 | ✓ |
| GET | /api/network/stats | 获取流量统计 | ✓ |
| POST | /api/network/dhcp | 配置 DHCP | ✓ |
| POST | /api/network/pppoe/connect | 连接 PPPoE | ✓ |
| POST | /api/network/pppoe/disconnect | 断开 PPPoE | ✓ |
| POST | /api/network/static-ip | 配置静态 IP | ✓ |
| POST | /api/network/vpn/start | 启动 VPN | ✓ |
| POST | /api/network/vpn/stop | 停止 VPN | ✓ |

#### 5.5.4 存储 API

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| GET | /api/storage/volumes | 获取存储卷列表 | ✓ |
| POST | /api/storage/volumes | 创建存储卷 | ✓ |
| DELETE | /api/storage/volumes/:id | 删除存储卷 | ✓ |
| POST | /api/storage/smb | 配置 SMB 共享 | ✓ |
| GET | /api/storage/plex/status | 获取 Plex 状态 | ✓ |
| POST | /api/storage/plex/start | 启动 Plex | ✓ |

---

## 6. 测试用例

### 6.1 单元测试

#### 6.1.1 Skills 模块

| 用例ID | 描述 | 预期结果 | 优先级 |
|--------|------|----------|--------|
| UT-SKL-001 | 加载有效的 Skill 包 | 成功加载并解析 | P0 |
| UT-SKL-002 | 安装 Skill 到指定目录 | 文件正确创建 | P0 |
| UT-SKL-003 | 卸载 Skill 并清理文件 | 完全清理 | P0 |
| UT-SKL-004 | Skill 配置验证（无效配置）| 提示错误信息 | P1 |
| UT-SKL-005 | Skill 依赖检查 | 正确识别缺失依赖 | P1 |
| UT-SKL-006 | 运行 Skill 并获取结果 | 返回预期结果 | P0 |
| UT-SKL-007 | 停止运行中的 Skill | 正确停止 | P0 |
| UT-SKL-008 | 验证 Skill 签名 | 签名验证通过/失败 | P1 |

#### 6.1.2 LLM 模块

| 用例ID | 描述 | 预期结果 | 优先级 |
|--------|------|----------|--------|
| UT-LLM-001 | 连接本地 Ollama | 连接成功 | P0 |
| UT-LLM-002 | 断开 Ollama | 正确断开 | P0 |
| UT-LLM-003 | 获取模型列表 | 返回模型数组 | P0 |
| UT-LLM-004 | 下载模型 | 下载成功 | P0 |
| UT-LLM-005 | 删除模型 | 删除成功 | P0 |
| UT-LLM-006 | 文本生成 | 返回生成文本 | P0 |
| UT-LLM-007 | 对话推理 | 返回对话结果 | P0 |
| UT-LLM-008 | 切换默认模型 | 切换成功 | P0 |
| UT-LLM-009 | 获取模型性能指标 | 返回指标数据 | P1 |

#### 6.1.3 网络模块

| 用例ID | 描述 | 预期结果 | 优先级 |
|--------|------|----------|--------|
| UT-NET-001 | 获取网络状态（DHCP）| 返回正确状态 | P0 |
| UT-NET-002 | 连接 PPPoE | 连接成功 | P0 |
| UT-NET-003 | 断开 PPPoE | 断开成功 | P0 |
| UT-NET-004 | 配置静态 IP | 配置生效 | P0 |
| UT-NET-005 | 启动 VPN | VPN 运行 | P1 |
| UT-NET-006 | 停止 VPN | VPN 停止 | P1 |
| UT-NET-007 | 配置广告拦截 | 拦截规则生效 | P1 |

### 6.2 集成测试

| 用例ID | 描述 | 预期结果 | 优先级 |
|--------|------|----------|--------|
| IT-001 | Skills 调用 LLM 生成 | 正常返回 | P0 |
| IT-002 | Skills 读取文件系统 | 正确读取 | P0 |
| IT-003 | NAS 存储写入/读取 | 读写成功 | P0 |
| IT-004 | VPN 连接外部服务 | 连接成功 | P1 |
| IT-005 | 外设识别并驱动 | 正确识别 | P0 |
| IT-006 | 移动端 App 远程控制 | 控制成功 | P1 |
| IT-007 | 多 Skills 并发运行 | 并发正常 | P1 |

### 6.3 系统测试

| 用例ID | 描述 | 预期结果 | 优先级 |
|--------|------|----------|--------|
| ST-001 | 全新安装（ISO 启动）| 成功安装 | P0 |
| ST-002 | 升级安装（保留数据）| 数据保留 | P0 |
| ST-003 | 冷启动时间 | < 30s | P0 |
| ST-004 | 24小时连续运行 | 无崩溃 | P0 |
| ST-005 | 内存泄漏检测 | 无泄漏 | P1 |
| ST-006 | 断电后恢复 | 自动恢复 | P1 |
| ST-007 | 网络异常处理 | 正确恢复 | P0 |
| ST-008 | 大容量存储识别 | 正确识别 | P1 |

---

## 7. 交付手册

### 7.1 交付内容清单

| 序号 | 内容 | 格式 | 说明 |
|------|------|------|------|
| 1 | GC OS 镜像 | .iso / .img | 安装镜像 |
| 2 | 硬件驱动包 | .deb | 额外驱动 |
| 3 | 产品文档 | .pdf | 完整文档 |
| 4 | 快速开始指南 | .pdf | 入门指南 |
| 5 | 许可证 | .txt | EULA |
| 6 | 源码 | .zip | 可选 |

### 7.2 安装前检查清单

- [ ] 目标硬件兼容列表确认
- [ ] 存储空间 ≥ 64GB（推荐 128GB+）
- [ ] 内存 ≥ 4GB（推荐 8GB+）
- [ ] 网络连接（用于激活）
- [ ] 备份重要数据
- [ ] 获取产品激活码

### 7.3 安装步骤

```bash
# 方式一：制作启动盘安装
# 1. 下载 ISO 镜像
wget https://example.com/gc-os-v1.0.iso

# 2. 制作启动盘 (Linux)
sudo dd if=gc-os-v1.0.iso of=/dev/sdX status=progress

# 3. 从 U 盘启动
# 4. 进入安装界面

# 方式二：虚拟机安装
# 1. 创建虚拟机（至少 4 核 4GB 内存）
# 2. 加载 ISO 镜像
# 3. 启动并安装
```

### 7.4 首次启动配置

1. **连接网络**
   - 选择接入方式（DHCP/PPPoE/静态IP）
   - 配置网络参数

2. **激活产品**
   - 输入激活码
   - 联网验证

3. **创建管理员账号**
   - 设置用户名和密码

4. **配置存储**
   - 选择存储卷
   - 配置 NAS 共享

5. **安装初始 Skills**
   - 选择场景（居家养老/企业/医疗等）
   - 一键安装推荐 Skills

### 7.5 快速验证清单

- [ ] 系统启动成功
- [ ] 网络连接正常
- [ ] Web UI 可访问
- [ ] Skills 市场可浏览
- [ ] 本地模型可运行
- [ ] NAS 共享可访问

---

## 8. 维护手册

### 8.1 日常维护任务

| 任务 | 频率 | 命令/工具 |
|------|------|------------|
| 系统更新 | 每周 | `apt update && apt upgrade` |
| 安全补丁 | 及时 | `unattended-upgrades` |
| 日志清理 | 每天 | `logrotate` |
| 存储检查 | 每周 | `smartctl` |
| 备份 | 每天 | `rsync` / `borg` |
| 健康检查 | 每天 | 自定义脚本 |

### 8.2 故障排查指南

#### 8.2.1 无法启动

```bash
# 检查启动日志
journalctl -b -1
dmesg | grep -i error

# 检查文件系统
fsck -n /dev/sda1

# 检查磁盘空间
df -h
```

#### 8.2.2 网络问题

```bash
# 检查网络状态
networkctl
ip addr show

# 检查 DNS
resolvectl status
cat /etc/resolv.conf

# 重启网络
sudo systemctl restart networking

# 检查 PPPoE 日志
sudo journalctl -u pppoe
```

#### 8.2.3 服务故障

```bash
# 检查服务状态
systemctl status openclaw
systemctl status docker

# 查看服务日志
journalctl -u openclaw -n 50

# 重启服务
sudo systemctl restart openclaw
sudo systemctl restart docker
```

#### 8.2.4 存储问题

```bash
# 检查磁盘健康
sudo smartctl -a /dev/sda

# 检查挂载状态
mount | grep /dev

# 检查 NAS 服务
sudo systemctl status smbd
sudo systemctl status nfs-server
```

### 8.3 性能监控

```bash
# 系统资源
htop
iotop -o

# 网络监控
nethogs
iftop

# 磁盘 I/O
iostat -x 1

# 应用监控
docker stats
```

### 8.4 备份与恢复

```bash
# 备份配置
sudo tar -czf backup-config.tar.gz /etc/geniusclaw/

# 备份数据
sudo rsync -av /home/geniusclaw/data/ /backup/data/

# 恢复
sudo tar -xzf backup-config.tar.gz -C /
```

### 8.5 升级流程

```bash
# 检查更新
sudo apt update
apt list --upgradable

# 升级系统
sudo apt upgrade

# 升级 GC OS
sudo geniusclaw-updater

# 重启
sudo reboot
```

---

## 9. 用户手册

### 9.1 快速开始

1. **开机** → 自动进入桌面
2. **连接网络** → 点击右上角网络图标
3. **激活产品** → 输入激活码
4. **安装 Skills** → 浏览市场 → 点击安装
5. **开始使用** → 配置并运行

### 9.2 常用操作

#### 9.2.1 安装 Skills

```
路径: Skills 市场 → 选择分类 → 浏览技能 → 点击安装 → 配置参数 → 完成
```

#### 9.2.2 管理大模型

```
路径: 大模型管理 → 选择提供商 → 浏览模型 → 下载/删除 → 设为默认
```

#### 9.2.3 配置网络

```
路径: 设置 → 网络 → 选择接入方式 → 配置参数 → 保存
```

#### 9.2.4 配置 NAS

```
路径: 存储 → 添加卷 → 选择类型 → 配置 SMB/NFS → 设置访问权限
```

#### 9.2.5 连接智能家居

```
路径: 外设 → 智能家居 → 添加协议 → 输入配置 → 自动发现设备
```

### 9.3 常见问题与解决

| 问题 | 解决方案 |
|------|----------|
| 无法连接网络 | 检查网线/WiFi；重启网络服务 |
| Skills 无法运行 | 检查依赖；查看日志 |
| 存储空间不足 | 清理日志；删除缓存；扩展存储 |
| 性能下降 | 重启服务；检查资源占用 |
| 无法访问 Web UI | 检查服务状态；检查防火墙 |
| 激活失败 | 检查网络；验证激活码 |
| 模型下载失败 | 检查网络；更换镜像源 |

### 9.4 规格参数

| 项目 | 最低要求 | 推荐配置 |
|------|----------|----------|
| CPU | x86_64 2核 | 4核+ |
| 内存 | 4GB | 8GB+ |
| 存储 | 64GB | 128GB+ |
| 网络 | 100Mbps | 1Gbps |
| 系统 | Ubuntu 22.04 | - |

---

## 10. 营销手册

### 10.1 产品定位

**Slogan**: "你的私人 AI 中心，掌控数据主权"

**核心卖点**：
- 🏠 **本地化 AI** - 数据不出门，隐私有保障
- 🔒 **隐私保护** - 自主可控，不依赖云端
- ⚡ **开箱即用** - 零配置体验，小白也能上手
- 💰 **成本可控** - 一次购买，终身使用

### 10.2 目标市场分析

| 市场 | 细分 | 痛点 | 解决方案 | 定价策略 |
|------|------|------|----------|----------|
| 家庭用户 | 个人/家庭 | 隐私担忧 | 本地 AI | 硬件+服务订阅 |
| SMB | 50人以下企业 | 成本高 | 私有部署 | 按规模定价 |
| 行业客户 | 医疗/制造/零售 | 定制难 | 行业 Skills | 项目制 |

### 10.3 竞品对比

| 特性 | GC OS | 云端 AI (ChatGPT) | 竞品私有化 |
|------|-------|-------------------|------------|
| 部署难度 | ⭐⭐⭐⭐⭐ (简单) | ⭐⭐⭐⭐ (简单) | ⭐⭐ (复杂) |
| 隐私保护 | ⭐⭐⭐⭐⭐ (最强) | ⭐ (差) | ⭐⭐⭐⭐ (强) |
| 成本 | ⭐⭐⭐⭐ (低) | ⭐⭐⭐ (中) | ⭐⭐ (高) |
| 维护 | ⭐⭐⭐⭐⭐ (自动) | ⭐⭐⭐⭐⭐ (无) | ⭐⭐ (需专人) |
| 可定制 | ⭐⭐⭐⭐ (高) | ⭐⭐ (低) | ⭐⭐⭐⭐ (高) |

### 10.4 销售渠道

- **直销**: 官方网站 + 电商平台
- **代理**: 经销商网络
- **OEM**: 硬件厂商预装
- **行业**: 系统集成商合作

### 10.5 定价体系

| 版本 | 价格 | 包含内容 | 目标用户 |
|------|------|----------|----------|
| 基础版 | ¥999 | OS + 基础 Skills | 个人/家庭 |
| 专业版 | ¥2999 | OS + 全 Skills + NAS | 小微企业 |
| 企业版 | 定制 | 行业解决方案 + 定制开发 | 大企业/行业 |

### 10.6 营销素材

**文案要点**：
1. 强调隐私保护（数据不出门）
2. 强调本地运行（无需联网也能用）
3. 强调易用性（开机即用）
4. 强调扩展性（Skills 市场）

**视觉素材**：
- 产品截图（Web UI）
- 使用场景图
- 隐私对比图
- 架构图

---

## 11. 源码文档

### 11.1 源码结构

```
gc-os/
├── core/                         # 核心系统
│   ├── openclaw/                # OpenClaw 核心
│   │   ├── src/
│   │   │   ├── index.ts         # 主入口
│   │   │   ├── channels/       # 通道管理
│   │   │   ├── skills/         # 技能系统
│   │   │   ├── agents/         # 代理系统
│   │   │   └── memory/         # 记忆系统
│   │   └── package.json
│   ├── kernel/                  # 内核配置
│   │   └── configs/
│   └── base/                    # 基础服务
│       └── services/
├── modules/                     # 功能模块
│   ├── skills/                 # Skills 引擎
│   │   ├── src/
│   │   │   ├── index.ts        # 模块入口
│   │   │   ├── engine.ts       # 技能引擎
│   │   │   ├── loader.ts       # 加载器
│   │   │   ├── installer.ts    # 安装器
│   │   │   ├── runtime.ts      # 运行时
│   │   │   └── registry.ts     # 注册表
│   │   └── tests/
│   ├── llm/                    # 大模型管理
│   │   ├── src/
│   │   │   ├── index.ts
│   │   │   ├── manager.ts      # 管理器
│   │   │   ├── providers/      # 提供商
│   │   │   │   ├── ollama.ts
│   │   │   │   ├── openrouter.ts
│   │   │   │   └── anthropic.ts
│   │   │   └── inference.ts   # 推理接口
│   │   └── tests/
│   ├── nas/                    # 存储服务
│   │   ├── src/
│   │   │   ├── index.ts
│   │   │   ├── manager.ts
│   │   │   ├── smb.ts
│   │   │   ├── nfs.ts
│   │   │   └── plex.ts
│   │   └── tests/
│   ├── network/                # 网络服务
│   │   ├── src/
│   │   │   ├── index.ts
│   │   │   ├── manager.ts
│   │   │   ├── pppoe.ts
│   │   │   ├── vpn.ts
│   │   │   └── adblock.ts
│   │   └── tests/
│   ├── peripherals/            # 外设驱动
│   │   ├── src/
│   │   │   ├── index.ts
│   │   │   ├── manager.ts
│   │   │   ├── detector.ts
│   │   │   └── protocols/
│   │   │       ├── mqtt.ts
│   │   │       ├── modbus.ts
│   │   │       └── zigbee.ts
│   │   └── tests/
│   └── blockchain/             # 区块链
│       ├── src/
│       │   ├── index.ts
│       │   ├── manager.ts
│       │   ├── wallet.ts
│       │   ├── contracts.ts
│       │   └── providers/
│       └── tests/
├── ui/                         # 用户界面
│   ├── web/                    # Web UI
│   │   ├── src/
│   │   │   ├── components/    # 组件
│   │   │   ├── views/        # 页面
│   │   │   ├── stores/       # 状态
│   │   │   └── api/          # API
│   │   ├── index.html
│   │   └── vite.config.ts
│   └── cli/                   # 命令行
│       └── src/
│           └── index.ts
├── docs/                       # 文档
│   ├── api/
│   └── arch/
└── scripts/                    # 脚本
    ├── install/
    └── config/
```

### 11.2 核心模块详解

#### 11.2.1 Skills 引擎

**文件**: `modules/skills/src/engine.ts`

```typescript
/**
 * SkillEngine - 技能引擎核心类
 * 
 * 负责 Skills 的加载、安装、运行、卸载
 * 
 * @remarks
 * Skills 是 GC OS 的核心扩展单元，每个 Skill 都是一个独立的功能包
 * 支持热加载、热卸载、版本管理
 */
export class SkillEngine {
  private registry: SkillRegistry;
  private runtime: SkillRuntime;
  private loader: SkillLoader;
  
  /**
   * 构造函数
   * @param config - 引擎配置
   */
  constructor(config: EngineConfig) {
    this.registry = new SkillRegistry(config.registryPath);
    this.runtime = new SkillRuntime();
    this.loader = new SkillLoader(config.basePath);
  }
  
  /**
   * 加载 Skill
   * @param skillPath - Skill 包路径
   * @returns 加载后的 Skill 对象
   * @throws SkillLoadError - 加载失败
   */
  async loadSkill(skillPath: string): Promise<Skill> {
    // 1. 验证 Skill 包完整性
    const manifest = await this.loader.readManifest(skillPath);
    
    // 2. 检查依赖
    await this.checkDependencies(manifest.dependencies);
    
    // 3. 加载 Skill 代码
    const code = await this.loader.loadCode(skillPath);
    
    // 4. 创建 Skill 实例
    const skill = new Skill({
      ...manifest,
      code,
      path: skillPath
    });
    
    // 5. 验证签名（如果启用）
    if (manifest.signature) {
      const valid = await this.verifySignature(skill);
      if (!valid) {
        throw new SkillLoadError('Invalid signature');
      }
    }
    
    return skill;
  }
  
  /**
   * 安装 Skill 到系统
   * @param skill - 要安装的 Skill
   */
  async installSkill(skill: Skill): Promise<void> {
    // 1. 创建安装目录
    const installPath = path.join(this.config.installPath, skill.id);
    await fs.mkdir(installPath, { recursive: true });
    
    // 2. 复制文件
    await this.copySkillFiles(skill, installPath);
    
    // 3. 安装依赖
    await this.installDependencies(skill);
    
    // 4. 注册到系统
    await this.registry.register(skill);
    
    // 5. 触发安装钩子
    await this.runHook(skill, 'onInstall');
  }
  
  /**
   * 运行 Skill
   * @param skillId - Skill ID
   * @param context - 运行上下文
   * @returns 运行结果
   */
  async runSkill(skillId: string, context: SkillContext): Promise<SkillResult> {
    // 1. 获取 Skill 实例
    const skill = await this.registry.get(skillId);
    if (!skill) {
      throw new SkillNotFoundError(skillId);
    }
    
    // 2. 创建运行实例
    const instance = await this.runtime.create(skill, context);
    
    // 3. 执行
    const result = await instance.execute(context.input);
    
    // 4. 返回结果
    return result;
  }
  
  /**
   * 停止 Skill
   * @param skillId - Skill ID
   */
  async stopSkill(skillId: string): Promise<void> {
    await this.runtime.destroy(skillId);
    await this.registry.updateStatus(skillId, 'stopped');
  }
  
  /**
   * 获取所有运行中的 Skills
   */
  getRunningSkills(): SkillInstance[] {
    return this.runtime.getAll();
  }
}
```

#### 11.2.2 大模型管理

**文件**: `modules/llm/src/manager.ts`

```typescript
/**
 * LLMManager - 大模型管理器
 * 
 * 统一管理本地和云端大模型
 * 支持多 Provider、热插拔、性能监控
 */
export class LLMManager {
  private providers: Map<string, LLMProvider>;
  private defaultProvider?: string;
  private metrics: MetricsCollector;
  
  constructor() {
    this.providers = new Map();
    this.metrics = new MetricsCollector();
  }
  
  /**
   * 注册 LLM 提供商
   * @param provider - 提供商实例
   */
  registerProvider(provider: LLMProvider): void {
    this.providers.set(provider.id, provider);
    logger.info(`Provider registered: ${provider.id}`);
  }
  
  /**
   * 获取可用模型列表
   * @param providerId - 可选提供商 ID
   */
  async listModels(providerId?: string): Promise<Model[]> {
    if (providerId) {
      const provider = this.providers.get(providerId);
      if (!provider) throw new ProviderNotFoundError(providerId);
      return provider.listModels();
    }
    
    // 获取所有提供商的模型
    const allModels: Model[] = [];
    for (const provider of this.providers.values()) {
      const models = await provider.listModels();
      allModels.push(...models.map(m => ({
        ...m,
        providerId: provider.id
      })));
    }
    return allModels;
  }
  
  /**
   * 下载模型
   * @param providerId - 提供商 ID
   * @param modelId - 模型 ID
   * @param onProgress - 进度回调
   */
  async downloadModel(
    providerId: string, 
    modelId: string,
    onProgress?: (progress: number) => void
  ): Promise<void> {
    const provider = this.providers.get(providerId);
    if (!provider) throw new ProviderNotFoundError(providerId);
    
    await provider.downloadModel(modelId, onProgress);
  }
  
  /**
   * 文本生成
   * @param prompt - 提示词
   * @param options - 生成选项
   */
  async generate(
    prompt: string, 
    options?: GenerateOptions
  ): Promise<string> {
    const provider = this.getActiveProvider();
    const startTime = Date.now();
    
    try {
      const result = await provider.generate(prompt, options);
      
      // 记录指标
      this.metrics.record({
        type: 'generate',
        provider: provider.id,
        duration: Date.now() - startTime,
        success: true
      });
      
      return result;
    } catch (error) {
      this.metrics.record({
        type: 'generate',
        provider: provider.id,
        duration: Date.now() - startTime,
        success: false,
        error: String(error)
      });
      throw error;
    }
  }
  
  /**
   * 对话推理
   * @param messages - 消息列表
   * @param options - 选项
   */
  async chat(
    messages: Message[], 
    options?: ChatOptions
  ): Promise<Message> {
    const provider = this.getActiveProvider();
    return provider.chat(messages, options);
  }
  
  /**
   * 获取当前活跃的 Provider
   */
  private getActiveProvider(): LLMProvider {
    const provider = this.providers.get(this.defaultProvider || 'ollama');
    if (!provider) throw new NoProviderError();
    return provider;
  }
}
```

#### 11.2.3 网络管理

**文件**: `modules/network/src/manager.ts`

```typescript
/**
 * NetworkManager - 网络管理器
 * 
 * 统一管理网络连接（DHCP/PPPoE/静态IP）
 * 提供 VPN、流量监控、广告拦截等功能
 */
export class NetworkManager {
  private pppoe: PPPoEClient;
  private vpn: VPNManager;
  private adblock: AdBlockManager;
  private monitor: TrafficMonitor;
  
  constructor(config: NetworkConfig) {
    this.pppoe = new PPPoEClient(config.pppoe);
    this.vpn = new VPNManager(config.vpn);
    this.adblock = new AdBlockManager(config.adblock);
    this.monitor = new TrafficMonitor();
  }
  
  /**
   * 获取网络状态
   */
  async getStatus(): Promise<NetworkStatus> {
    const interfaces = await this.getInterfaces();
    const defaultRoute = await this.getDefaultRoute();
    
    return {
      connectionType: await this.detectConnectionType(),
      ipAddress: interfaces[0]?.address,
      subnetMask: interfaces[0]?.netmask,
      gateway: defaultRoute,
      status: await this.checkConnectivity(),
      uptime: this.getUptime(),
      ...await this.getSpeed()
    };
  }
  
  /**
   * 配置 PPPoE
   */
  async configurePPPoE(config: PPPoEConfig): Promise<void> {
    await this.pppoe.configure(config);
    await this.writeConfig('/etc/ppp/peerts', config);
  }
  
  /**
   * 连接 PPPoE
   */
  async connectPPPoE(): Promise<void> {
    if (this.pppoe.isConnected()) {
      logger.warn('PPPoE already connected');
      return;
    }
    
    await this.pppoe.connect();
    
    // 等待连接成功
    for (let i = 0; i < 30; i++) {
      await this.sleep(1000);
      if (await this.pppoe.isConnected()) {
        logger.info('PPPoE connected successfully');
        return;
      }
    }
    
    throw new PPPoEConnectionError('Connection timeout');
  }
  
  /**
   * 断开 PPPoE
   */
  async disconnectPPPoE(): Promise<void> {
    await this.pppoe.disconnect();
  }
  
  /**
   * 配置静态 IP
   */
  async configureStaticIP(config: StaticIPConfig): Promise<void> {
    const iface = await this.getDefaultInterface();
    
    await this.exec(`ip addr add ${config.ipAddress}/${this.maskToCidr(config.subnetMask)} dev ${iface}`);
    await this.exec(`ip route add default via ${config.gateway}`);
    
    await this.writeResolvConf(config.dns);
  }
  
  /**
   * 获取实时网速
   */
  async getRealTimeSpeed(): Promise<{upload: number, download: number}> {
    return this.monitor.getSpeed();
  }
  
  /**
   * 启动 VPN
   */
  async startVPN(config: VPNConfig): Promise<void> {
    await this.vpn.start(config);
  }
  
  /**
   * 停止 VPN
   */
  async stopVPN(): Promise<void> {
    await this.vpn.stop();
  }
  
  /**
   * 配置广告拦截
   */
  async configureAdBlock(enabled: boolean): Promise<void> {
    if (enabled) {
      await this.adblock.enable();
    } else {
      await this.adblock.disable();
    }
  }
}
```

#### 11.2.4 存储管理

**文件**: `modules/nas/src/manager.ts`

```typescript
/**
 * NASManager - 网络存储管理器
 * 
 * 提供 SMB/NFS 共享、影音服务、存储卷管理
 */
export class NASManager {
  private volumes: Map<string, StorageVolume>;
  private smb: SMBServer;
  private nfs: NFSServer;
  private plex: PlexMediaServer;
  
  constructor() {
    this.volumes = new Map();
    this.smb = new SMBServer();
    this.nfs = new NFSServer();
    this.plex = new PlexMediaServer();
  }
  
  /**
   * 创建存储卷
   */
  async createVolume(config: VolumeConfig): Promise<StorageVolume> {
    // 1. 创建物理卷
    await this.createPhysicalVolume(config.device);
    
    // 2. 创建逻辑卷（可选）
    if (config.type === 'lvm') {
      await this.createLVMVolume(config);
    }
    
    // 3. 格式化
    await this.mkfs(config);
    
    // 4. 挂载
    await this.mount(config);
    
    // 5. 创建卷对象
    const volume: StorageVolume = {
      id: uuid(),
      name: config.name,
      path: config.mountPoint,
      type: config.type,
      mountPoint: config.mountPoint,
      capacity: await this.getCapacity(config.device),
      used: 0,
      protocols: config.protocols || ['smb'],
      accessList: []
    };
    
    // 6. 保存到存储
    this.volumes.set(volume.id, volume);
    
    // 7. 配置共享
    if (config.protocols?.includes('smb')) {
      await this.configureSMB(volume.id, config.smb);
    }
    if (config.protocols?.includes('nfs')) {
      await this.configureNFS(volume.id, config.nfs);
    }
    
    return volume;
  }
  
  /**
   * 配置 SMB 共享
   */
  async configureSMB(volumeId: string, config: SMBConfig): Promise<void> {
    const volume = this.volumes.get(volumeId);
    if (!volume) throw new VolumeNotFoundError(volumeId);
    
    await this.smb.addShare({
      name: config.shareName,
      path: volume.path,
      browsable: config.browsable ?? true,
      readOnly: config.readonly ?? false,
      guestAccess: config.guestAccess ?? false,
      validUsers: config.allowedUsers
    });
    
    await this.smb.reload();
  }
  
  /**
   * 启动 Plex 媒体服务
   */
  async startPlex(config: MediaServerConfig): Promise<void> {
    await this.plex.configure(config);
    await this.plex.start();
  }
  
  /**
   * 获取 Plex 状态
   */
  getPlexStatus(): PlexStatus {
    return {
      running: this.plex.isRunning(),
      librarySize: this.plex.getLibrarySize(),
      streams: this.plex.getActiveStreams()
    };
  }
}
```

### 11.3 配置文件格式

#### 11.3.1 系统配置

```yaml
# /etc/geniusclaw/config.yaml
system:
  name: "GeniusClaw OS"
  version: "1.0.0"
  hostname: "geniusclaw"
  language: "zh-CN"
  timezone: "Asia/Shanghai"

network:
  defaultGateway: "auto"
  dns:
    - "8.8.8.8"
    - "114.114.114.114"
  pppoe:
    autoConnect: true
    reconnect: true

storage:
  defaultPool: "main"
  autoMount: true
  smb:
    workgroup: "WORKGROUP"
    winsServer: ""

security:
  firewall: true
  autoUpdate: true
  fail2ban: true

llm:
  defaultProvider: "ollama"
  providers:
    ollama:
      host: "localhost"
      port: 11434
    openrouter:
      apiKey: "${OPENROUTER_API_KEY}"

logging:
  level: "info"
  maxSize: "100M"
  maxFiles: 7
```

#### 11.3.2 Skills 注册表

```json
{
  "version": "1.0",
  "skills": [
    {
      "id": "skill-home-care",
      "name": "居家养老",
      "version": "1.0.0",
      "author": "BrainWare",
      "installed": true,
      "enabled": true,
      "config": {
        "sosEnabled": true,
        "medicationReminder": true
      }
    },
    {
      "id": "skill-transport",
      "name": "网约车司机",
      "version": "1.0.0",
      "author": "BrainWare",
      "installed": true,
      "enabled": false
    }
  ]
}
```

### 11.4 数据库 Schema

```sql
-- Skills 表
CREATE TABLE skills (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  version TEXT NOT NULL,
  description TEXT,
  category TEXT,
  author TEXT,
  installed_at INTEGER,
  enabled INTEGER DEFAULT 0,
  config TEXT
);

-- 模型表
CREATE TABLE models (
  id TEXT PRIMARY KEY,
  provider_id TEXT NOT NULL,
  name TEXT NOT NULL,
  size INTEGER,
  downloaded INTEGER DEFAULT 0,
  is_default INTEGER DEFAULT 0,
  FOREIGN KEY (provider_id) REFERENCES providers(id)
);

-- 存储卷表
CREATE TABLE volumes (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  path TEXT NOT NULL,
  type TEXT,
  capacity INTEGER,
  used INTEGER DEFAULT 0,
  created_at INTEGER
);

-- 网络配置表
CREATE TABLE network_config (
  id INTEGER PRIMARY KEY,
  connection_type TEXT,
  ip_address TEXT,
  subnet_mask TEXT,
  gateway TEXT,
  dns_servers TEXT
);

-- 流量统计表
CREATE TABLE traffic_stats (
  id INTEGER PRIMARY KEY,
  timestamp INTEGER NOT NULL,
  upload_bytes INTEGER,
  download_bytes INTEGER
);
```

---

## 📝 文档修订历史

| 版本 | 日期 | 修改人 | 说明 |
|------|------|--------|------|
| v1.0 | 2026-03-19 | PT | 初始版本 |
| v2.0 | 2026-03-19 | PT | 合并全部模块，详细源码说明 |

---

## 📂 相关资源

- 飞书文档: https://feishu.cn/docx/OrLIddwscoEWGUxIoaPcPuC5nVD
- 本地文档: /home/gth/.openclaw/workspace/projects/gc-os/docs/
- GitHub: https://github.com/brainware/geniusclaw/

---

*本文档由 PT 自动生成并维护*
*最后更新: 2026-03-19 14:11*