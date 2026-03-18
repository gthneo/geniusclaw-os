#!/bin/bash
# =====================================
# GeniusClaw OS - 居家养老版安装脚本
# 适用于树莓派 5 (ARM64)
# =====================================

set -e

# ===== 配置 =====
VERSION="1.0.0"
INSTALL_DIR="/opt/geniusclaw"
OPENCLAW_DIR="$INSTALL_DIR/openclaw"
WEB_UI_DIR="$INSTALL_DIR/web-ui"

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# ===== 日志 =====
log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ===== 检查 root =====
if [ "$EUID" -ne 0 ]; then
    log_error "请使用 root 权限运行: sudo $0"
    exit 1
fi

# ===== 欢迎 =====
echo "======================================"
echo "  🦞 GeniusClaw OS - 居家养老版"
echo "  版本: $VERSION"
echo "======================================"
echo ""

# ===== 步骤 1: 更新系统 =====
log_info "步骤 1/6: 更新系统..."
apt update && apt upgrade -y

# ===== 步骤 2: 安装依赖 =====
log_info "步骤 2/6: 安装依赖..."
apt install -y curl wget git nginx python3 python3-pip

# ===== 步骤 3: 安装 Node.js =====
log_info "步骤 3/6: 安装 Node.js 20.x..."
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt install -y nodejs
fi

node_version=$(node -v)
log_info "Node.js 版本: $node_version"

# ===== 步骤 4: 安装 OpenClaw =====
log_info "步骤 4/6: 安装 OpenClaw..."
if ! command -v openclaw &> /dev/null; then
    npm install -g openclaw
fi

# ===== 步骤 5: 配置 OpenClaw =====
log_info "步骤 5/6: 配置 OpenClaw..."

# 创建配置目录
mkdir -p $OPENCLAW_DIR
cd $OPENCLAW_DIR

# 初始化配置
if [ ! -f "config.yaml" ]; then
    cat > config.yaml << EOF
# OpenClaw 配置 - 居家养老版
model: bailian/MiniMax-M2.5
thinking: false

channels:
  - type: http
    enabled: true
    port: 8080

skills:
  - name: companion-care
    enabled: true
    path: $INSTALL_DIR/skills/companion-care.js
EOF
    log_info "配置文件已创建"
fi

# ===== 步骤 6: 部署 Web UI =====
log_info "步骤 6/6: 部署 Web UI..."

# 复制 Web UI
mkdir -p $WEB_UI_DIR
cp -r $INSTALL_DIR/../web-ui/* $WEB_UI_DIR/

# 配置 Nginx
cat > /etc/nginx/sites-available/geniusclaw << EOF
server {
    listen 3000;
    server_name _;

    root $WEB_UI_DIR;
    index index.html;

    location / {
        try_files \$uri \$uri/ /index.html;
    }

    location /api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

ln -sf /etc/nginx/sites-available/geniusclaw /etc/nginx/sites-enabled/
nginx -t && systemctl reload nginx

# ===== 启动服务 =====
log_info "启动服务..."

# 启动 OpenClaw
cd $OPENCLAW_DIR
nohup openclaw start > /var/log/openclaw.log 2>&1 &
sleep 3

# ===== 完成 =====
echo ""
echo "======================================"
echo -e "${GREEN}✅ 安装完成！${NC}"
echo "======================================"
echo ""
echo "访问地址: http://<您的IP地址>:3000"
echo ""
echo "管理命令:"
echo "  查看日志: tail -f /var/log/openclaw.log"
echo "  重启服务: systemctl restart nginx"
echo "  停止服务: pkill -f openclaw"
echo ""
echo "下一步:"
echo "  1. 打开手机浏览器访问上面的地址"
echo "  2. 开始与正龙虾对话~"
echo ""