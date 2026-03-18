# 🦞 GeniusClaw OS

> 正龙虾操作系统 - 您的智能数字中枢

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/gthneo/geniusclaw-os)](https://github.com/gthneo/geniusclaw-os/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/gthneo/geniusclaw-os)](https://github.com/gthneo/geniusclaw-os/network)

## 📖 简介

GeniusClaw OS (正龙虾操作系统) 是一款基于 Ubuntu 24.04 LTS 的智能操作系统，内置 OpenClaw AI 能力，为家庭和企业提供数字化中枢解决方案。

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
| 🤖 Agent 市场 | Agent 间自主交易 |

## 🎯 核心应用场景

### 居家养老（重点场景）
- **目标用户**：60-80岁老年用户
- **核心卖点**：一键启动、陪伴聊天、信息防骗
- **产品形态**：独立硬件盒子，插电即用

### 家庭/企业数字化
- 数据本地存储
- 隐私保护
- AI 助手

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
│   Ubuntu 24.04  │  Docker  │  MongoDB/Redis   │
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

## 📦 七大功能模块

| 模块 | 功能 | 说明 |
|------|------|------|
| M1 | Skills Hub | AI技能市场，按需下载 |
| M2 | 大模型供应链 | 多模型热插拔 |
| M3 | NAS 存储 | 本地化数据管理 |
| M4 | 路由出口 | VPN/广告拦截/隐私 |
| M5 | 外设驱动 | 智能家居/工业设备 |
| M6 | Agent 市场 | P2P 交易网络 |
| M7 | Web3 对接 | 区块链集成 |

## 📄 文档

| 文档 | 说明 |
|------|------|
| [01-用户场景](./01-用户场景.md) | 用户场景分析，含居家养老场景 |
| [02-产品需求](./02-产品需求.md) | 产品需求规格 |
| [03-界面设计](./03-界面设计.md) | UI/UX 设计 |
| [04-技术架构](./04-技术架构.md) | 技术架构（含P2P网络） |
| [10-开发计划](./10-开发计划.md) | 分模块开发计划 |
| [11-快速交付计划](./11-快速交付计划.md) | MVP 快速交付方案 |
| [12-P2P-Agent市场架构](./12-P2P-Agent市场架构.md) | Agent 市场设计 |
| [13-居家养老场景需求](./13-居家养老场景需求.md) | 养老场景详细需求 |
| [14-产品使用流程与营销卖点](./14-产品使用流程与营销卖点.md) | 营销与使用流程 |

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

## 📜 许可证

Apache License 2.0 - 详见 [LICENSE](LICENSE)

## 🌍 官网

- GitHub: https://github.com/gthneo/geniusclaw-os
- 作者: GTH Neo (王丁焱)