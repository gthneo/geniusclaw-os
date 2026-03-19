import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/theme.dart';
import '../../models/skill.dart';
import '../../providers/skill_provider.dart';

/// 技能市场页面
class SkillsScreen extends ConsumerWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skillsAsync = ref.watch(skillsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('📦 技能市场'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(skillsProvider),
          ),
        ],
      ),
      body: Column(
        children: [
          // 分类筛选
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                FilterChip(
                  label: const Text('全部'),
                  selected: selectedCategory == null,
                  onSelected: (_) => ref.read(selectedCategoryProvider.notifier).state = null,
                ),
                const SizedBox(width: 8),
                ...SkillCategory.all.map((category) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (_) => ref.read(selectedCategoryProvider.notifier).state = category,
                  ),
                )),
              ],
            ),
          ),
          const Divider(height: 1),
          // 技能列表
          Expanded(
            child: skillsAsync.when(
              data: (skills) {
                final filtered = selectedCategory == null
                    ? skills
                    : skills.where((s) => s.category == selectedCategory).toList();
                
                if (filtered.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('📦', style: TextStyle(fontSize: 64)),
                        SizedBox(height: 16),
                        Text('暂无技能'),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return _SkillCard(
                      skill: filtered[index],
                      onInstall: () => ref.read(skillControllerProvider.notifier).install(filtered[index].id),
                      onUninstall: () => ref.read(skillControllerProvider.notifier).uninstall(filtered[index].id),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('错误: $e')),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final Skill skill;
  final VoidCallback onInstall;
  final VoidCallback onUninstall;

  const _SkillCard({
    required this.skill,
    required this.onInstall,
    required this.onUninstall,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(skill.icon, style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        skill.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        skill.category,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildActionButton(),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              skill.description,
              style: TextStyle(color: Colors.grey[700]),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.star, size: 16, color: Colors.amber[600]),
                const SizedBox(width: 4),
                Text(
                  skill.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 16),
                Icon(Icons.download, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${skill.downloads}',
                  style: const TextStyle(fontSize: 12),
                ),
                const Spacer(),
                Text(
                  'v${skill.version}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    if (skill.isInstalled) {
      return OutlinedButton(
        onPressed: onUninstall,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
        ),
        child: const Text('卸载'),
      );
    }

    return ElevatedButton(
      onPressed: onInstall,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
      ),
      child: const Text('安装'),
    );
  }
}