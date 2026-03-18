#!/bin/bash
# =====================================
# GeniusClaw OS - 镜像打包工具
# 将系统打包为可安装的镜像
# =====================================

set -e

# ===== 配置 =====
VERSION="1.0.0"
OUTPUT_DIR="/home/gth/geniusclaw-image"
SOURCE_DIR="/opt/geniusclaw"
IMAGE_NAME="geniusclaw-os-v${VERSION}-居家养老"

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

# ===== 步骤 1: 准备环境 =====
prepare() {
    log_info "步骤 1/5: 准备环境..."
    
    # 创建输出目录
    mkdir -p $OUTPUT_DIR
    
    # 安装必要工具
    if ! command -v qemu-img &> /dev/null; then
        apt install -y qemu-utils
    fi
    
    log_info "环境准备完成"
}

# ===== 步骤 2: 创建基础镜像 =====
create_base_image() {
    log_info "步骤 2/5: 创建基础镜像..."
    
    # 使用 dd 创建空白镜像（精简模式）
    # 实际使用时，可以从现有系统制作
    local img_path="${OUTPUT_DIR}/${IMAGE_NAME}.img"
    
    log_info "镜像路径: $img_path"
    log_info "注意: 完整镜像需要从实际系统使用 dd 或 Clonezilla 制作"
    log_info "      此脚本仅作为打包流程模板"
    
    # 示例: 从设备创建镜像
    # dd if=/dev/mmcblk0 of=$img_path bs=4M status=progress
    
    # 示例: 从目录制作
    # tar -cvf ${IMAGE_NAME}.tar -C /opt geniusclaw
    
    # 记录打包信息
    cat > ${OUTPUT_DIR}/BUILD_INFO.txt << EOF
GeniusClaw OS 镜像信息
======================
版本: $VERSION
构建日期: $(date '+%Y-%m-%d %H:%M:%S')
架构: $(uname -m)

包含内容:
- OpenClaw Gateway
- 居家养老 Web UI
- Node.js 20.x
- Nginx

安装说明:
1. 将镜像写入 SD 卡或硬盘
2. 启动后运行首次配置脚本
3. 访问 http://IP:3000 开始使用

EOF
    
    log_info "基础镜像配置完成"
}

# ===== 步骤 3: 打包系统文件 =====
package_files() {
    log_info "步骤 3/5: 打包系统文件..."
    
    cd $OUTPUT_DIR
    
    # 打包配置文件
    if [ -d "$SOURCE_DIR" ]; then
        tar -cvf geniusclaw-config.tar -C /opt geniusclaw 2>/dev/null || true
        log_info "配置文件已打包"
    fi
    
    # 复制安装脚本
    if [ -f "/home/gth/.openclaw/workspace/brainware-geniusclaw/MVP-居家养老/scripts/install.sh" ]; then
        cp /home/gth/.openclaw/workspace/brainware-geniusclaw/MVP-居家养老/scripts/install.sh $OUTPUT_DIR/
        log_info "安装脚本已复制"
    fi
    
    # 复制 Web UI
    if [ -d "/home/gth/.openclaw/workspace/brainware-geniusclaw/MVP-居家养老/web-ui" ]; then
        tar -cvf web-ui.tar -C /home/gth/.openclaw/workspace/brainware-geniusclaw/MVP-居家养老 web-ui
        log_info "Web UI 已打包"
    fi
    
    log_info "系统文件打包完成"
}

# ===== 步骤 4: 创建安装脚本 =====
create_installer() {
    log_info "步骤 4/5: 创建安装脚本..."
    
    cat > ${OUTPUT_DIR}/install.sh << 'INSTALL_SCRIPT'
#!/bin/bash
# =====================================
# GeniusClaw OS - 一键安装脚本
# =====================================

set -e

VERSION="1.0.0"
INSTALL_DIR="/opt/geniusclaw"

echo "=========================================="
echo "  🦞 GeniusClaw OS - 居家养老版"
echo "  版本: $VERSION"
echo "=========================================="
echo ""

# 检查 root
if [ "$EUID" -ne 0 ]; then
    echo "请使用 root 权限运行: sudo $0"
    exit 1
fi

# 安装依赖
echo "[1/4] 安装依赖..."
apt update
apt install -y curl wget git nginx python3 python3-pip

# 安装 Node.js
echo "[2/4] 安装 Node.js..."
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt install -y nodejs
fi

# 安装 OpenClaw
echo "[3/4] 安装 OpenClaw..."
npm install -g openclaw

# 创建目录
mkdir -p $INSTALL_DIR/web-ui

# 复制文件
cp -r web-ui/* $INSTALL_DIR/web-ui/

# 配置 Nginx
cat > /etc/nginx/sites-available/geniusclaw << 'EOF'
server {
    listen 3000;
    server_name _;
    root /opt/geniusclaw/web-ui;
    index index.html;
    location / {
        try_files $uri $uri/ /index.html;
    }
}
EOF

ln -sf /etc/nginx/sites-available/geniusclaw /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx

# 启动服务
echo "[4/4] 启动服务..."
cd $INSTALL_DIR
nohup openclaw start > /var/log/openclaw.log 2>&1 &

echo ""
echo "=========================================="
echo "✅ 安装完成！"
echo "=========================================="
echo ""
echo "访问地址: http://<您的IP地址>:3000"
echo ""
INSTALL_SCRIPT

chmod +x ${OUTPUT_DIR}/install.sh
log_info "安装脚本已创建"
}

# ===== 步骤 5: 生成清单 =====
generate_manifest() {
    log_info "步骤 5/5: 生成清单..."
    
    cat > ${OUTPUT_DIR}/MANIFEST.md << EOF
# GeniusClaw OS - 居家养老版

## 版本信息

| 项目 | 内容 |
|------|------|
| 版本 | $VERSION |
| 构建日期 | $(date '+%Y-%m-%d %H:%M:%S') |
| 架构 | $(uname -m) |
| 内核 | $(uname -r) |

## 文件清单

| 文件 | 说明 |
|------|------|
| install.sh | 一键安装脚本 |
| geniusclaw-config.tar | 配置文件备份 |
| web-ui.tar | Web UI 界面 |
| BUILD_INFO.txt | 构建信息 |

## 安装说明

### 方式一: 一键安装（推荐）

```bash
# 1. 下载镜像包
tar -xvf geniusclaw-package.tar

# 2. 解压 Web UI
tar -xvf web-ui.tar -C /opt/geniusclaw/web-ui

# 3. 运行安装脚本
sudo ./install.sh
```

### 方式二: 完整镜像

```bash
# 将镜像写入 SD 卡
sudo dd if=geniusclaw-os-v1.0.0-居家养老.img of=/dev/mmcblk0 bs=4M status=progress
```

## 功能清单

- [x] AI 对话（OpenClaw）
- [x] 语音输入
- [x] 紧急呼叫
- [x] 提醒设置
- [x] 陪伴聊天

## 默认配置

| 项目 | 值 |
|------|-----|
| Web 端口 | 3000 |
| OpenClaw 端口 | 8080 |
| SSH 端口 | 22 |
| 默认用户 | root |

## 注意事项

1. 首次使用请修改默认密码
2. 建议配置静态 IP
3. 定期备份数据

---

*GeniusClaw OS - 居家养老版*
EOF

    log_info "清单已生成"
}

# ===== 显示结果 =====
show_result() {
    echo ""
    echo "=========================================="
    echo -e "${GREEN}✅ 打包完成！${NC}"
    echo "=========================================="
    echo ""
    echo "输出目录: $OUTPUT_DIR"
    echo ""
    
    ls -lh $OUTPUT_DIR/
    echo ""
    
    echo "下一步:"
    echo "  1. 复制所有文件到目标机器"
    echo "  2. 运行: sudo ./install.sh"
    echo "  3. 访问 http://IP:3000"
}

# ===== 主流程 =====
main() {
    echo "=========================================="
    echo "  🦞 GeniusClaw OS - 镜像打包工具"
    echo "  版本: $VERSION"
    echo "=========================================="
    echo ""
    
    prepare
    create_base_image
    package_files
    create_installer
    generate_manifest
    show_result
}

main "$@"