import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/message.dart';
import '../services/openclaw_service.dart';

/// OpenClaw 服务提供者
final openClawServiceProvider = Provider((ref) => OpenClawService());

/// 聊天消息列表
final chatMessagesProvider = StateNotifierProvider<ChatMessagesNotifier, List<ChatMessage>>((ref) {
  return ChatMessagesNotifier(ref.read(openClawServiceProvider));
});

/// AI 对话状态
final aiStateProvider = StateProvider<AIState>((ref) => AIState.idle);

enum AIState {
  idle,
  thinking,
  speaking,
  error,
}

class ChatMessagesNotifier extends StateNotifier<List<ChatMessage>> {
  final OpenClawService _service;

  ChatMessagesNotifier(this._service) : super([]);

  /// 发送消息
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 添加用户消息
    final userMsg = ChatMessage.user(text);
    state = [...state, userMsg];

    // 设置为思考状态
    // ignore: unused_result
    // ignore: invalid_use_of_visible_for_testing_member
    state = state; // 触发刷新

    try {
      // 获取 AI 回复
      final reply = await _service.sendMessage(text);
      
      // 添加 AI 回复
      final aiMsg = ChatMessage.ai(reply);
      state = [...state, aiMsg];
    } catch (e) {
      // 添加错误消息
      final errorMsg = ChatMessage.ai('❌ $e');
      state = [...state, errorMsg];
    }
  }

  /// 清空对话
  void clear() {
    state = [];
  }
}