# 🦞 GeniusClaw Operation System 完整技术文档

> 版本: v2.1 | 创建日期: 2026-03-19 | 作者: PT (Prometheus Trump)
> 本地文档 | GitHub: https://github.com/gthneo/geniusclaw-os

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

> **核心原则**：算料存储与隐私上网是 **所有场景的基础能力**，而非独立场景。

### 2.0 基础能力（所有场景共用）

> 所有场景都依赖这两个基础能力，因此在技术架构中需要重点表达

#### 2.0.1 算料存储（Data Storage）

**定位**：GC OS 的核心价值之一 - 本地化数据管理

| 能力 | 说明 |
|------|------|
| **NAS 文件共享** | SMB/NFS 协议，支持多设备访问 |
| **影音串流** | Plex/Jellyfin，支持家庭影院 |
| **跨设备同步** | 实时同步工作文档、学习资料 |
| **数据主权** | 隐私数据不出本地，完全自主可控 |

**商业价值**：
- 替代网盘会员（阿里云盘/百度网盘）
- 影视发行渠道收入
- 企业数据管理费

#### 2.0.2 隐私上网（Secure Internet）

**定位**：保护用户免受画像算法、广告追踪、数据泄露

| 能力 | 说明 |
|------|------|
| **VPN/代理** | 加密隧道，保护流量 |
| **广告拦截** | AdGuard，去除广告和追踪器 |
| **数据加密** | 传输加密，隐私保护 |
| **去广告化** | 减少被互联网公司画像 |

**商业价值**：
- 参考向日葵 Sunlogin 的广域网服务模式
- 企业内网访问服务收入

---

### 2.1 场景一：家庭 AI 助手 + 数智家教

**场景描述**：家庭用户拥有本地化 AI 助手，既能保护隐私，又能享受 AI 便利，同时 **系统自动分析孩子上学期间的言行，提供个性化的语言和数理化教育**

**用户画像**：
- 35-55 岁中高收入家庭
- 对数据隐私敏感
- 有学龄儿童（6-18岁）
- 有智能家居需求

**需求要点**：
| 类别 | 功能 | 说明 |
|------|------|------|
| **基础能力** | 本地大模型 | 无需联网也能用 AI |
| **基础能力** | NAS 存储 | 家庭数据本地管理 |
| **基础能力** | 隐私上网 | 保护全家上网隐私 |
| **核心功能** | 数智家教 | AI 分析孩子言行，提供个性化教育 |
| **智能家居** | 中控控制 | 灯光/空调/窗帘等 |

**数智家教详细功能**：

| 功能模块 | 具体描述 | 技术实现 |
|----------|----------|----------|
| **语言能力分析** | 分析孩子的阅读理解、写作表达、口语发音 | NLP + 语音识别 |
| **数理化诊断** | 知识点掌握程度诊断，生成个性化练习 | 知识图谱 + 推荐算法 |
| **学习行为分析** | 记录学习时长、专注度、错误类型 | 时序数据分析 |
| **自适应学习** | 根据能力水平自动调整难度 | 推荐算法 |
| **错题本** | 自动整理错题，推荐同类题型 | 图像识别 + 分类 |
| **学习报告** | 定期生成学习报告，推送给家长 | LLM 生成摘要 |

**数智家教价值链**：

```
孩子学习行为 → 数据采集 → AI 分析 → 个性化内容推荐 → 提升学习效果
      ↓                                            ↓
  隐私存储（本地）                              家长付费（订阅）
```

**痛点解决方案**：
| 痛点 | GC OS 解决方案 |
|------|----------------|
| 隐私担忧 | 数据全部本地存储，不上传云端 |
| 依赖网络 | 离线也可运行基础 AI 功能 |
| 教育资源贵 | 一次性购买，终身使用 |
| 无法了解孩子学习情况 | 自动生成学习报告推送家长 |

---

### 2.2 场景二：中小企业私有 AI + 粉丝经济

**场景描述**：中小企业需要私有化 AI 能力，用于客服、数据分析，**重点强化粉丝获取和销售成单环节的能力分析**

**用户画像**：
- 50人以下的中小企业
- IT 预算有限
- 有数据合规要求
- 依赖线上获客和销售

**需求要点**：

| 类别 | 功能 | 说明 |
|------|------|------|
| **基础能力** | 数据本地化 | 客户数据不出公司 |
| **基础能力** | 隐私上网 | 保护商业机密 |
| **核心功能** | 粉丝获取分析 | AI 分析获客渠道效率 |
| **核心功能** | 销售转化分析 | 成交漏斗、转化率优化 |
| **核心功能** | 私域运营 | 微信/企业微信自动化 |

**粉丝获取与销售成单分析详细功能**：

| 功能模块 | 具体描述 | 输出 |
|----------|----------|------|
| **获客渠道分析** | 各渠道（抖音/小红书/百度/线下）流量分析 | 渠道ROI排名 |
| **用户画像** | 自动分析潜在客户特征 | 精准人群包 |
| **销售漏斗** | 线索→意向→成交→复购 全链路追踪 | 转化率报告 |
| **话术优化** | 分析优秀销售话术，推荐最佳回复 | 话术库 |
| **竞品监控** | 监控竞品价格、活动、评论 | 竞品动态 |
| **复购预测** | 预测客户复购概率和时机 | 复购提醒 |
| **客服机器人** | 7×24h 自动回答，夜间值守 | 响应率提升 |

**SMB 价值流**：

```
获客渠道 → 线索进入 → AI 跟进 → 成交转化 → 复购维护
    ↓           ↓          ↓          ↓          ↓
数据沉淀 → 自我学习 → 越来越聪明 → 效率提升 → 收入增长
```

**痛点解决方案**：
| 痛点 | GC OS 解决方案 |
|------|----------------|
| 公有云成本高 | 私有部署，一次性成本 |
| 数据安全合规 | 数据完全本地，法规合规 |
| 缺乏技术运维 | 开箱即用，自动运维 |
| 获客成本高 | AI 分析优化获客渠道 |

---

### 2.3 场景三：行业垂直解决方案

**场景描述**：特定行业需要定制化 AI 解决方案，**所有行业都内置基础能力（算料存储+隐私上网）**

**行业示例**：

| 行业 | 核心功能 | 基础能力 |
|------|----------|----------|
| **医疗** | 患者随访、健康监测、用药提醒 | 病历本地存储、隐私保护 |
| **制造** | 设备监控、预测维护、质量检测 | 生产数据本地、机密保护 |
| **零售** | 智能客服、库存管理、会员运营 | 客户数据本地、营销隐私 |
| **教育** | 智能备课、作业批改、学情分析 | 学员数据本地、隐私保护 |
| **律所** | 案例检索、合同审核、文书生成 | 案件资料加密存储 |

**行业解决方案架构**：

```
                    ┌─────────────────────┐
                    │   行业 Skills 包     │
                    │ (医疗/制造/零售...)  │
                    └──────────┬──────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
        ▼                      ▼                      ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│  基础能力:    │    │  基础能力:    │    │  基础能力:    │
│  算料存储     │    │  隐私上网     │    │  大模型       │
└───────────────┘    └───────────────┘    └───────────────┘
```

---

### 2.4 场景四：算料存储（基础能力展示）

> *注：作为所有场景的基础能力，此处详细说明技术实现*

**场景描述**：用户需要本地化存储影音、数据，并支持多设备访问

**需求要点**：
- NAS 文件存储（SMB/NFS）
- 跨设备同步
- 影音串流服务（Plex/Jellyfin/Emby）
- 隐私保护（数据不出门）

**存储分层架构**：

```
┌─────────────────────────────────────────────────────┐
│                   应用层                            │
│  文件管理器 | 影音库 | 学习资料 | 工作文档          │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│                   服务层                            │
│  Samba/NFS | Plex | rsync | TimeMachine           │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│                   存储层                            │
│  本地磁盘 | 外接硬盘 | RAID | 网络存储 (NAS)       │
└─────────────────────────────────────────────────────┘
```

---

### 2.5 场景五：隐私上网（基础能力展示）

> *注：作为所有场景的基础能力，此处详细说明技术实现*

**场景描述**：需要安全上网、跨境访问的企业或个人

**需求要点**：
- VPN/代理集成（WireGuard/OpenVPN/Clash）
- 数据加密传输
- 广告拦截（AdGuard Home）
- 隐私保护（去画像）

**网络架构**：

```
用户设备 ──→ GC OS 路由 ──→ 加密隧道 ──→ 出口服务器 ──→ 目标网站
              │                               │
              ├─ 广告拦截                      │
              ├─ 流量统计                      │
              └─ 隐私保护（去追踪）            │
```

---

### 2.6 场景六：居家养老

**场景描述**：独居老人需要健康监测、紧急呼叫、用药提醒

**功能列表**：
- 心率/血压数据采集（健康设备对接）
- 用药提醒（时间+剂量）
- 异常预警（自动通知家属）
- 紧急呼叫一键 SOS
- 语音交互（简化操作）
- 视频监控（可选）
- **基础能力**：健康数据本地存储、隐私保护

---

### 2.7 场景七：网约车司机 OPC（强化版）

**场景描述**：网约车司机需要行程规划、收益统计、订单管理，**以及基于 AI 的运营优化和收益最大化**

**用户画像**：
- 全职或兼职网约车司机
- 同时在多个平台接单（滴滴/高德/曹操/T3等）
- 关注收益最大化
- 需要优化接单策略

**需求要点**：

| 类别 | 功能 | 说明 |
|------|------|------|
| **基础能力** | 算料存储 | 行程记录本地保存 |
| **基础能力** | 隐私上网 | 保护接单隐私 |
| **核心功能** | 多平台订单聚合 | 一屏查看所有平台 |
| **核心功能** | 收益智能分析 | AI 分析最佳接单策略 |

**网约车司机 OPC 详细功能模块**：

#### 2.7.1 订单聚合中心

| 功能 | 描述 | 价值 |
|------|------|------|
| **多平台接入** | 聚合滴滴、高德、曹操、T3、一汽等平台订单 | 不漏单 |
| **抢单提醒** | 实时推送高价单、顺路单 | 抢单快 |
| **智能比价** | 同时比较各平台价格 | 选最优 |
| **自动接单** | 设置条件自动抢单（抢单神器） | 效率高 |

#### 2.7.2 收益统计分析

| 功能 | 描述 | 价值 |
|------|------|------|
| **实时收益** | 今日/本周/本月收入实时显示 | 心中有数 |
| **收益拆解** | 里程费、起步价、奖励分开显示 | 透明清晰 |
| **时薪分析** | 按小时/天/周分析时薪 | 优化排班 |
| **月报生成** | 自动生成月度收益报告 | 方便对账 |
| **扣费分析** | 平台抽成、保险扣费明细 | 清楚成本 |

#### 2.7.3 AI 运营优化（核心价值）

| 功能 | 描述 | 价值 |
|------|------|------|
| **热点预测** | 基于历史数据+实时事件预测热点区域 | 少跑空车 |
| **最佳出车时间** | 分析不同时段收益，推荐最佳出车时间 | 收益最大化 |
| **路线优化** | 同时考虑接单+省油+躲避拥堵 | 成本最低 |
| **长短单搭配** | 分析长短单比例，提供搭配建议 | 效率最高 |
| **天气影响** | 雨天/雪天订单激增预警 | 把握机会 |
| **活动提醒** | 平台活动、奖励时段提醒 | 不错过奖励 |

#### 2.7.4 行程管理

| 功能 | 描述 | 价值 |
|------|------|------|
| **行程记录** | 自动记录每次行程（起点/终点/里程/收益） | 方便对账 |
| **违章提醒** | 接入地图违章数据，提前预警 | 避免罚款 |
| **维修提醒** | 记录保养、保险、年检到期 | 避免过期 |
| **油耗统计** | 记录油耗，计算百公里成本 | 控制成本 |

#### 2.7.5 客户服务

| 功能 | 描述 | 价值 |
|------|------|------|
| **评价分析** | 分析乘客评价，改进服务 | 好评率高 |
| **投诉处理** | 接到投诉时提供话术建议 | 减少扣分 |
| **常见问题** | 常见乘客问题回答库 | 从容应对 |

**网约车司机 OPC 数据流**：

```
┌────────────────────────────────────────────────────────────────┐
│                     GC OS 网约车司机 OPC                        │
├────────────────────────────────────────────────────────────────┤
│  数据输入层                                                      │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐               │
│  │ 平台API │ │ GPS定位 │ │ 手动输入│ │ 外部数据│               │
│  │ (订单)  │ │ (行程)  │ │ (费用)  │ │ (天气)  │               │
│  └────┬────┘ └────┬────┘ └────┬────┘ └────┬────┘               │
│       │          │          │          │                        │
│       └──────────┴─────────┴──────────┘                        │
│                           │                                     │
│                           ▼                                     │
│  数据处理层 (AI 分析)                                          │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐                │
│  │ 收益分析    │ │ 热点预测    │ │ 路线优化    │                │
│  │             │ │  (ML 模型)  │ │  (算法)     │                │
│  └──────┬──────┘ └──────┬──────┘ └──────┬──────┘                │
│         │               │               │                        │
│         └───────────────┴───────────────┘                        │
│                           │                                     │
│                           ▼                                     │
│  输出展示层                                                      │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐                 │
│  │ 收益报表│ │ 热力图  │ │ 智能推荐│ │ 行程记录│                 │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘                 │
└────────────────────────────────────────────────────────────────┘
```

**网约车司机 OPC 商业模式**：

```
收入来源：
├── 软件订阅费（月费/年费）
├── 高端功能付费（AI 预测、抢单神器）
├── 交易抽成（可选）
└── 广告（司机端广告，精准投放）

成本：
├── 平台对接成本
├── AI 模型运行成本
└── 数据存储成本

利润模型：
├── 首年免费 → 续费转化
├── 基础版免费 → 高级版付费
└── 线下培训 + 咨询服务
```

**与竞品对比**：

| 功能 | GC OS OPC | 滴滴车友 | 其他竞品 |
|------|-----------|----------|----------|
| 多平台聚合 | ✅ 全平台 | ❌ 仅滴滴 | 部分支持 |
| AI 热点预测 | ✅ 独家 | ❌ 无 | ❌ 无 |
| 本地数据存储 | ✅ 隐私优先 | ❌ 云端 | 部分 |
| 离线可用 | ✅ 支持 | ❌ 不支持 | ❌ 不支持 |
| 价格 | 订阅制 | 免费+广告 | 付费 |

---

### 2.8 场景总结

| 场景 | 基础能力 | 核心价值 | 目标用户 |
|------|----------|----------|----------|
| 家庭 AI + 数智家教 | 算料+隐私上网 | AI 家教、隐私保护 | 有孩家庭 |
| SMB 私有 AI | 算料+隐私上网 | 粉丝获取、销售转化 | 50人以下企业 |
| 行业解决方案 | 算料+隐私上网 | 行业定制、数据安全 | 医疗/制造/零售等 |
| 算料存储 | - | NAS、影音串流 | 所有用户 |
| 隐私上网 | - | VPN、广告拦截 | 所有用户 |
| 居家养老 | 算料+隐私上网 | 健康监测、SOS | 老年人家庭 |
| 网约车司机 OPC | 算料+隐私上网 | 多平台聚合、AI 运营 | 司机群体 |

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

### 6.1 测试策略

#### 🧪 TDD 开发模式（核心原则）

> **重要**：GC OS 开发采用 **测试驱动开发 (Test-Driven Development)** 流程

```
TDD 循环：
┌─────────────────────────────────────────────────────────┐
│  1. 编写测试 (Red)     →  测试失败，显示需求           │
│         ↓                                             │
│  2. 编写代码 (Green)   →  通过测试，实现功能           │
│         ↓                                             │
│  3. 重构 (Refactor)     →  优化代码，保持测试通过       │
│         ↓                                             │
│  4. 提交 → 循环                                       │
└─────────────────────────────────────────────────────────┘
```

**TDD 开发流程**：

```bash
# 1. 创建测试文件
# tests/skills/engine.test.ts

# 2. 运行测试（红色 - 失败）
npm test -- --testPathPattern=skills/engine

# 3. 编写最小代码通过测试（绿色）
# src/skills/engine.ts

# 4. 重构优化
# 保持测试通过

# 5. 提交
git commit -m "feat(skills): add engine implementation"
```

#### 6.1.1 测试金字塔

```
                    ┌─────────────┐
                    │   E2E 测试   │  ← 少量，关键场景
                   ┌──────────────┐ │
                   │  集成测试    │ │ ← 中等，模块交互
                  ┌───────────────┐ │
                  │   单元测试    │ │ ← 大量，独立功能
                 ┌────────────────┐│
                 │   Mock/Stub    ││
                 └────────────────┘┘
```

#### 6.1.2 测试环境

| 环境 | 用途 | 配置 |
|------|------|------|
| **开发环境** | 本地开发调试 | 4核8GB, 模拟存储 |
| **测试环境** | 自动化测试 | 8核16GB, 真机 |
| **预发布环境** | 验收测试 | 与生产一致 |
| **生产环境** | 最终部署 | 目标硬件 |

#### 6.1.2 测试数据管理

```typescript
// 测试数据结构
interface TestData {
  id: string;
  category: 'skill' | 'llm' | 'network' | 'storage';
  name: string;
  input: any;
  expected: any;
  fixtures?: {
    skillPackage?: string;
    modelFile?: string;
    config?: any;
  };
}

// 测试数据示例
const testDatasets = {
  skills: [
    { id: 'skill-home-care', name: '居家养老场景', enabled: true },
    { id: 'skill-transport', name: '网约车场景', enabled: false }
  ],
  llm: [
    { id: 'llama2', provider: 'ollama', size: '7b' },
    { id: 'gpt-4', provider: 'openrouter' }
  ],
  network: [
    { type: 'dhcp', expected: { connected: true } },
    { type: 'pppoe', username: 'test', password: 'test123' }
  ]
};
```

---

### 6.2 单元测试

#### 6.2.1 Skills 模块

| 用例ID | 测试场景 | 前置条件 | 测试步骤 | 预期结果 | 优先级 | 测试框架 |
|--------|----------|----------|----------|----------|--------|----------|
| UT-SKL-001 | 加载有效 Skill 包 | Skill 包完整 | 调用 loadSkill('valid-skill.zip') | 返回 Skill 对象，状态为 loaded | P0 | Jest |
| UT-SKL-002 | 安装 Skill | 有效的 Skill | 调用 installSkill(skill) | 文件正确创建，配置写入注册表 | P0 | Jest |
| UT-SKL-003 | 卸载 Skill | Skill 已安装 | 调用 uninstallSkill(skillId) | 完全清理，无残留文件 | P0 | Jest |
| UT-SKL-004 | Skill 配置验证 - 无效配置 | 配置文件损坏 | 调用 validateConfig(config) | 抛出 ValidationError | P1 | Jest |
| UT-SKL-005 | Skill 依赖检查 | Skill 有依赖 | 调用 checkDependencies(skill) | 正确识别并列出缺失依赖 | P1 | Jest |
| UT-SKL-006 | 运行 Skill | Skill 已安装 | 调用 runSkill(skillId, context) | 返回预期结果 | P0 | Jest |
| UT-SKL-007 | 停止 Skill | Skill 正在运行 | 调用 stopSkill(skillId) | Skill 进程停止 | P0 | Jest |
| UT-SKL-008 | 验证 Skill 签名 | Skill 已签名 | 调用 verifySignature(skill) | 返回 true/false | P1 | Jest |
| UT-SKL-009 | Skill 生命周期转换 | Skill 各种状态 | 触发状态转换 | 状态正确转换 | P2 | Jest |
| UT-SKL-010 | Skill 并发运行限制 | 多个 Skill | 启动超过限制的 Skill | 正确拒绝 | P2 | Jest |

**Skill 模块测试代码示例**:

```typescript
// skills.test.ts
import { SkillEngine } from './engine';
import { Skill } from './types';

describe('SkillEngine', () => {
  let engine: SkillEngine;
  
  beforeEach(() => {
    engine = new SkillEngine({
      basePath: '/test/skills',
      installPath: '/test/install',
      registryPath: '/test/registry.json'
    });
  });
  
  describe('loadSkill()', () => {
    it('should load valid skill package', async () => {
      const skill = await engine.loadSkill('./fixtures/valid-skill.zip');
      expect(skill).toBeInstanceOf(Skill);
      expect(skill.status).toBe('loaded');
    });
    
    it('should throw on invalid package', async () => {
      await expect(engine.loadSkill('./fixtures/invalid.zip'))
        .rejects.toThrow('Invalid skill package');
    });
  });
  
  describe('installSkill()', () => {
    it('should install skill to specified directory', async () => {
      const skill = await engine.loadSkill('./fixtures/valid-skill.zip');
      await engine.installSkill(skill);
      expect(fs.existsSync('/test/install/skill-home-care')).toBe(true);
    });
  });
  
  describe('runSkill()', () => {
    it('should execute skill and return result', async () => {
      const result = await engine.runSkill('skill-home-care', {
        input: { action: 'sos' },
        context: { userId: 'user1' }
      });
      expect(result.success).toBe(true);
    });
  });
});
```

#### 6.2.2 大模型模块 (LLM)

| 用例ID | 测试场景 | 前置条件 | 测试步骤 | 预期结果 | 优先级 | 测试框架 |
|--------|----------|----------|----------|----------|--------|----------|
| UT-LLM-001 | 连接 Ollama | Ollama 运行中 | 调用 connect() | 连接成功，无异常 | P0 | Jest |
| UT-LLM-002 | 断开 Ollama | 已连接 | 调用 disconnect() | 正确断开 | P0 | Jest |
| UT-LLM-003 | 获取模型列表 | Ollama 运行 | 调用 listModels() | 返回模型数组 | P0 | Jest |
| UT-LLM-004 | 下载模型 | 有可用模型 | 调用 downloadModel('llama2') | 下载成功 | P0 | Jest |
| UT-LLM-005 | 删除模型 | 模型已下载 | 调用 removeModel('llama2') | 删除成功 | P0 | Jest |
| UT-LLM-006 | 文本生成 | 模型已加载 | 调用 generate('Hello') | 返回生成文本 | P0 | Jest |
| UT-LLM-007 | 对话推理 | 模型已加载 | 调用 chat(messages) | 返回对话结果 | P0 | Jest |
| UT-LLM-008 | 切换默认模型 | 多个模型 | 调用 setDefaultModel('llama2') | 切换成功 | P0 | Jest |
| UT-LLM-009 | 模型性能监控 | 生成完成 | 调用 getMetrics() | 返回性能指标 | P1 | Jest |
| UT-LLM-010 | Provider 切换 | 多个 Provider | 调用 switchProvider('openrouter') | 切换成功 | P1 | Jest |
| UT-LLM-011 | Embedding 向量 | 模型已加载 | 调用 embed('text') | 返回向量数组 | P1 | Jest |

**LLM 模块测试代码示例**:

```typescript
// llm-manager.test.ts
import { LLMManager } from './manager';

describe('LLMManager', () => {
  let manager: LLMManager;
  let mockProvider: jest.Mocked<any>;
  
  beforeEach(() => {
    manager = new LLMManager();
    mockProvider = {
      id: 'ollama', name: 'Ollama', type: 'local',
      connect: jest.fn().mockResolvedValue(undefined),
      listModels: jest.fn().mockResolvedValue([
        { id: 'llama2', name: 'Llama 2', size: 4000000000, status: 'downloaded' }
      ]),
      generate: jest.fn().mockResolvedValue('Generated text'),
      chat: jest.fn().mockResolvedValue({ role: 'assistant', content: 'Response' }),
    } as any;
    manager.registerProvider(mockProvider);
  });
  
  describe('listModels()', () => {
    it('should return all models from all providers', async () => {
      const models = await manager.listModels();
      expect(models.length).toBeGreaterThan(0);
    });
  });
  
  describe('generate()', () => {
    it('should generate text and record metrics', async () => {
      const result = await manager.generate('Hello');
      expect(result).toBe('Generated text');
    });
    
    it('should handle generation errors', async () => {
      mockProvider.generate.mockRejectedValue(new Error('Model not found'));
      await expect(manager.generate('test')).rejects.toThrow('Model not found');
    });
  });
});
```

#### 6.2.3 网络模块

| 用例ID | 测试场景 | 预期结果 | 优先级 |
|--------|----------|----------|--------|
| UT-NET-001 | 获取网络状态 (DHCP) | 返回正确状态，IP已分配 | P0 |
| UT-NET-002 | 连接 PPPoE | 连接成功 | P0 |
| UT-NET-003 | 断开 PPPoE | 断开成功 | P0 |
| UT-NET-004 | 配置静态 IP | IP 配置生效 | P0 |
| UT-NET-005 | 启动 VPN | VPN 运行 | P1 |
| UT-NET-006 | 停止 VPN | VPN 停止 | P1 |
| UT-NET-007 | 配置广告拦截 | 拦截规则生效 | P1 |
| UT-NET-008 | 获取实时网速 | 返回上传/下载速度 | P1 |
| UT-NET-009 | 网络自动重连 | 自动重连成功 | P2 |
| UT-NET-010 | 流量统计 | 返回统计数据 | P2 |

#### 6.2.4 存储模块 (NAS)

| 用例ID | 测试场景 | 预期结果 | 优先级 |
|--------|----------|----------|--------|
| UT-NAS-001 | 创建存储卷 | 卷创建成功 | P0 |
| UT-NAS-002 | 挂载存储卷 | 挂载成功 | P0 |
| UT-NAS-003 | 卸载存储卷 | 卸载成功 | P0 |
| UT-NAS-004 | 配置 SMB 共享 | 共享配置成功 | P0 |
| UT-NAS-005 | 配置 NFS 共享 | 共享配置成功 | P0 |
| UT-NAS-006 | 启动 Plex | Plex 运行 | P1 |
| UT-NAS-007 | 停止 Plex | Plex 停止 | P1 |
| UT-NAS-008 | 磁盘健康检查 | 返回健康状态 | P1 |
| UT-NAS-009 | RAID 配置 | RAID 创建成功 | P2 |

#### 6.2.5 外设模块

| 用例ID | 测试场景 | 预期结果 | 优先级 |
|--------|----------|----------|--------|
| UT-PRD-001 | 扫描外设 | 返回设备列表 | P0 |
| UT-PRD-002 | 安装驱动 | 驱动安装成功 | P0 |
| UT-PRD-003 | 智能家居 MQTT | 连接成功 | P1 |
| UT-PRD-004 | 发送 MQTT 命令 | 命令发送成功 | P1 |
| UT-PRD-005 | Modbus 通信 | 返回数据 | P2 |
| UT-PRD-006 | Zigbee 设备配对 | 配对成功 | P2 |

#### 6.2.6 区块链模块

| 用例ID | 测试场景 | 预期结果 | 优先级 |
|--------|----------|----------|--------|
| UT-BC-001 | 创建钱包 | 钱包创建成功 | P2 |
| UT-BC-002 | 导入钱包 | 导入成功 | P2 |
| UT-BC-003 | 获取余额 | 返回余额 | P2 |
| UT-BC-004 | 转账 | 交易提交成功 | P2 |
| UT-BC-005 | 调用智能合约 | 返回结果 | P2 |

---

### 6.3 集成测试

#### 6.3.1 模块间集成

| 用例ID | 测试场景 | 涉及模块 | 预期结果 | 优先级 |
|--------|----------|----------|----------|--------|
| IT-001 | Skills 调用 LLM 生成 | Skills + LLM | 正常返回结果 | P0 |
| IT-002 | Skills 读取文件系统 | Skills + Storage | 正确读取 | P0 |
| IT-003 | NAS 存储读写 | NAS + Storage | 读写成功 | P0 |
| IT-004 | VPN 连接外部服务 | Network + VPN | 连接成功 | P1 |
| IT-005 | 外设识别并驱动 | Peripherals + Driver | 正确识别 | P0 |
| IT-006 | 移动端 App 远程控制 | Mobile + API | 控制成功 | P1 |
| IT-007 | 多 Skills 并发运行 | Skills × N | 并发正常 | P1 |
| IT-008 | Web UI 配置网络 | UI + Network | 配置生效 | P0 |
| IT-009 | 区块链支付流程 | Blockchain + Skills | 支付成功 | P2 |

#### 6.3.2 端到端场景

| 用例ID | 场景描述 | 预期结果 | 优先级 |
|--------|----------|----------|--------|
| E2E-001 | 居家养老 SOS | 家属收到通知 | P0 |
| E2E-002 | 网约车收益统计 | 报表生成 | P1 |
| E2E-003 | NAS 影片串流 | 播放流畅 | P1 |
| E2E-004 | 智能家居控制 | 设备响应 | P1 |

**集成测试代码示例**:

```typescript
// integration.test.ts
describe('Skills + LLM Integration', () => {
  it('should generate response via LLM in skill', async () => {
    const skillEngine = new SkillEngine(config);
    const llmManager = new LLMManager();
    
    const skill = await skillEngine.loadSkill('./fixtures/llm-skill.zip');
    await skillEngine.installSkill(skill);
    
    const result = await skillEngine.runSkill(skill.id, {
      input: { prompt: 'Say hello' },
      context: { useLLM: true }
    });
    
    expect(result.output).toContain('hello');
  });
});
```

---

### 6.4 系统测试

#### 6.4.1 安装与启动

| 用例ID | 测试场景 | 预期结果 | 判定标准 |
|--------|----------|----------|----------|
| ST-001 | ISO 全新安装 | 安装成功 | 无错误日志 |
| ST-002 | 升级安装 | 数据保留 | 配置完整 |
| ST-003 | 冷启动时间 | < 30s | 计时 < 30s |
| ST-004 | 热重启 | < 60s | 计时 < 60s |

#### 6.4.2 稳定性测试

| 用例ID | 测试场景 | 预期结果 | 判定标准 |
|--------|----------|----------|----------|
| ST-005 | 24小时连续运行 | 无崩溃 | 无 error 日志 |
| ST-006 | 内存泄漏检测 | 内存稳定 | 增长 < 10% |
| ST-007 | 断电恢复 | 自动恢复 | 服务正常 |
| ST-008 | 网络异常恢复 | 自动重连 | 恢复正常 |

#### 6.4.3 性能测试

| 用例ID | 指标 | 目标值 | 测试方法 |
|--------|------|--------|----------|
| ST-009 | 启动时间 | < 30s | 计时 |
| ST-010 | API 响应时间 | < 200ms | 压力测试 |
| ST-011 | 并发 Skill 数 | ≥ 10 | 负载测试 |
| ST-012 | 模型推理延迟 | < 2s (7b) | 基准测试 |
| ST-013 | NAS 读写速度 | > 100 MB/s | 性能测试 |
| ST-014 | 内存占用 (空闲) | < 2GB | 监控 |

#### 6.4.4 安全测试

| 用例ID | 测试场景 | 预期结果 |
|--------|----------|----------|
| ST-015 | 权限绕过 | 拒绝访问 |
| ST-016 | SQL 注入 | 过滤/拒绝 |
| ST-017 | XSS 攻击 | 过滤/转义 |
| ST-018 | 敏感数据加密 | 已加密 |
| ST-019 | Skill 沙箱隔离 | 隔离有效 |

#### 6.4.5 兼容性测试

| 用例ID | 测试对象 | 预期结果 |
|--------|----------|----------|
| ST-020 | x86_64 平台 | 正常运行 |
| ST-021 | ARM64 平台 | 正常运行 |
| ST-022 | 虚拟机环境 | 正常运行 |
| ST-023 | 常见网卡 | 驱动正常 |
| ST-024 | 常见显卡 | 显示正常 |

---

### 6.5 UI 自动化测试

| 用例ID | 页面 | 测试场景 | 预期结果 |
|--------|------|----------|----------|
| UI-001 | 仪表盘 | 加载首页 | 显示系统状态 |
| UI-002 | Skills 市场 | 浏览技能 | 列表显示正常 |
| UI-003 | Skills 安装 | 点击安装 | 安装成功 |
| UI-004 | 网络设置 | 配置 PPPoE | 保存成功 |
| UI-005 | 存储管理 | 创建卷 | 创建成功 |
| UI-006 | 响应式设计 | 缩放窗口 | 布局正确 |

**UI 测试代码示例**:

```typescript
// web-ui.test.ts
import { test, expect } from '@playwright/test';

test('Skills Market - should install skill', async ({ page }) => {
  await page.goto('/skills');
  await page.click('.skill-card:first-child .install-btn');
  await expect(page.locator('.notification'))
    .toContainText('安装成功');
});
```

---

### 6.6 测试执行

#### 6.6.1 测试命令

```bash
# 运行所有单元测试
npm test

# 运行单元测试（带覆盖率）
npm test -- --coverage

# 运行特定模块测试
npm test -- --testPathPattern=skills

# 运行集成测试
npm run test:integration

# 运行 E2E 测试
npm run test:e2e
```

#### 6.6.2 CI/CD 集成

```yaml
# .github/workflows/test.yml
name: Test Suite

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '22'
      - name: Install dependencies
        run: npm ci
      - name: Run unit tests
        run: npm test -- --coverage
      - name: Run integration tests
        run: npm run test:integration
```

---

### 6.7 缺陷管理

#### 6.7.1 缺陷等级

| 等级 | 定义 | 响应时间 | 示例 |
|------|------|----------|------|
| P0-Critical | 系统崩溃，数据丢失 | 立即 | 无法启动 |
| P1-High | 核心功能不可用 | 24h | Skill 无法运行 |
| P2-Medium | 功能异常 | 72h | UI 显示错误 |
| P3-Low | 界面/体验问题 | 1周 | 文字错位 |

#### 6.7.2 缺陷报告模板

```markdown
## 缺陷报告

**ID**: BUG-001
**标题**: [简要描述]
**严重等级**: P0/P1/P2/P3
**模块**: Skills/LLM/Network/NAS/...
**复现步骤**:
1. [步骤1]
2. [步骤2]
**预期结果**: [期望]
**实际结果**: [实际]
**日志**: [相关日志]
```

---

## 6.5 开发里程碑 (Roadmap)

> **TDD 开发模式**：每个里程碑遵循 测试驱动开发

### 6.5.1 MVP - 智能客户端 (第一阶段)

**目标**：发布最小可用客户端，自动发现并接入 OpenClaw

**发布时间**：明天 (2026-03-20)

**交付内容**：

| 组件 | 功能 | 技术 |
|------|------|------|
| **Windows 客户端** | 桌面端应用 | Flutter Windows |
| **移动端 App** | iOS/Android | Flutter Mobile |
| **自动发现** | 局域网发现 OpenClaw | mDNS/Bonjour |
| **接入协议** | WebSocket 通信 | JSON-RPC |
| **认证** | Token 认证 | JWT |

**功能清单**：

```
MVP 客户端功能：
├── 自动发现 GC OS / OpenClaw 节点
│   ├── 局域网 mDNS 广播
│   ├── 手动添加 IP
│   └── 连接状态显示
│
├── 基础连接
│   ├── Token 认证登录
│   ├── 心跳保活
│   └── 断线重连
│
├── 消息通道
│   ├── 发送消息
│   ├── 接收消息
│   └── 消息历史
│
└── 设备状态
    ├── CPU/内存/存储
    └── 在线状态
```

**技术架构**：

```
┌─────────────────────────────────────────────────────┐
│              MVP 客户端                              │
├─────────────────────────────────────────────────────┤
│  UI 层 (Flutter)                                    │
│  ├── 首页（设备列表）                                │
│  ├── 聊天窗口                                        │
│  └── 设置                                            │
├─────────────────────────────────────────────────────┤
│  业务层                                              │
│  ├── DiscoveryService  (mDNS 发现)                  │
│  ├── ConnectionManager (连接管理)                    │
│  ├── MessageChannel  (消息通道)                      │
│  └── StateNotifier    (状态管理)                    │
├─────────────────────────────────────────────────────┤
│  网络层                                              │
│  ├── mDNS/bonjour  (设备发现)                       │
│  ├── WebSocket     (实时通信)                        │
│  └── REST API      (API 调用)                       │
└─────────────────────────────────────────────────────┘
              │
              ▼
┌─────────────────────────────────────────────────────┐
│           OpenClaw Gateway                           │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐  │
│  │  WebSocket  │ │   Channels   │ │   Memory    │  │
│  │  Handler    │ │   (飞书/微信)│ │  (对话历史)  │  │
│  └─────────────┘ └─────────────┘ └─────────────┘  │
└─────────────────────────────────────────────────────┘
```

**TDD 开发流程**：

```bash
# 1. 先写测试
tests/
├── discovery_test.dart      # mDNS 发现测试
├── connection_test.dart      # 连接管理测试
├── message_test.dart       # 消息通道测试
└── state_test.dart         # 状态管理测试

# 2. 运行测试（红色）
flutter test

# 3. 编写代码通过测试（绿色）
lib/
├── services/
│   ├── discovery_service.dart
│   ├── connection_manager.dart
│   └── message_channel.dart

# 4. 重构优化
# 保持测试通过
```

**验收标准**：

| 用例 | 预期结果 |
|------|----------|
| 局域网自动发现 | 3秒内发现 OpenClaw 节点 |
| 手动添加 | IP/端口方式连接 |
| 消息发送 | 实时送达 |
| 断线重连 | 自动重连，恢复状态 |
| 设备状态 | 实时显示 CPU/内存/存储 |

---

### 6.5.2 Phase 2 - 完整功能客户端

**目标**：完善客户端功能，支持 Skills/LLM 控制

**计划时间**：2026-04

**功能**：
- Skills 市场浏览
- LLM 模型切换
- 存储管理
- 网络配置

---

### 6.5.3 Phase 3 - GC OS 镜像

**目标**：发布完整操作系统镜像

**计划时间**：2026-05

**功能**：
- Ubuntu 裁剪版
- OpenClaw 预装
- Web UI 预装
- 基础 Skills 预装

---

### 6.5.4 Phase 4 - 云端服务

**目标**：提供云端管理平台

**计划时间**：2026-06

**功能**：
- 远程管理
- 设备监控
- 固件 OTA 推送

---

### 6.5.4 团队分工与预算估算

#### 6.5.4.1 团队分工

| 角色 | 名称 | 职责 | 状态 |
|------|------|------|------|
| **PT** | 普罗米修斯 | 架构设计 + 文档 + 规划 | 在岗 |
| **HT** | 赫尔墨斯 | 任务管理 + 进度跟踪 | 待配置 |
| **Builder** | 构建者 | Flutter 编码实现 | 可引入 |

#### 6.5.4.2 预算估算 (基于 Claude 模型)

**前提假设**：
- 使用 Claude 3.5 Sonnet ($3/M input, $15/M output)
- 80% 代码生成 + 20% 调试/Review
- 平均每次交互: 10K input + 5K output

---

##### MVP 阶段 (明天交付)

| 模块 | 交互次数 | 估算 Token | 成本 (USD) |
|------|----------|------------|------------|
| Flutter 框架搭建 | 50 | 750K | $11.25 |
| mDNS 发现服务 | 30 | 450K | $6.75 |
| WebSocket 通信 | 30 | 450K | $6.75 |
| 认证模块 | 20 | 300K | $4.50 |
| UI 界面 | 40 | 600K | $9.00 |
| 测试代码 | 30 | 450K | $6.75 |
| **MVP 小计** | **200** | **3M** | **$45** |

---

##### Phase 2 (完整客户端 - 1个月)

| 模块 | 预估交互 | Token 估算 | 成本 (USD) |
|------|----------|------------|------------|
| Skills 控制 | 200 | 3M | $45 |
| LLM 管理 | 150 | 2.25M | $33.75 |
| 存储管理 | 100 | 1.5M | $22.50 |
| 网络配置 | 100 | 1.5M | $22.50 |
| 测试 | 150 | 2.25M | $33.75 |
| **Phase 2 小计** | **700** | **10.5M** | **$157.50** |

---

##### Phase 3 (GC OS 镜像 - 1个月)

| 模块 | 预估交互 | Token 估算 | 成本 (USD) |
|------|----------|------------|------------|
| Ubuntu 裁剪 | 100 | 1.5M | $22.50 |
| OpenClaw 集成 | 200 | 3M | $45 |
| Web UI | 150 | 2.25M | $33.75 |
| 驱动适配 | 100 | 1.5M | $22.50 |
| 安装脚本 | 50 | 750K | $11.25 |
| **Phase 3 小计** | **600** | **9M** | **$135** |

---

##### Phase 4 (云端服务 - 1个月)

| 模块 | 预估交互 | Token 估算 | 成本 (USD) |
|------|----------|------------|------------|
| 后端 API | 200 | 3M | $45 |
| 设备管理 | 100 | 1.5M | $22.50 |
| OTA 推送 | 80 | 1.2M | $18 |
| 监控面板 | 100 | 1.5M | $22.50 |
| 安全加固 | 70 | 1M | $15 |
| **Phase 4 小计** | **550** | **8.2M** | **$123** |

---

##### 总预算估算

| 阶段 | 时间 | Token 总量 | 成本 (USD) |
|------|------|------------|-------------|
| MVP | 1天 | 3M | $45 |
| Phase 2 | 1个月 | 10.5M | $157.50 |
| Phase 3 | 1个月 | 9M | $135 |
| Phase 4 | 1个月 | 8.2M | $123 |
| **总计** | **3个月** | **30.7M** | **$460.50** |

---

##### 成本优化建议

| 策略 | 效果 |
|------|------|
| **使用 Haiku 做简单代码** | 成本降低 80% |
| **只对复杂逻辑用 Sonnet** | 成本降低 40% |
| **本地模型 (Ollama)** | 边际成本 ≈ $0 |
| **一次性开发，长期维护** | 后续成本递减 |

> **推荐方案**：MVP 阶段先用 Sonnet 快速开发
> - 预计成本：$50-100（今天）
> - 验证可行后，Phase 2 可考虑 Ollama 本地模型

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