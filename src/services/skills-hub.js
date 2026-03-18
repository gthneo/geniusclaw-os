/**
 * Skills Hub Service
 * AI技能市场服务
 */

class SkillsHubService {
  constructor(config = {}) {
    this.p2p = config.p2p;
    this.skills = new Map();
    this.installedSkills = new Map();
    
    // Initialize sample skills
    this.initializeSampleSkills();
  }

  initializeSampleSkills() {
    // Sample skills for demonstration
    const sampleSkills = [
      {
        id: 'smart-writer',
        name: '智能写作助手',
        description: '帮助撰写文章、报告、邮件等',
        category: '办公',
        version: '1.0.0',
        author: { id: 'system', name: 'System' },
        pricing: { type: 'free', price: 0 },
        stats: { downloads: 12345, rating: 4.8 }
      },
      {
        id: 'ai-image-generator',
        name: 'AI图像生成',
        description: '文字描述生成精美图片',
        category: '设计',
        version: '1.0.0',
        author: { id: 'system', name: 'System' },
        pricing: { type: 'paid', price: 29 },
        stats: { downloads: 8234, rating: 4.9 }
      },
      {
        id: 'financial-analyst',
        name: '金融数据分析',
        description: '股票、基金、理财分析',
        category: '金融',
        version: '1.0.0',
        author: { id: 'system', name: 'System' },
        pricing: { type: 'paid', price: 49 },
        stats: { downloads: 3456, rating: 4.7 }
      },
      {
        id: 'recipe-chef',
        name: '今日菜谱推荐',
        description: '根据现有食材推荐菜谱',
        category: '生活',
        version: '1.0.0',
        author: { id: 'system', name: 'System' },
        pricing: { type: 'free', price: 0 },
        stats: { downloads: 1234, rating: 4.5 }
      }
    ];

    sampleSkills.forEach(skill => {
      this.skills.set(skill.id, skill);
    });
  }

  /**
   * Get all skills with optional filter
   */
  async listSkills(filter = {}) {
    let skills = Array.from(this.skills.values());

    if (filter.category) {
      skills = skills.filter(s => s.category === filter.category);
    }

    if (filter.search) {
      const search = filter.search.toLowerCase();
      skills = skills.filter(s => 
        s.name.toLowerCase().includes(search) ||
        s.description.toLowerCase().includes(search)
      );
    }

    return skills;
  }

  /**
   * Get skill by ID
   */
  async getSkill(skillId) {
    return this.skills.get(skillId);
  }

  /**
   * Install skill
   */
  async installSkill(skillId, userId) {
    const skill = this.skills.get(skillId);
    if (!skill) {
      throw new Error(`Skill ${skillId} not found`);
    }

    const installKey = `${userId}:${skillId}`;
    this.installedSkills.set(installKey, {
      ...skill,
      installedAt: new Date(),
      status: 'active'
    });

    // Update download count
    skill.stats.downloads++;

    return { success: true, skill: skill };
  }

  /**
   * Get installed skills for user
   */
  async getInstalledSkills(userId) {
    const installed = [];
    
    for (const [key, skill] of this.installedSkills) {
      if (key.startsWith(`${userId}:`)) {
        installed.push(skill);
      }
    }

    return installed;
  }

  /**
   * Upload new skill
   */
  async uploadSkill(skillData, authorId) {
    const skill = {
      id: `skill-${Date.now()}`,
      ...skillData,
      author: { id: authorId, name: authorId },
      stats: { downloads: 0, rating: 0 },
      createdAt: new Date()
    };

    this.skills.set(skill.id, skill);
    return skill;
  }

  /**
   * Update skill rating
   */
  async rateSkill(skillId, rating, userId) {
    const skill = this.skills.get(skillId);
    if (!skill) {
      throw new Error(`Skill ${skillId} not found`);
    }

    // Simple rating update (in production, would track individual ratings)
    skill.stats.rating = (skill.stats.rating * skill.stats.reviews + rating) / (skill.stats.reviews + 1);
    skill.stats.reviews++;

    return skill;
  }

  /**
   * Get skill categories
   */
  async getCategories() {
    const categories = new Set();
    
    for (const skill of this.skills.values()) {
      categories.add(skill.category);
    }

    return Array.from(categories);
  }
}

export { SkillsHubService };