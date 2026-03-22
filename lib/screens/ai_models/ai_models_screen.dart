/// AI 模型管理页面
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/ai_model.dart';
import '../../providers/ai_models_provider.dart';

class AIModelsScreen extends ConsumerWidget {
  const AIModelsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final models = ref.watch(aiModelsProvider);
    final selectedModelId = ref.watch(selectedModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🤖 AI 模型管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: models.length,
        itemBuilder: (context, index) {
          final model = models[index];
          return _ModelCard(
            model: model,
            isSelected: model.id == selectedModelId,
            onSelect: () {
              if (model.isDownloaded) {
                ref.read(selectedModelProvider.notifier).state = model.id;
              }
            },
            onDownload: () => ref.read(aiModelsProvider.notifier).downloadModel(model.id),
            onDelete: () => ref.read(aiModelsProvider.notifier).deleteModel(model.id),
          );
        },
      ),
    );
  }
}

class _ModelCard extends StatelessWidget {
  final AIModel model;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onDownload;
  final VoidCallback onDelete;

  const _ModelCard({
    required this.model,
    required this.isSelected,
    required this.onSelect,
    required this.onDownload,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onSelect,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    model.isDownloaded ? Icons.check_circle : Icons.cloud_download,
                    color: model.isDownloaded ? Colors.green : Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${model.size} MB',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Chip(
                      label: Text('使用中'),
                      backgroundColor: Colors.green,
                      labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                model.description,
                style: TextStyle(color: Colors.grey[300]),
              ),
              if (model.status == 'downloading') ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(value: model.downloadProgress),
                const SizedBox(height: 4),
                Text(
                  '${(model.downloadProgress * 100).toInt()}%',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!model.isDownloaded && model.status != 'downloading')
                    TextButton.icon(
                      onPressed: onDownload,
                      icon: const Icon(Icons.download),
                      label: const Text('下载'),
                    ),
                  if (model.isDownloaded)
                    TextButton.icon(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      label: const Text('删除', style: TextStyle(color: Colors.red)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
