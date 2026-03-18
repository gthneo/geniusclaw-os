# 🦞 GeniusClaw OS

> 正龙虾操作系统 - 您的智能数字中枢

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/gthneo/geniusclaw-os)](https://github.com/gthneo/geniusclaw-os/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/gthneo/geniusclaw-os)](https://github.com/gthneo/geniusclaw-os/network)

## 📖 简介

GeniusClaw OS (正龙虾操作系统) 是一款基于 Ubuntu 的智能操作系统，内置 OpenClaw AI 能力，为家庭和企业提供数字化中枢解决方案。

**核心理念**：既要养龙虾，更要聚龙侠，用龙侠

## ✨ 核心特性

| 特性 | 描述 |
|------|------|
| 🧠 AI 自然交互 | 说话就能完成操作 |
| 🔒 隐私保护 | 数据本地存储，拒绝被画像 |
| 🛠️ Skills 市场 | 像装 APP 一样装 AI 技能 |
| 🌐 P2P 网络 | 去中心化节点互联 |
| 💾 NAS 存储 | 本地化影音/文件存储 |
| 🔌 外设驱动 | 智能家居/工业设备对接 |

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
│   OpenClaw  │  Plugin  │  P2P Network         │
├─────────────────────────────────────────────────┤
│              基础设施 (Infrastructure)         │
│   Ubuntu 22.04  │  Docker  │  MongoDB/Redis   │
└─────────────────────────────────────────────────┘
```

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

## 📦 主要模块

| 模块 | 说明 |
|------|------|
| `src/core/openclaw-integrator.js` | OpenClaw 集成 |
| `src/core/p2p-network.js` | P2P 网络服务 |
| `src/services/skills-hub.js` | Skills 市场 |
| `src/services/model-manager.js` | 大模型管理 |
| `src/services/nas-service.js` | NAS 存储服务 |

## 📄 文档

- [用户场景](./01-用户场景.md)
- [产品需求](./02-产品需求.md)
- [技术架构](./04-技术架构.md)
- [开发计划](./10-开发计划.md)
- [快速交付计划](./11-快速交付计划.md)

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

## 📜 许可证

Apache License 2.0 - 详见 [LICENSE](LICENSE)

## 🌍 官网

- GitHub: https://github.com/gthneo/geniusclaw-os
- 作者: GTH Neo (王丁焱)