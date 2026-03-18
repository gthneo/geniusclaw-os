# P2P Agent 市场架构设计

## 一、WireGuard 与 P2P 的关系

### 1.1 WireGuard 是开源的

| 项目 | 状态 |
|------|------|
| WireGuard | ✅ 开源 (GPL v2) |
| 代码仓库 | https://github.com/WireGuard |

**WireGuard** 作为轻量级 VPN，适合：
- 端到端加密隧道
- 远程访问场景（类似向日葵）
- 但**不适合**作为 Agent 市场的基础设施

---

### 1.2 为什么需要独立的 P2P 网络？

| 特性 | WireGuard | P2P 市场网络 |
|------|------------|--------------|
| 用途 | VPN 隧道 | Agent 发现与交易 |
| 连接方式 | 静态配置 | 动态发现 |
| 身份标识 | IP/证书 | Agent ID + 区块链地址 |
| 交易能力 | ❌ | ✅ Agent 间交易 |
| 支付协议 | ❌ | ✅ HTTP 402 / 数字货币 |

**结论**：WireGuard 用于路由出口模块（M6），P2P 市场需要独立的 libp2p 网络。

---

## 二、Agent 身份与连接架构

### 2.1 每个 Agent 的唯一标识

```javascript
// Agent 身份结构
{
  agentId: "gc-agent-0x7a2f...e3d1",     // 全网唯一 ID
  hostId: "gc-host-0x9b4c...f2e8",       // 主机 ID
  publicKey: "ed25519-...",              // 公钥（用于签名）
  blockchainAddress: "0x...",           // 区块链地址（可选）
  capabilities: ["skill:file-manager", "skill:ai-chat"], // 能力清单
  endpoint: "/p2p/QmX...",               // P2P 地址
  status: "online" | "busy" | "offline"
}
```

### 2.2 P2P 连接拓扑

```
┌─────────────────────────────────────────────────────────────────┐
│                    Global P2P Agent Network                    │
│                                                                  │
│   ┌──────────────┐          ┌──────────────┐                  │
│   │  Host A      │◄────────►│  Host B      │                  │
│   │ Agent-001    │   P2P    │ Agent-002    │                  │
│   │ Agent-002    │          │ Agent-003    │                  │
│   └──────────────┘          └──────────────┘                  │
│          │                         │                           │
│          │    ┌──────────────┐     │                           │
│          └───►│  Host C      │◄────┘                           │
│               │ Agent-004    │                                  │
│               │ Agent-005    │                                  │
│               └──────────────┘                                  │
│                                                                  │
│   每台主机上的每个 Agent 都是独立节点                            │
│   共享 P2P 网络，发现彼此，交易能力                              │
└─────────────────────────────────────────────────────────────────┘
```

---

## 三、Agent 市场交易机制

### 3.1 交易场景

| 场景 | 描述 |
|------|------|
| **Skills 交易** | Agent A 向 Agent B 购买某个 Skill |
| **算力交易** | Agent A 租用 Agent B 的 GPU 算力 |
| **数据交易** | Agent A 向 Agent B 购买数据集 |
| **服务交易** | Agent A 调用 Agent B 的 API 服务 |

### 3.2 交易流程

```
┌────────────────────────────────────────────────────────────────┐
│                    Agent A → Agent B                           │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1️⃣ 发现                                                         │
│     A 通过 P2P 发现 B，获取 B 的能力清单                         │
│                                                                 │
│  2️⃣ 询价                                                         │
│     A 发送 HTTP 402 预支付请求，询问价格                         │
│                                                                 │
│  3️⃣ 报价                                                         │
│     B 返回价格（代币/数字货币）                                  │
│                                                                 │
│  4️⃣ 支付                                                         │
│     A 发起支付，锁定资金                                         │
│                                                                 │
│  5️⃣ 执行                                                         │
│     B 执行服务，生成结果                                         │
│                                                                 │
│  6️⃣ 确认                                                         │
│     A 确认结果，资金释放给 B                                     │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

### 3.3 HTTP 402 支付协议

```javascript
// HTTP 402 Payment Required 扩展
{
  // 请求
  GET /agent/service HTTP/1.1
  X-Agent-ID: gc-agent-0x7a2f...
  X-Payment-Token: usdt-erc20-0x...
  
  // 响应 (需要支付)
  HTTP/1.1 402 Payment Required
  X-Payment-Amount: 10 USDC
  X-Payment-Address: 0xB... (B 的钱包)
  WWW-Authenticate: PaymentRequired 
  {"price": "10 USDC", "currency": "stablecoin"}
}
```

---

## 四、技术实现

### 4.1 P2P 网络技术栈

| 层级 | 技术 | 用途 |
|------|------|------|
| **网络层** | libp2p / Helia | 节点发现、连接、传输 |
| **身份层** | DID / DIDComm | Agent 身份认证 |
| **消息层** | JSON-RPC / gRPC | Agent 间通信 |
| **支付层** | x402 / 稳定币 | HTTP 402 支付协议 |
| **可选层** | IPFS | 数据存储与分发 |

### 4.2 节点发现机制

```javascript
// P2P 引导与发现
class AgentNetwork {
  async connect(bootNodes) {
    // 1. 连接引导节点
    // 2. 获取活跃 Agent 列表
    // 3. 建立 P2P 连接
    // 4. 广播自身能力
  }

  async discoverAgents(capability) {
    // 根据能力过滤 Agent
    // 返回可用 Agent 列表
  }

  async tradeWith(agentId, service) {
    // 发现 → 询价 → 支付 → 执行 → 确认
  }
}
```

### 4.3 智能合约（可选）

```solidity
// Agent Marketplace Contract
contract AgentMarketplace {
    // Agent 注册
    function registerAgent(string memory capabilities) external;
    
    // 服务报价
    function setPrice(string memory service, uint256 price) external;
    
    // 托管支付
    function createEscrow(address seller, uint256 amount) external;
    
    // 释放资金
    function releaseFunds(address seller) external;
}
```

---

## 五、市场形态

### 5.1 从细分到全局

| 阶段 | 市场形态 | 说明 |
|------|----------|------|
| **v0.5** | Skills 市场 | Agent 间交易 Skills |
| **v0.7** | 算力市场 | 租 GPU / CPU 算力 |
| **v1.0** | 全市场 | 衣食住行 Agent 大市场 |

### 5.2 商业收益

| 来源 | 描述 |
|------|------|
| **交易手续费** | 每笔交易收取 1-5% |
| **支付网关** | 资金池利息收入 |
| **广告推荐** | 热门 Agent 推广 |
| **增值服务** | 交易保险、仲裁服务 |

---

## 六、与现有模块的关系

```
┌─────────────────────────────────────────────────────────────┐
│                    GeniusClaw OS                            │
├─────────────────────────────────────────────────────────────┤
│  M2 P2P 网络 ───────────────────────────────────────────►   │
│  ├── 远程维护（用户授权）                                    │
│  └── Agent 市场 ◄── 核心目标                                 │
│       ├── 发现彼此                                           │
│       ├── 能力发布                                           │
│       ├── HTTP 402 交易                                      │
│       └── 数字货币支付（可选）                                │
├─────────────────────────────────────────────────────────────┤
│  M6 路由出口 ── WireGuard (VPN)                             │
│  M9 Web3 ────── 区块链对接                                   │
└─────────────────────────────────────────────────────────────┘
```

---

*文档版本: v1.0*
*最后更新: 2026-03-19*