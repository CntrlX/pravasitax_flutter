import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/chat_api.dart';
import '../models/chat_model.dart';

final conversationsProvider =
    FutureProvider.family<List<Conversation>, String>((ref, userToken) async {
  final chatAPI = ref.watch(chatAPIProvider);
  final conversations = await chatAPI.getConversations(userToken);
  return conversations.map((json) => Conversation.fromJson(json)).toList();
});

final conversationMessagesProvider = FutureProvider.family<List<Message>,
    ({String userToken, String conversationId})>((ref, params) async {
  final chatAPI = ref.watch(chatAPIProvider);
  final messages =
      await chatAPI.getMessages(params.userToken, params.conversationId);
  return messages.map((json) => Message.fromJson(json)).toList();
});

final createConversationProvider = FutureProvider.family<Conversation,
    ({String userToken, String title, String type})>((ref, params) async {
  final api = ref.watch(chatAPIProvider);
  final conversation =
      await api.createConversation(params.userToken, params.title, params.type);
  return Conversation.fromJson(conversation);
});

final sendMessageProvider = FutureProvider.family<
    void,
    ({
      String userToken,
      String conversationId,
      String message
    })>((ref, params) async {
  final chatAPI = ref.watch(chatAPIProvider);
  await chatAPI.sendMessage(
      params.userToken, params.conversationId, params.message);
});

final markMessageAsDeliveredProvider =
    FutureProvider.family<void, ({String userToken, String messageId})>(
        (ref, params) async {
  final api = ref.watch(chatAPIProvider);
  await api.markMessageAsDelivered(params.userToken, params.messageId);
});

final markMessageAsReadProvider =
    FutureProvider.family<void, ({String userToken, String messageId})>(
        (ref, params) async {
  final api = ref.watch(chatAPIProvider);
  await api.markMessageAsRead(params.userToken, params.messageId);
});

final assignStaffToConversationProvider = FutureProvider.family<
    void,
    ({
      String userToken,
      String conversationId,
      String staffId
    })>((ref, params) async {
  final api = ref.watch(chatAPIProvider);
  await api.assignStaffToConversation(
      params.userToken, params.conversationId, params.staffId);
});

final markConversationAsCompletedProvider =
    FutureProvider.family<void, ({String userToken, String conversationId})>(
        (ref, params) async {
  final api = ref.watch(chatAPIProvider);
  await api.markConversationAsCompleted(
      params.userToken, params.conversationId);
});
