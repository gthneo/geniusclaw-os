/**
 * GeniusClaw OS - Web UI 交互逻辑
 * 版本: v1.1
 * 创建日期: 2026-03-19
 * 更新: 2026-03-19 - 添加网络设置和 PPPoE 配置
 */

// 等待 DOM 加载完成
document.addEventListener('DOMContentLoaded', function() {
    // 初始化应用
    initApp();
});

function initApp() {
    // 初始化导航
    initNavigation();
    
    // 初始化聊天功能
    initChat();
    
    // 初始化设备模拟数据
    loadDeviceData();
    
    // 初始化技能数据
    loadSkillsData();
    
    // 初始化设置菜单
    initSettingsMenu();
}

/**
 * 导航功能
 */
function initNavigation() {
    const navItems = document.querySelectorAll('.nav-item');
    const pages = document.querySelectorAll('.page');
    const pageTitle = document.getElementById('page-title');
    
    const pageTitles = {
        'dashboard': '仪表盘',
        'devices': '设备管理',
        'skills': '技能市场',
        'ai-chat': 'AI 对话',
        'files': '文件管理',
        'voice-memo': '语音备忘录',
        'family': '家庭协作',
        'settings': '系统设置'
    };
    
    navItems.forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            
            // 获取目标页面
            const targetPage = this.getAttribute('data-page');
            
            // 更新导航状态
            navItems.forEach(nav => nav.classList.remove('active'));
            this.classList.add('active');
            
            // 显示目标页面
            pages.forEach(page => page.classList.remove('active'));
            document.getElementById('page-' + targetPage).classList.add('active');
            
            // 更新页面标题
            pageTitle.textContent = pageTitles[targetPage] || 'GeniusClaw';
            
            // 页面切换动画
            const activePage = document.getElementById('page-' + targetPage);
            activePage.style.opacity = '0';
            activePage.style.transform = 'translateY(10px)';
            
            setTimeout(() => {
                activePage.style.transition = 'all 0.3s ease';
                activePage.style.opacity = '1';
                activePage.style.transform = 'translateY(0)';
            }, 10);
        });
    });
}

/**
 * 设置页面菜单切换
 */
function initSettingsMenu() {
    const menuItems = document.querySelectorAll('.settings-menu-item');
    
    menuItems.forEach(item => {
        item.addEventListener('click', function() {
            const target = this.getAttribute('data-target');
            
            // 更新菜单状态
            menuItems.forEach(menu => menu.classList.remove('active'));
            this.classList.add('active');
            
            // 显示目标内容
            const contents = document.querySelectorAll('.settings-content');
            contents.forEach(content => content.classList.remove('active'));
            document.getElementById('settings-' + target).classList.add('active');
        });
    });
}

/**
 * 网络连接类型切换
 */
function toggleConnectionType() {
    const connectionType = document.getElementById('connection-type').value;
    const pppoeConfig = document.getElementById('pppoe-config');
    const staticConfig = document.getElementById('static-config');
    
    // 隐藏所有配置
    pppoeConfig.style.display = 'none';
    staticConfig.style.display = 'none';
    
    // 显示对应配置
    if (connectionType === 'pppoe') {
        pppoeConfig.style.display = 'block';
    } else if (connectionType === 'static') {
        staticConfig.style.display = 'block';
    }
}

/**
 * PPPoE 连接
 */
function connectPPPoE() {
    const username = document.querySelector('#pppoe-config input[type="text"]').value;
    const password = document.querySelector('#pppoe-config input[type="password"]').value;
    
    if (!username || !password) {
        showNotification('请输入宽带账号和密码', 'warning');
        return;
    }
    
    // 模拟连接
    const statusElement = document.querySelector('.connection-status .status-value');
    statusElement.textContent = '连接中...';
    statusElement.className = 'status-value';
    
    showNotification('正在连接 PPPoE...', 'info');
    
    setTimeout(() => {
        statusElement.textContent = '已连接';
        statusElement.className = 'status-value connected';
        showNotification('PPPoE 连接成功！', 'success');
    }, 2000);
}

/**
 * PPPoE 断开
 */
function disconnectPPPoE() {
    const statusElement = document.querySelector('.connection-status .status-value');
    statusElement.textContent = '断开中...';
    
    setTimeout(() => {
        statusElement.textContent = '未连接';
        statusElement.className = 'status-value disconnected';
        showNotification('PPPoE 已断开', 'info');
    }, 1000);
}

/**
 * 保存 PPPoE 配置
 */
function savePPPoEConfig() {
    showNotification('PPPoE 配置已保存', 'success');
}

/**
 * AI 聊天功能
 */
function initChat() {
    const chatInput = document.getElementById('chat-input');
    const sendBtn = document.querySelector('.btn-send');
    const chatMessages = document.getElementById('chat-messages');
    
    // 发送消息函数
    function sendMessage() {
        const message = chatInput.value.trim();
        if (!message) return;
        
        // 添加用户消息
        addMessage(message, 'user');
        
        // 清空输入框
        chatInput.value = '';
        
        // 模拟 AI 响应
        setTimeout(() => {
            const responses = [
                '好的，我明白了。让我帮您处理这个问题。',
                '收到！我会根据您的需求进行调整。',
                '明白了，请问还需要我提供其他帮助吗？',
                '收到指令，正在执行中...',
                '好的，我已经记录下来。有什么其他需要？'
            ];
            const randomResponse = responses[Math.floor(Math.random() * responses.length)];
            addMessage(randomResponse, 'bot');
        }, 1000);
    }
    
    // 添加消息到聊天窗口
    function addMessage(content, sender) {
        const messageDiv = document.createElement('div');
        messageDiv.className = `message ${sender}`;
        
        const avatar = sender === 'bot' ? '🤖' : '👤';
        
        messageDiv.innerHTML = `
            <div class="message-avatar">${avatar}</div>
            <div class="message-content">
                <p>${content}</p>
            </div>
        `;
        
        chatMessages.appendChild(messageDiv);
        
        // 滚动到底部
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }
    
    // 绑定事件
    sendBtn.addEventListener('click', sendMessage);
    
    chatInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            sendMessage();
        }
    });
}

/**
 * 加载设备数据
 */
function loadDeviceData() {
    const devices = [
        { name: '客厅中控', icon: '🖥️', ip: '192.168.1.100', status: 'online' },
        { name: '手机助手', icon: '📱', ip: '192.168.1.101', status: 'online' },
        { name: '卧室音箱', icon: '🔊', ip: '192.168.1.102', status: 'offline' },
        { name: '厨房屏幕', icon: '📺', ip: '192.168.1.103', status: 'online' }
    ];
    
    const deviceGrid = document.querySelector('.device-grid');
    if (!deviceGrid) return;
    
    deviceGrid.innerHTML = devices.map(device => `
        <div class="device-card">
            <div class="device-status ${device.status}"></div>
            <div class="device-icon">${device.icon}</div>
            <div class="device-name">${device.name}</div>
            <div class="device-ip">${device.ip}</div>
            <div class="device-actions">
                <button class="btn-sm">管理</button>
            </div>
        </div>
    `).join('');
}

/**
 * 加载技能数据
 */
function loadSkillsData() {
    const skills = [
        { name: '居家养老', icon: '🏠', desc: '老人健康监测与提醒', installed: true },
        { name: '网约车司机', icon: '🚗', desc: '订单管理与行程规划', installed: true },
        { name: '企业管理', icon: '🏢', desc: '企业协同与流程管理', installed: false },
        { name: '智能家居', icon: '🏠', desc: '灯光、空调、窗帘控制', installed: true },
        { name: '健康监测', icon: '❤️', desc: '心率、血压、睡眠监测', installed: false },
        { name: '财税管理', icon: '💰', desc: '记账、报销、税务申报', installed: false }
    ];
    
    const skillsGrid = document.querySelector('.skills-grid');
    if (!skillsGrid) return;
    
    skillsGrid.innerHTML = skills.map(skill => `
        <div class="skill-card">
            <div class="skill-icon">${skill.icon}</div>
            <div class="skill-name">${skill.name}</div>
            <div class="skill-desc">${skill.desc}</div>
            <button class="btn-primary btn-sm">${skill.installed ? '已安装' : '安装'}</button>
        </div>
    `).join('');
}

/**
 * 语音备忘录功能
 */
function syncVoiceMemos() {
    const syncBtn = document.querySelector('#page-voice-memo .btn-primary');
    if (!syncBtn) return;
    
    syncBtn.addEventListener('click', function() {
        const originalText = this.innerHTML;
        this.innerHTML = '<span>↻</span> 同步中...';
        this.disabled = true;
        
        setTimeout(() => {
            this.innerHTML = originalText;
            this.disabled = false;
            showNotification('语音备忘录同步完成！', 'success');
        }, 2000);
    });
}

/**
 * 显示通知
 */
function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background-color: ${type === 'success' ? '#10B981' : type === 'warning' ? '#F59E0B' : '#4F46E5'};
        color: white;
        padding: 12px 24px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        z-index: 10000;
        animation: slideIn 0.3s ease;
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => {
            document.body.removeChild(notification);
        }, 300);
    }, 3000);
}

// 添加动画样式
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    @keyframes slideOut {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(100%); opacity: 0; }
    }
    .page { transition: all 0.3s ease; }
`;
document.head.appendChild(style);

// 导出函数供外部调用
window.GeniusClawApp = {
    showNotification,
    loadDeviceData,
    loadSkillsData,
    toggleConnectionType,
    connectPPPoE,
    disconnectPPPoE,
    savePPPoEConfig
};