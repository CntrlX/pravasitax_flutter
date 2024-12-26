import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pravasitax_flutter/src/data/models/forum_model.dart';
import 'package:pravasitax_flutter/src/data/providers/forum_provider.dart';
import 'package:pravasitax_flutter/src/interface/widgets/loading_indicator.dart';

class ForumInside extends ConsumerStatefulWidget {
  final ForumThread thread;
  final String userToken;

  ForumInside({required this.thread, required this.userToken});

  @override
  _ForumInsideState createState() => _ForumInsideState();
}

class _ForumInsideState extends ConsumerState<ForumInside> {
  final TextEditingController _commentController = TextEditingController();
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

  void _addReply(String content, {String? parentPostId}) async {
    try {
      await ref.read(createPostProvider((
        userToken: widget.userToken,
        threadId: widget.thread.id,
        content: content,
        parentPostId: parentPostId,
      )).future);

      // Refresh posts
      ref.refresh(forumPostsProvider((
        userToken: widget.userToken,
        threadId: widget.thread.id,
      )));

      if (parentPostId != null) {
        // Refresh replies if it's a reply to a post
        ref.refresh(postRepliesProvider((
          userToken: widget.userToken,
          threadId: widget.thread.id,
          parentPostId: parentPostId,
        )));
      }

      _commentController.clear();
      replyingTo = null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add reply: $e')),
      );
    }
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
          padding: EdgeInsets.fromLTRB(
              16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: parentPostId == null
                      ? 'Add a comment...'
                      : 'Replying to a post...',
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
    const int maxDepth = 3;

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: replies.length,
      itemBuilder: (context, index) {
        final reply = replies[index];

        if (depth >= maxDepth) {
          return TextButton(
            onPressed: () {
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
                    if (reply.replyCount > 0)
                      Consumer(
                        builder: (context, ref, child) {
                          final repliesAsync = ref.watch(postRepliesProvider((
                            userToken: widget.userToken,
                            threadId: widget.thread.id,
                            parentPostId: reply.id,
                          )));

                          return repliesAsync.when(
                            loading: () => LoadingIndicator(),
                            error: (error, stack) => Text('Error: $error'),
                            data: (replies) =>
                                _buildReplies(replies, depth + 1),
                          );
                        },
                      ),
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
              child: Consumer(
                builder: (context, ref, child) {
                  final repliesAsync = ref.watch(postRepliesProvider((
                    userToken: widget.userToken,
                    threadId: widget.thread.id,
                    parentPostId: reply.id,
                  )));

                  return repliesAsync.when(
                    loading: () => LoadingIndicator(),
                    error: (error, stack) => Text('Error: $error'),
                    data: (replies) => _buildReplies(replies, 0),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final postsAsync = ref.watch(forumPostsProvider((
      userToken: widget.userToken,
      threadId: widget.thread.id,
    )));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.thread.title),
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
                        widget.thread.userId,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _formatTime(widget.thread.createdAt),
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.thread.description,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFFF9B406).withOpacity(.19),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          child: InkWell(
                            onTap: _toggleLike,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$likeCount'),
                                SizedBox(width: 8),
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
                      SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xFFF9B406).withOpacity(.19),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${widget.thread.postCount}'),
                                SizedBox(width: 8),
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
                          _showReplyModal(context, null);
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
                child: postsAsync.when(
                  loading: () => LoadingIndicator(),
                  error: (error, stack) => Text('Error: $error'),
                  data: (posts) => _buildReplies(posts, 0),
                ),
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
