# GeniusClaw OS - HomeAssistant 对接方案

## 📋 文档信息

| 项目 | 内容 |
|------|------|
| 项目名称 | GeniusClaw Operation System |
| 对接系统 | HomeAssistant |
| 版本 | v1.0 |
| 创建日期 | 2026-03-19 |

---

## 1. 对接目标

### 1.1 为什么对接 HomeAssistant？

| 优势 | 说明 |
|------|------|
| **生态丰富** | 支持 2000+ 智能设备，即插即用 |
| **零开发** | 无需自己写驱动，继承完整生态 |
| **自动化** | 强大的场景联动引擎 |
| **统一API** | 一个接口控制所有设备 |

### 1.2 对接架构

```
┌─────────────────────────────────────────────────────────┐
│                   GeniusClaw OS                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │  Skills Hub │  │  大模型管理  │  │  NAS存储    │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │           HomeAssistant 对接层 (HA Connector)    │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                   HomeAssistant                         │
│  ┌────────┐ ┌────────┐ ┌────────┐ ┌────────┐        │
│  │  灯光  │ │ 空调  │ │ 摄像头 │ │ 传感器 │  ...   │
│  └────────┘ └────────┘ └────────┘ └────────┘        │
└─────────────────────────────────────────────────────────┘
```

---

## 2. 对接方式

### 2.1 方案一：HA Add-on 模式（推荐）

**原理**：在 GC OS 中运行 HomeAssistant 作为 Add-on

```
GC OS (Ubuntu)
    │
    ├── Docker
    │       │
    │       ├── HomeAssistant (Add-on)
    │       │
    │       └── OpenClaw
    │
    └── 其他服务 (NAS, VPN, etc.)
```

**优点**：
- 一体化安装，开箱即用
-资源共享，统一管理
- 更新同步

**配置步骤**：

```bash
# 1. 安装 Docker
curl -fsSL get.docker.com | sh

# 2. 安装 HomeAssistant
docker run -d \
  --name homeassistant \
  --privileged \
  --network host \
  -v /home/data/homeassistant:/config \
  -v /run/dbus:/run/dbus:ro \
  homeassistant/home-assistant:stable

# 3. 访问 HA
# 浏览器打开 http://localhost:8123
```

---

### 2.2 方案二：独立 HA 部署

**原理**：HA 单独部署，通过网络对接

```
┌──────────────────┐         ┌──────────────────┐
│   GC OS          │  网络   │   HomeAssistant  │
│   (OpenClaw)     │◄───────►│   (独立主机)      │
└──────────────────┘         └──────────────────┘
```

**优点**：
- 独立更新，互不影响
- 资源隔离
- 灵活扩展

**配置步骤**：

```bash
# GC OS 端：安装 HA API 客户端
pip install homeassistant-api

# 配置连接
# 文件: /etc/geniusclaw/ha_config.yaml
ha:
  url: http://192.168.x.x:8123
  token: YOUR_LONG_LIVED_ACCESS_TOKEN
```

---

### 2.3 方案三：MQTT 桥接

**原理**：通过 MQTT 实现 GC OS 与 HA 通信

```
┌──────────────┐    MQTT    ┌──────────────┐
│  GC OS       │◄──────────►│ HomeAssistant│
│  (Publisher) │            │  (Subscriber)│
└──────────────┘            └──────────────┘
```

**适用场景**：
- 已有 HA 系统
- 需要本地化部署
- 低延迟要求

---

## 3. 功能映射

### 3.1 GC OS 功能 ↔ HA 设备

| GC OS 功能 | HA 设备类型 | 说明 |
|------------|-------------|------|
| **外设驱动** | light, switch, sensor | 灯光、开关、传感器 |
| **路由出口** | device_tracker | 设备追踪 |
| **NAS存储** | media_player | 影音播放 |
| **Skills** | automation, script | 自动化脚本 |

### 3.2 设备接入示例

```yaml
# configuration.yaml 示例
light:
  - platform: rest
    name: "办公室灯光"
    resource: http://localhost:8080/api/light

switch:
  - platform: mqtt
    name: "智能插座"
    command_topic: "home/switch/set"
    state_topic: "home/switch/state"

sensor:
  - platform: mqtt
    name: "温度传感器"
    state_topic: "home/sensor/temperature"
    unit_of_measurement: "°C"
```

---

## 4. 自然语言控制

### 4.1 语音指令示例

| 用户指令 | HA 操作 |
|----------|---------|
| "打开客厅灯" | `light.turn_on` |
| "关闭空调" | `climate.turn_off` |
| "播放音乐" | `media_player.play` |
| "设置温度25度" | `climate.set_temperature` |
| "打开大门" | `lock.unlock` |

### 4.2 OpenClaw Skill 开发

```python
# skills/ha_control/skill.py
import homeassistant_api as ha

class HAControlSkill:
    """HomeAssistant 控制技能"""
    
    def __init__(self):
        self.ha_url = "http://localhost:8123"
        self.token = os.getenv("HA_TOKEN")
        self.client = ha.Client(self.ha_url, self.token)
    
    def execute(self, command: str) -> dict:
        """执行 HA 命令"""
        
        # 灯光控制
        if "开灯" in command or "关灯" in command:
            entity_id = self._parse_entity(command, "light")
            state = "turn_on" if "开灯" in command else "turn_off"
            return self.client.call_service("light", state, entity_id)
        
        # 空调控制
        if "空调" in command:
            return self._control_climate(command)
        
        # 温度设置
        if "温度" in command:
            temp = self._parse_temperature(command)
            return self.client.call_service("climate", "set_temperature", 
                                           entity_id="climate.ac", 
                                           temperature=temp)
        
        return {"status": "unknown_command"}
    
    def get_states(self) -> list:
        """获取所有设备状态"""
        return self.client.get_states()
```

---

## 5. 场景联动

### 5.1 示例场景

| 场景 | 触发条件 | 执行动作 |
|------|----------|----------|
| **回家模式** | 地理围栏到家 | 开灯、开空调、播放音乐 |
| **离家模式** | 地理围栏离家 | 关灯、关空调、开启监控 |
| **睡眠模式** | 定时 23:00 | 灯光调暗、窗帘关闭 |
| **安防模式** | 门窗传感器触发 | 报警、推送通知、录制视频 |

### 5.2 配置示例

```yaml
# automation.yaml
- alias: "回家自动开灯"
  trigger:
    - platform: state
      entity_id: device_tracker.phone
      to: "home"
  condition:
    - condition: sun
      after: sunset
  action:
    - service: light.turn_on
      entity_id: light.living_room
    - service: climate.set_temperature
      entity_id: climate.ac
      data:
        temperature: 24
```

---

## 6. 设备列表（首批支持）

### 6.1 消费级设备

| 品类 | 品牌/协议 | 支持方式 |
|------|-----------|----------|
| 灯光 | Yeelight, Philips Hue | LAN API |
| 空调 | 美的、海尔、TCL | 红外/云云对接 |
| 插座 | TP-Link, 小米 | LAN API |
| 窗帘 | Aqara, 杜亚 | Zigbee |
| 门锁 | Aqara, 云丁 | Zigbee |
| 摄像头 | 海康、大华、ONVIF | RTSP |
| 扫地机 | 石头、科沃斯 | 云 API |

### 6.2 传感器

| 类型 | 协议 | 说明 |
|------|------|------|
| 温湿度 | Zigbee, BLE | AQara, 米家 |
| 人体感应 | Zigbee | 红外传感器 |
| 门窗状态 | Zigbee | 门磁 |
| 水浸 | Zigbee | 水浸传感器 |
| 烟雾 | Zigbee | 烟雾报警 |

### 6.3 工业/商用设备

| 类型 | 协议 | 说明 |
|------|------|------|
| PLC | Modbus TCP | 工业控制 |
| 摄像头 | ONVIF, RTSP | 安防监控 |
| 门禁 |韦根 | 门禁系统 |
| HVAC | BACnet | 中央空调 |

---

## 7. 性能指标

| 指标 | 要求 | 说明 |
|------|------|------|
| 设备发现 | < 30秒 | 自动发现 LAN 设备 |
| 命令响应 | < 500ms | 本地 LAN 控制 |
| 场景联动 | < 1秒 | 自动化触发 |
| 支持设备数 | 200+ | 单实例支持 |

---

## 8. 实施计划

### Phase 1: 基础对接（v1.0）
- [ ] Docker 环境搭建
- [ ] HA Add-on 安装
- [ ] 基础设备控制（灯光、插座）
- [ ] 自然语言指令解析

### Phase 2: 生态扩展（v1.1）
- [ ] 传感器接入
- [ ] 场景联动
- [ ] 语音控制
- [ ] 移动端配套

### Phase 3: 行业深化（v2.0）
- [ ] 工业协议支持
- [ ] 视频监控集成
- [ ] 能源管理
- [ ] SaaS 平台

---

## 9. 商业价值

### 9.1 收入模型

| 模式 | 说明 |
|------|------|
| **设备分成** | 与硬件厂商分成销售利润 |
| **订阅服务** | 云端存储、远程访问高级功能 |
| **安装服务** | 上门安装、调试收费 |
| **培训服务** | 场景配置培训 |

### 9.2 市场定位

- 🏠 **家庭用户**：智能家居入门
- 🏢 **中小企业**：办公自动化
- 🏭 **工业用户**：工厂智造

---

*文档版本: v1.0*
*最后更新: 2026-03-19*