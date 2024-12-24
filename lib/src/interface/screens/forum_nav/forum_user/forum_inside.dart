import 'package:flutter/material.dart';
import 'package:pravasitax_flutter/src/data/models/forum_model.dart';

class ForumInside extends StatefulWidget {
  @override
  _ForumInsideState createState() => _ForumInsideState();
}

class _ForumInsideState extends State<ForumInside> {
  ForumPost post = ForumPost(
    id: '1',
    threadId: 'thread1',
    content:
        'Lorem ipsum dolor sit amet consectetur. Est scelerisque nunc mauris libero. Sit risus non quam posuere nulla. Tellus nulla nunc lorem consequat dictumst feugiat viverra. Vulputate morbi faucibus dictumst sit.',
    userId: 'John Cena',
    createdAt: DateTime.now().subtract(Duration(hours: 3)),
    replies: [
      ForumPost(
        id: '2',
        threadId: 'thread1',
        content:
            'Lorem ipsum dolor sit amet consectetur. Est scelerisque nunc mauris libero.',
        userId: 'Client 1',
        parentPostId: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
      ForumPost(
        id: '3',
        threadId: 'thread1',
        content:
            'Lorem ipsum dolor sit amet consectetur. Est scelerisque nunc mauris libero.',
        userId: 'Client 2',
        parentPostId: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      ForumPost(
        id: '4',
        threadId: 'thread1',
        content:
            'Lorem ipsum dolor sit amet consectetur. Est scelerisque nunc mauris libero.',
        userId: 'Client 3',
        parentPostId: '1',
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
    ],
  );

  TextEditingController _commentController = TextEditingController();
  String? replyingTo;

  bool isLiked = false;
  int likeCount = 25;

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        likeCount--;
      } else {
        likeCount++;
      }
      isLiked = !isLiked;
    });
  }

  void _addReply(String content, {String? parentPostId}) {
    setState(() {
      final newReply = ForumPost(
        id: DateTime.now().toString(),
        threadId: post.threadId,
        content: content,
        userId: 'You',
        parentPostId: parentPostId ?? post.id,
        createdAt: DateTime.now(),
      );

      if (parentPostId == null) {
        post = post.copyWith(replies: List.from(post.replies)..add(newReply));
      } else {
        ForumPost? parent = _findPostById(post, parentPostId);
        if (parent != null) {
          final List<ForumPost> updatedReplies = List.from(parent.replies)
            ..add(newReply);
          post = _updateReplies(post, parentPostId, updatedReplies);
        }
      }
    });

    replyingTo = null;
    _commentController.clear();
  }

  ForumPost _updateReplies(
      ForumPost currentPost, String targetId, List<ForumPost> updatedReplies) {
    if (currentPost.id == targetId) {
      return currentPost.copyWith(replies: updatedReplies);
    }

    return currentPost.copyWith(
      replies: currentPost.replies
          .map((reply) => _updateReplies(reply, targetId, updatedReplies))
          .toList(),
    );
  }

  ForumPost? _findPostById(ForumPost parent, String id) {
    if (parent.id == id) return parent;
    for (var reply in parent.replies) {
      final found = _findPostById(reply, id);
      if (found != null) return found;
    }
    return null;
  }

  void _showReplyModal(BuildContext context, String? parentPostId) {
    _commentController.clear();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: parentPostId == null
                      ? 'Add a comment...'
                      : 'Replying to ${parentPostId == post.id ? 'main post' : 'a reply'}...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    _addReply(_commentController.text,
                        parentPostId: parentPostId);
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReplies(List<ForumPost> replies, int depth) {
    // Define a maximum nesting depth
    const int maxDepth = 3;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: replies.length,
      itemBuilder: (context, index) {
        final reply = replies[index];

        if (depth >= maxDepth) {
          // Show a "View more replies" button at the max depth
          return TextButton(
            onPressed: () {
              // Handle expanding to show more replies
              _showNestedReplies(reply);
            },
            child: Text("View more replies"),
          );
        }

        return Padding(
          padding: EdgeInsets.only(left: depth * 16.0, top: 8.0, bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Text(reply.userId[0]),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${reply.userId} • ${_formatTime(reply.createdAt)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(reply.content),
                    TextButton(
                      onPressed: () {
                        _showReplyModal(context, reply.id);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.reply, size: 16),
                          SizedBox(width: 4),
                          Text('Reply'),
                        ],
                      ),
                    ),
                    if (reply.replies.isNotEmpty)
                      _buildReplies(reply.replies, depth + 1),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNestedReplies(ForumPost reply) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Replies'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildReplies(reply.replies, 0), // Reset depth for modal
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group 1'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Main Post
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        post.userId,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        '${_formatTime(post.createdAt)}',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    post.content,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xFFF9B406).withOpacity(.19)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: InkWell(
                            onTap: _toggleLike,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$likeCount'),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isLiked ? Colors.red : Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xFFF9B406).withOpacity(.19)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('7'),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.switch_access_shortcut_outlined,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          _showReplyModal(context, post.id);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.reply, size: 16),
                            SizedBox(width: 4),
                            Text('Reply'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Comments Section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildReplies(post.replies, 0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inMinutes < 60) {
      return '${duration.inMinutes}m ago';
    } else if (duration.inHours < 24) {
      return '${duration.inHours}h ago';
    } else {
      return '${duration.inDays}d ago';
    }
  }
}
