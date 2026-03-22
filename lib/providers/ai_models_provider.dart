/// AI 模型管理 Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ai_model.dart';

final aiModelsProvider = StateNotifierProvider<AiModelsNotifier, List<AIModel>>((ref) {
  return AiModelsNotifier();
});

class AiModelsNotifier extends StateNotifier<List<AIModel>> {
  AiModelsNotifier() : super([
    AIModel(
      id: 'qwen2.5',
      name: 'Qwen2.5',
      description: '阿里通义千问 - 支持中文的强大语言模型',
      size: 4500,
      isDownloaded: true,
      status: 'ready',
    ),
    AIModel(
      id: 'llama3',
      name: 'Llama 3',
      description: 'Meta 开源大模型 - 英文为主',
      size: 4200,
      isDownloaded: false,
      status: 'ready',
    ),
    AIModel(
      id: 'chatglm3',
      name: 'ChatGLM3',
      description: '清华智谱 AI - 中英文对话模型',
      size: 3800,
      isDownloaded: false,
      status: 'ready',
    ),
    AIModel(
      id: 'deepseek',
      name: 'DeepSeek',
      description: '深度求索 - 高性能开源模型',
      size: 4100,
      isDownloaded: false,
      status: 'ready',
    ),
  ]);

  void downloadModel(String modelId) {
    state = state.map((model) {
      if (model.id == modelId) {
        return model.copyWith(status: 'downloading', downloadProgress: 0.0);
      }
      return model;
    }).toList();

    _simulateDownload(modelId);
  }

  void _simulateDownload(String modelId) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      state = state.map((model) {
        if (model.id == modelId && model.downloadProgress < 1.0) {
          final newProgress = (model.downloadProgress + 0.1).clamp(0.0, 1.0);
          if (newProgress >= 1.0) {
            return model.copyWith(
              isDownloaded: true,
              downloadProgress: 1.0,
              status: 'ready',
            );
          }
          return model.copyWith(downloadProgress: newProgress);
        }
        return model;
      }).toList();

      if (state.any((m) => m.id == modelId && m.downloadProgress < 1.0)) {
        _simulateDownload(modelId);
      }
    });
  }

  void deleteModel(String modelId) {
    state = state.map((model) {
      if (model.id == modelId) {
        return model.copyWith(isDownloaded: false, downloadProgress: 0.0);
      }
      return model;
    }).toList();
  }
}

final selectedModelProvider = StateProvider<String?>((ref) => 'qwen2.5');
