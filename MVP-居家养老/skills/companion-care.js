/**
 * 居家养老陪伴聊天 Skill
 * 提供情感陪伴、日常对话、健康提醒等功能
 */

const SKILL_NAME = 'companion-care';
const SKILL_VERSION = '1.0.0';

// ===== 记忆系统 =====
let userMemories = {
    name: '',
    family: [],
    preferences: {},
    history: []
};

// ===== 对话模板 =====
const GREETING_MORNING = [
    "早上好！今天的天气很不错，记得喝杯温水对身体好哦~",
    "早安！您昨晚睡得好吗？",
    "早上好呀！新的一天开始了，有什么想聊的吗？"
];

const GREETING_AFTERNOON = [
    "下午好！您午休了吗？",
    "您好！下午精神怎么样？",
    "下午好！来喝杯茶休息一下吧~"
];

const GREETING_EVENING = [
    "晚上好！您吃了吗？",
    "您好！晚上记得早点休息对身体好。",
    "晚上好！今天过得怎么样？"
];

const CARE_RESPONSES = [
    "您要注意身体啊！年纪大了要好好照顾自己。",
    "记得按时吃饭，按时睡觉，身体是革命的本钱。",
    "您辛苦了！要学会给自己放放假~",
    "有什么不舒服的一定要告诉家人，别撑着。"
];

const ENCOURAGEMENT = [
    "您真棒！",
    "没问题，您一定能行！",
    "别着急，慢慢来~",
    "您做得很好！"
];

// ===== 意图识别 =====
function classifyIntent(text) {
    const lowerText = text.toLowerCase();
    
    // 问候
    if (/早上好|早安|早啊|早晨/.test(text)) return 'greeting_morning';
    if (/下午好|午安/.test(text)) return 'greeting_afternoon';
    if (/晚上好|晚安|睡觉/.test(text)) return 'greeting_evening';
    if (/你好|您好|嗨|在吗/.test(text)) return 'greeting';
    
    // 关心
    if (/吃了吗|吃饭了吗|饿|饱/.test(text)) return 'meal';
    if (/睡|困|累|休息/.test(text)) return 'rest';
    if (/身体|健康|不舒服|难受|疼/.test(text)) return 'health';
    
    // 陪伴
    if (/无聊|闷|寂寞|陪|聊/.test(text)) return 'company';
    if (/回忆|以前|过去|记得|当年/.test(text)) return 'memory';
    
    // 信息查询
    if (/天气|温度|下雨/.test(text)) return 'weather';
    if (/新闻|发生|事情/.test(text)) return 'news';
    
    // 紧急
    if (/救命|危险|紧急|帮忙/.test(text)) return 'emergency';
    
    // 感谢
    if (/谢谢|感谢|好样|棒/.test(text)) return 'thanks';
    
    // 再见
    if (/再见|拜拜|走了|休息|睡/.test(text)) return 'farewell';
    
    return 'chat';
}

// ===== 获取当前时段问候 =====
function getGreeting() {
    const hour = new Date().getHours();
    if (hour >= 5 && hour < 12) {
        return GREETING_MORNING[Math.floor(Math.random() * GREETING_MORNING.length)];
    } else if (hour >= 12 && hour < 18) {
        return GREETING_AFTERNOON[Math.floor(Math.random() * GREETING_AFTERNOON.length)];
    } else {
        return GREETING_EVENING[Math.floor(Math.random() * GREETING_EVENING.length)];
    }
}

// ===== 主处理函数 =====
async function handleMessage(text, context = {}) {
    const intent = classifyIntent(text);
    let response = '';
    
    // 记录对话历史
    userMemories.history.push({
        user: text,
        intent,
        timestamp: Date.now()
    });
    
    // 保持历史在50条以内
    if (userMemories.history.length > 50) {
        userMemories.history = userMemories.history.slice(-50);
    }
    
    switch (intent) {
        case 'greeting_morning':
        case 'greeting_afternoon':
        case 'greeting_evening':
            response = getGreeting();
            break;
            
        case 'greeting':
            const greetings = ["您好！我在呢~", "您好呀！随时陪您聊天~", "在的！您说"];
            response = greetings[Math.floor(Math.random() * greetings.length)];
            break;
            
        case 'meal':
            response = "民以食为天！您吃了吗？要注意营养均衡哦~";
            break;
            
        case 'rest':
            response = "累了就歇歇，身体最重要！您要注意休息呀~";
            break;
            
        case 'health':
            if (/头疼|头痛|头晕|感冒|咳嗽/.test(text)) {
                response = "您要注意身体啊！严重的话要去看医生哦~";
            } else {
                response = CARE_RESPONSES[Math.floor(Math.random() * CARE_RESPONSES.length)];
            }
            break;
            
        case 'company':
            response = "我随时都在！想聊什么都可以~";
            break;
            
        case 'memory':
            response = "您一定有很多精彩的故事！给我讲讲以前的事吧~";
            break;
            
        case 'weather':
            // 这里会调用天气 Skill
            response = "我帮您查查天气？";
            break;
            
        case 'news':
            response = "我帮您看看今天的新闻？";
            break;
            
        case 'emergency':
            response = "您别急！我马上帮您联系家人！";
            break;
            
        case 'thanks':
            response = "不客气！能帮到您我也很开心~";
            break;
            
        case 'farewell':
            response = "晚安！有需要随时叫我~";
            break;
            
        case 'chat':
        default:
            response = await generateChatResponse(text);
            break;
    }
    
    return {
        success: true,
        message: response,
        skill: SKILL_NAME,
        intent
    };
}

// ===== 生成聊天回复 =====
async function generateChatResponse(text) {
    const responses = [
        "嗯，我听着呢~",
        "然后呢？",
        "您说得对！",
        "我明白您的意思~",
        "继续说，我听着呢~",
        CARE_RESPONSES[Math.floor(Math.random() * CARE_RESPONSES.length)],
        "您真是个有故事的人！",
        "听您这么说，我也替您高兴~"
    ];
    
    // 简单的随机回复
    return responses[Math.floor(Math.random() * responses.length)];
}

// ===== 导出模块 =====
module.exports = {
    name: SKILL_NAME,
    version: SKILL_VERSION,
    handleMessage,
    classifyIntent,
    // 元数据
    metadata: {
        description: "居家养老陪伴聊天Skill，提供情感陪伴和日常对话",
        author: "GeniusClaw Team",
        tags: ["养老", "陪伴", "聊天", "适老化"]
    }
};