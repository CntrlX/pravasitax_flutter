import 'dart:developer' as developer;

class ForumCategory {
  final String id;
  final String title;
  final String? description;
  final String? icon;
  final int threadCount;
  final DateTime createdAt;

  ForumCategory({
    required this.id,
    required this.title,
    this.description,
    this.icon,
    this.threadCount = 0,
    required this.createdAt,
  });

  factory ForumCategory.fromJson(Map<String, dynamic> json) {
    return ForumCategory(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      icon: json['icon'],
      threadCount: json['thread_count'] ?? 0,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
      'thread_count': threadCount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ForumThread {
  final String id;
  final String title;
  final String description;
  final String categoryId;
  final String userId;
  final DateTime createdAt;
  final int status;
  final String statusText;
  final int postCount;

  ForumThread({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.userId,
    required this.createdAt,
    required this.status,
    required this.statusText,
    this.postCount = 0,
  });

  factory ForumThread.fromJson(Map<String, dynamic> json) {
    developer.log('Parsing thread: $json', name: 'ForumModel');
    try {
      return ForumThread(
        id: json['_id']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        categoryId: json['category_id']?.toString() ?? '',
        userId: json['author']?.toString() ?? '',
        createdAt: _parseDate(json['created_at']?.toString() ?? ''),
        status: json['status'] is int ? json['status'] : 0,
        statusText: json['status_text']?.toString() ?? '',
        postCount: json['post_count'] is int ? json['post_count'] : 0,
      );
    } catch (e, stack) {
      developer.log('Error parsing thread: $e\n$stack', name: 'ForumModel');
      rethrow;
    }
  }

  static DateTime _parseDate(String dateStr) {
    developer.log('Parsing date: $dateStr', name: 'ForumModel');
    try {
      // Parse date in format "17 Dec 24, 16:15"
      final parts = dateStr.split(', ');
      final dateParts = parts[0].split(' ');
      final timeParts = parts[1].split(':');

      final day = int.parse(dateParts[0]);
      final month = _getMonth(dateParts[1]);
      final year = 2000 + int.parse(dateParts[2]);
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      return DateTime(year, month, day, hour, minute);
    } catch (e, stack) {
      developer.log('Error parsing date: $e\n$stack', name: 'ForumModel');
      return DateTime.now();
    }
  }

  static int _getMonth(String month) {
    final months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12
    };
    return months[month] ?? 1;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category_id': categoryId,
      'author': userId,
      'created_at': createdAt.toIso8601String(),
      'status': status,
      'status_text': statusText,
      'post_count': postCount,
    };
  }
}

class ForumPost {
  final String id;
  final String threadId;
  final String content;
  final String userId;
  final String? parentPostId;
  final int replyCount;
  final DateTime createdAt;
  final List<ForumPost> replies;

  ForumPost({
    required this.id,
    required this.threadId,
    required this.content,
    required this.userId,
    this.parentPostId,
    this.replyCount = 0,
    required this.createdAt,
    this.replies = const [],
  });

  factory ForumPost.fromJson(Map<String, dynamic> json) {
    developer.log('Parsing post: $json', name: 'ForumModel');
    try {
      return ForumPost(
        id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
        threadId: json['thread_id']?.toString() ?? '',
        content: json['content']?.toString() ??
            json['post_content']?.toString() ??
            '',
        userId: json['user_id']?.toString() ?? json['author']?.toString() ?? '',
        parentPostId: json['parent_post_id']?.toString(),
        replyCount: json['reply_count'] is int ? json['reply_count'] : 0,
        createdAt: _parseDate(json['created_at']?.toString() ?? ''),
        replies: (json['replies'] as List?)
                ?.map((reply) => ForumPost.fromJson(reply))
                .toList() ??
            [],
      );
    } catch (e, stack) {
      developer.log('Error parsing post: $e\n$stack', name: 'ForumModel');
      rethrow;
    }
  }

  static DateTime _parseDate(String dateStr) {
    developer.log('Parsing date: $dateStr', name: 'ForumModel');
    try {
      // Parse date in format "17 Dec 24, 16:15"
      final parts = dateStr.split(', ');
      final dateParts = parts[0].split(' ');
      final timeParts = parts[1].split(':');

      final day = int.parse(dateParts[0]);
      final month = _getMonth(dateParts[1]);
      final year = 2000 + int.parse(dateParts[2]);
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      return DateTime(year, month, day, hour, minute);
    } catch (e, stack) {
      developer.log('Error parsing date: $e\n$stack', name: 'ForumModel');
      return DateTime.now();
    }
  }

  static int _getMonth(String month) {
    final months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12
    };
    return months[month] ?? 1;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thread_id': threadId,
      'content': content,
      'user_id': userId,
      'parent_post_id': parentPostId,
      'reply_count': replyCount,
      'created_at': createdAt.toIso8601String(),
      'replies': replies.map((reply) => reply.toJson()).toList(),
    };
  }

  ForumPost copyWith({
    String? id,
    String? threadId,
    String? content,
    String? userId,
    String? parentPostId,
    int? replyCount,
    DateTime? createdAt,
    List<ForumPost>? replies,
  }) {
    return ForumPost(
      id: id ?? this.id,
      threadId: threadId ?? this.threadId,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      parentPostId: parentPostId ?? this.parentPostId,
      replyCount: replyCount ?? this.replyCount,
      createdAt: createdAt ?? this.createdAt,
      replies: replies ?? this.replies,
    );
  }
}
