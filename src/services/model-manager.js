/**
 * Model Manager Service
 * 大模型供应链管理服务
 */

class ModelManagerService {
  constructor(config = {}) {
    this.config = config;
    this.models = new Map();
    this.currentModel = null;
    this.tokenUsage = new Map();
    
    // Initialize available models
    this.initializeModels();
  }

  initializeModels() {
    const models = [
      {
        id: 'claude-3-5-sonnet',
        name: 'Claude 3.5 Sonnet',
        provider: 'Anthropic',
        type: 'cloud',
        status: 'available',
        pricing: { input: 0.003, output: 0.015 },
        capabilities: ['chat', 'code', 'analysis']
      },
      {
        id: 'gpt-4o',
        name: 'GPT-4o',
        provider: 'OpenAI',
        type: 'cloud',
        status: 'available',
        pricing: { input: 0.005, output: 0.015 },
        capabilities: ['chat', 'code', 'vision']
      },
      {
        id: 'minimax',
        name: 'MiniMax',
        provider: 'MiniMax',
        type: 'cloud',
        status: 'available',
        pricing: { input: 0.001, output: 0.003 },
        capabilities: ['chat', 'code']
      },
      {
        id: 'ollama-llama2',
        name: 'Llama 2 (Local)',
        provider: 'Ollama',
        type: 'local',
        status: 'available',
        pricing: { input: 0, output: 0 },
        capabilities: ['chat', 'code'],
        requirements: { memory: '8GB' }
      },
      {
        id: 'ollama-mistral',
        name: 'Mistral (Local)',
        provider: 'Ollama',
        type: 'local',
        status: 'available',
        pricing: { input: 0, output: 0 },
        capabilities: ['chat'],
        requirements: { memory: '4GB' }
      }
    ];

    models.forEach(model => this.models.set(model.id, model));
  }

  /**
   * Get all available models
   */
  async listModels() {
    return Array.from(this.models.values());
  }

  /**
   * Get model by ID
   */
  async getModel(modelId) {
    return this.models.get(modelId);
  }

  /**
   * Switch to a different model
   */
  async switchModel(modelId) {
    const model = this.models.get(modelId);
    if (!model) {
      throw new Error(`Model ${modelId} not found`);
    }

    // Check if model is available
    if (model.status !== 'available') {
      throw new Error(`Model ${modelId} is not available`);
    }

    this.currentModel = model;
    console.log(`   ✅ Switched to model: ${model.name}`);
    
    return model;
  }

  /**
   * Get current model
   */
  getCurrentModel() {
    return this.currentModel;
  }

  /**
   * Track token usage
   */
  trackUsage(modelId, inputTokens, outputTokens) {
    const model = this.models.get(modelId);
    if (!model) return;

    const current = this.tokenUsage.get(modelId) || { input: 0, output: 0, cost: 0 };
    
    const inputCost = inputTokens * model.pricing.input;
    const outputCost = outputTokens * model.pricing.output;
    
    this.tokenUsage.set(modelId, {
      input: current.input + inputTokens,
      output: current.output + outputTokens,
      cost: current.cost + inputCost + outputCost
    });
  }

  /**
   * Get usage statistics
   */
  getUsageStats() {
    const stats = {};
    
    for (const [modelId, usage] of this.tokenUsage) {
      const model = this.models.get(modelId);
      stats[modelId] = {
        ...usage,
        modelName: model?.name
      };
    }

    return stats;
  }

  /**
   * Install local model (Ollama)
   */
  async installLocalModel(modelId) {
    // In production, this would call Ollama API to install model
    console.log(`   Installing local model: ${modelId}`);
    return { success: true, modelId };
  }

  /**
   * Get models by type
   */
  async getModelsByType(type) {
    return Array.from(this.models.values()).filter(m => m.type === type);
  }
}

export { ModelManagerService };