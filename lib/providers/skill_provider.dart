import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/skill.dart';
import '../services/openclaw_service.dart';
import '../providers/ai_provider.dart';

/// 技能列表
final skillsProvider = FutureProvider<List<Skill>>((ref) async {
  final service = ref.read(openClawServiceProvider);
  final data = await service.getSkills();
  return data.map((e) => Skill.fromJson(e)).toList();
});

/// 已安装的技能
final installedSkillsProvider = Provider<List<Skill>>((ref) {
  final asyncSkills = ref.watch(skillsProvider);
  return asyncSkills.when(
    data: (skills) => skills.where((s) => s.isInstalled).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});

/// 技能分类筛选
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// 过滤后的技能列表
final filteredSkillsProvider = Provider<List<Skill>>((ref) {
  final asyncSkills = ref.watch(skillsProvider);
  final category = ref.watch(selectedCategoryProvider);
  
  return asyncSkills.when(
    data: (skills) {
      if (category == null) return skills;
      return skills.where((s) => s.category == category).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

/// 技能控制
class SkillController extends StateNotifier<AsyncValue<void>> {
  final OpenClawService _service;
  final Ref _ref;

  SkillController(this._service, this._ref) : super(const AsyncValue.data(null));

  /// 安装技能
  Future<void> install(String skillId) async {
    state = const AsyncValue.loading();
    try {
      await _service.installSkill(skillId);
      _ref.invalidate(skillsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 卸载技能
  Future<void> uninstall(String skillId) async {
    state = const AsyncValue.loading();
    try {
      await _service.uninstallSkill(skillId);
      _ref.invalidate(skillsProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final skillControllerProvider = StateNotifierProvider<SkillController, AsyncValue<void>>((ref) {
  return SkillController(ref.read(openClawServiceProvider), ref);
});