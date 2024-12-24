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
  final String categoryId;
  final String title;
  final String description;
  final String userId;
  final String status; // 'ACTIVE', 'CLOSED', 'DELETED'
  final String? imageUrl;
  final int postCount;
  final DateTime createdAt;
  final List<ForumPost> posts;

  ForumThread({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.userId,
    required this.status,
    this.imageUrl,
    this.postCount = 0,
    required this.createdAt,
    this.posts = const [],
  });

  factory ForumThread.fromJson(Map<String, dynamic> json) {
    return ForumThread(
      id: json['_id'] ?? json['id'] ?? '',
      categoryId: json['category_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      userId: json['user_id'] ?? '',
      status: json['status'] ?? 'ACTIVE',
      imageUrl: json['image_url'] ?? json['post_image'],
      postCount: json['post_count'] ?? 0,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      posts: (json['posts'] as List?)
              ?.map((post) => ForumPost.fromJson(post))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'title': title,
      'description': description,
      'user_id': userId,
      'status': status,
      'image_url': imageUrl,
      'post_count': postCount,
      'created_at': createdAt.toIso8601String(),
      'posts': posts.map((post) => post.toJson()).toList(),
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
    return ForumPost(
      id: json['_id'] ?? json['id'] ?? '',
      threadId: json['thread_id'] ?? '',
      content: json['content'] ?? json['post_content'] ?? '',
      userId: json['user_id'] ?? '',
      parentPostId: json['parent_post_id'],
      replyCount: json['reply_count'] ?? 0,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      replies: (json['replies'] as List?)
              ?.map((reply) => ForumPost.fromJson(reply))
              .toList() ??
          [],
    );
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
}
