class Conversation {
  final String id;
  final String title;
  final String type;
  final String status;
  final String? assignedStaffId;
  final DateTime createdAt;
  final List<Message> messages;

  Conversation({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    this.assignedStaffId,
    required this.createdAt,
    this.messages = const [],
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? json['conversation_title'] ?? '',
      type: json['type'] ?? json['conversation_type'] ?? '',
      status: json['status'] ?? 'ACTIVE',
      assignedStaffId: json['assigned_staff_id'],
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      messages: (json['messages'] as List?)
              ?.map((message) => Message.fromJson(message))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'status': status,
      'assigned_staff_id': assignedStaffId,
      'created_at': createdAt.toIso8601String(),
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}

class Message {
  final String id;
  final String conversationId;
  final String content;
  final String senderId;
  final String senderType; // 'USER' or 'STAFF'
  final bool isDelivered;
  final bool isRead;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.content,
    required this.senderId,
    required this.senderType,
    this.isDelivered = false,
    this.isRead = false,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'] ?? json['id'] ?? '',
      conversationId: json['conversation_id'] ?? '',
      content: json['content'] ?? json['message'] ?? '',
      senderId: json['sender_id'] ?? '',
      senderType: json['sender_type'] ?? 'USER',
      isDelivered: json['is_delivered'] ?? false,
      isRead: json['is_read'] ?? false,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'content': content,
      'sender_id': senderId,
      'sender_type': senderType,
      'is_delivered': isDelivered,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
