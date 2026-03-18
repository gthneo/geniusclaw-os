# 🦞 GeniusClaw OS - 正龙虾操作系统

> 您的智能数字中枢 - 基于 Ubuntu 24.04 LTS

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/gthneo/geniusclaw-os)](https://github.com/gthneo/geniusclaw-os/stargazers)

## 📖 项目简介

GeniusClaw OS (正龙虾操作系统) 是一款基于 Ubuntu 24.04 LTS 的智能操作系统，内置 OpenClaw AI 能力，为家庭和企业提供数字化中枢解决方案。

**核心理念**：既要养龙虾，更要聚龙侠，用龙侠

---

## ✨ 核心特性

| 特性 | 说明 |
|------|------|
| 🧠 AI 自然交互 | 说话就能完成操作 |
| 🔒 隐私保护 | 数据本地存储，拒绝被画像 |
| 🛠️ Skills 市场 | 像装 APP 一样装 AI 技能 |
| 🌐 P2P 网络 | 去中心化节点互联 |
| 💾 NAS 存储 | 本地化影音/文件存储 |
| 🤖 Agent 市场 | P2P 网络上的 Agent 交易 |

---

## 🎯 核心应用场景

### 1. 居家养老（重点）
- **目标**：60-80岁老年用户
- **卖点**：一键启动、陪伴聊天、信息防骗
- **产品**：独立硬件盒子（树莓派）

### 2. 网约车 OPC
- **目标**：网约车司机
- **卖点**：抽成从20%降到5%，幸福工作
- **产品**：安卓手机 APP

### 3. 家庭数据
- **目标**：家庭用户
- **卖点**：NAS 存储、隐私保护

### 4. 企业数字化
- **目标**：小微企业
- **卖点**：一站式 IT 基础设施

---

## 🏗️ 系统架构

```
┌─────────────────────────────────────────────────┐
│              应用层 (Application)               │
│   Web UI  │  CLI  │  API  │  Skills            │
├─────────────────────────────────────────────────┤
│              服务层 (Services)                  │
│   Skills Hub  │  大模型  │  存储  │  网络       │
├─────────────────────────────────────────────────┤
│              核心层 (Core)                     │
│   OpenClaw  │  P2P Network (核心创新)          │
├─────────────────────────────────────────────────┤
│              基础设施 (Infrastructure)         │
│   Ubuntu 24.04  │  Docker  │  MongoDB/Redis   │
└─────────────────────────────────────────────────┘
```

---

## 🚀 快速开始

### 环境要求

- Ubuntu 24.04 LTS
- Docker 24.0+
- 4GB+ RAM
- 20GB+ 磁盘空间

### 安装

```bash
# 克隆项目
git clone https://github.com/gthneo/geniusclaw-os.git
cd geniusclaw-os

# 启动服务
docker-compose up -d

# 访问 Web UI
# http://localhost:3000
```

---

## 📦 功能模块

| 模块 | 功能 | 说明 |
|------|------|------|
| `src/core/p2p-network.js` | P2P 网络 | 节点发现、远程维护、市场交易 |
| `src/core/openclaw-integrator.js` | OpenClaw 集成 | AI 对话、技能执行 |
| `src/services/skills-hub.js` | Skills 市场 | 技能发布、搜索、安装 |
| `src/services/model-manager.js` | 大模型管理 | 多模型热插拔 |
| `src/services/nas-service.js` | NAS 存储 | 文件管理、SMB、DLNA |
| `src/services/network-service.js` | 网络服务 | VPN、广告拦截 |

---

## 📄 文档目录

| 文档 | 说明 |
|------|------|
| [00-场景应用大全](00-场景应用大全.md) | 整合所有场景 |
| [01-用户场景](01-用户场景.md) | 用户场景分析 |
| [02-产品需求](02-产品需求.md) | 产品需求规格 |
| [03-界面设计](03-界面设计.md) | UI/UX 设计 |
| [04-技术架构](04-技术架构.md) | 技术架构（P2P Agent 市场） |
| [05-测试用例](05-测试用例.md) | 测试用例 |
| [06-交付手册](06-交付手册.md) | 交付文档 |
| [07-维护手册](07-维护手册.md) | 维护文档 |
| [08-用户手册](08-用户手册.md) | 用户指南 |
| [09-市场推广](09-市场推广.md) | 市场推广方案 |
| [10-开发计划](10-开发计划.md) | 开发计划 |
| [11-快速交付计划](11-快速交付计划.md) | MVP 方案 |
| [15-硬件平台分配](15-硬件平台分配.md) | 硬件平台支持 |
| [17-源码说明文档](17-源码说明文档.md) | 源码详细说明 |

---

## 🌐 P2P Agent 市场

### Agent 标识

```javascript
{
  agentId: "gc-agent-0x7a2f...e3d1",
  hostId: "gc-host-0x9b4c...",
  capabilities: ["skill:file-manager", ...],
  blockchainAddress: "0x..."
}
```

### 交易流程

```
发现 → 询价(HTTP 402) → 报价 → 支付 → 执行 → 确认
```

---

## 💻 源码说明

详细源码说明见 [17-源码说明文档](17-源码说明文档.md)

### 核心类

| 类 | 文件 | 功能 |
|---|------|------|
| `GeniusClawOS` | index.js | 主入口 |
| `P2PNetworkService` | core/p2p-network.js | P2P 网络 |
| `OpenClawIntegrator` | core/openclaw-integrator.js | OpenClaw 集成 |
| `SkillsHubService` | services/skills-hub.js | Skills 市场 |
| `ModelManagerService` | services/model-manager.js | 大模型管理 |
| `NASService` | services/nas-service.js | NAS 存储 |
| `NetworkService` | services/network-service.js | 网络服务 |
| `APIServer` | api/server.js | API 服务器 |

---

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

## 📜 许可证

Apache License 2.0 - 详见 [LICENSE](LICENSE)

---

## 🌍 官网

- **GitHub**: https://github.com/gthneo/geniusclaw-os
- **作者**: GTH Neo (王丁焱)

---

*GeniusClaw OS - 让 AI 走进千家万户* 🦞