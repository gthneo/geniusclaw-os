#!/bin/bash
# =====================================
# GeniusClaw OS - Ubuntu 系统裁剪脚本
# 用于制作精简的居家养老版系统
# =====================================

set -e

# ===== 配置 =====
TARGET_DIR="/opt/geniusclaw"
VERSION="1.0.0"
ARCH="arm64"  # 或 amd64

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_step() { echo -e "${BLUE}[STEP]${NC} $1"; }

# ===== 步骤 1: 基础清理 =====
cleanup_base() {
    log_step "1/6: 基础系统清理..."
    
    # 清理 apt 缓存
    apt clean
    rm -rf /var/lib/apt/lists/*
    
    # 清理日志
    rm -rf /var/log/*.log
    rm -rf /var/log/apt/*
    
    # 清理临时文件
    rm -rf /tmp/*
    rm -rf /var/tmp/*
    
    # 清理旧内核（保留当前）
    dpkg -l 'linux-*' 2>/dev/null | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | head -n -1 | xargs apt -y purge 2>/dev/null || true
    
    log_info "基础清理完成"
}

# ===== 步骤 2: 移除不需要的软件 =====
remove_unnecessary() {
    log_step "2/6: 移除不需要的软件..."
    
    # 桌面环境（如果存在）
    apt remove -y --purge \
        gnome* \
        kde* \
        xfce* \
        lxde* \
        mate* \
        cinnamon* \
        unity* \
        2>/dev/null || true
    
    # 办公软件
    apt remove -y --purge \
        libreoffice* \
        abiword* \
        gnumeric* \
        2>/dev/null || true
    
    # 多媒体
    apt remove -y --purge \
        rhythmbox* \
        totem* \
        brasero* \
        2>/dev/null || true
    
    # 游戏
    apt remove -y --purge \
        gnome-games* \
        aisleriot* \
        2>/dev/null || true
    
    # 其他不需要的
    apt remove -y --purge \
        thunderbird* \
        firefox* \
        transmission* \
        2>/dev/null || true
    
    apt autoremove -y
    log_info "不需要的软件已移除"
}

# ===== 步骤 3: 安装核心组件 =====
install_core() {
    log_step "3/6: 安装核心组件..."
    
    # 更新源
    apt update
    
    # 基础工具
    apt install -y \
        curl \
        wget \
        git \
        nginx \
        python3 \
        python3-pip \
        vim \
        htop \
        net-tools \
        iputils-ping \
        openssh-server \
        systemd-sysv
    
    # Node.js
    if ! command -v node &> /dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
        apt install -y nodejs
    fi
    
    log_info "核心组件安装完成"
}

# ===== 步骤 4: 配置系统 =====
configure_system() {
    log_step "4/6: 配置系统..."
    
    # 创建目标目录
    mkdir -p $TARGET_DIR
    
    # 复制 OpenClaw
    if command -v openclaw &> /dev/null; then
        log_info "OpenClaw 已安装"
    else
        npm install -g openclaw
    fi
    
    # 复制 Web UI
    mkdir -p $TARGET_DIR/web-ui
    
    # 配置防火墙
    ufw allow 3000/tcp  # Web UI
    ufw allow 8080/tcp  # OpenClaw
    ufw allow 22/tcp    # SSH
    
    log_info "系统配置完成"
}

# ===== 步骤 5: 优化服务 =====
optimize_services() {
    log_step "5/6: 优化服务..."
    
    # 禁用不需要的服务
    systemctl mask \
        snapd.seeded.service \
        2>/dev/null || true
    
    # 启用需要的服务
    systemctl enable ssh
    systemctl enable nginx
    
    # 减少日志大小
    sed -i 's/#SystemMaxUse=/SystemMaxUse=50M/' /etc/systemd/journald.conf
    sed -i 's/#RuntimeMaxUse=/RuntimeMaxUse=30M/' /etc/systemd/journald.conf
    
    log_info "服务优化完成"
}

# ===== 步骤 6: 最终清理 =====
final_cleanup() {
    log_step "6/6: 最终清理..."
    
    # 清理 apt
    apt clean
    apt autoremove -y
    
    # 清理文档
    rm -rf /usr/share/doc/*
    rm -rf /usr/share/man/*
    
    # 清理 localization
    localedeleteLocale && dpkg-reconfigure -f noninteractive locales || true
    rm -rf /usr/share/locale/*
    
    # 清理 bash history
    history -c
    
    # 清理 shell history
    rm -f ~/.bash_history
    
    log_info "最终清理完成"
}

# ===== 显示系统信息 =====
show_info() {
    echo ""
    echo "=========================================="
    echo -e "${GREEN}✅ Ubuntu 裁剪完成！${NC}"
    echo "=========================================="
    echo ""
    echo "版本: $VERSION"
    echo "架构: $ARCH"
    echo "目标目录: $TARGET_DIR"
    echo ""
    
    # 磁盘使用
    df -h / | tail -1
    echo ""
    
    echo "内存使用:"
    free -h
    echo ""
}

# ===== 主流程 =====
main() {
    echo "=========================================="
    echo "  🦞 GeniusClaw OS - Ubuntu 裁剪工具"
    echo "  版本: $VERSION"
    echo "=========================================="
    echo ""
    
    if [ "$EUID" -ne 0 ]; then
        log_error "请使用 root 权限运行: sudo $0"
        exit 1
    fi
    
    cleanup_base
    remove_unnecessary
    install_core
    configure_system
    optimize_services
    final_cleanup
    show_info
}

main "$@"