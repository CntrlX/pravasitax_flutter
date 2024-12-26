import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pravasitax_flutter/src/data/models/forum_model.dart';
import 'package:pravasitax_flutter/src/data/providers/forum_provider.dart';
import 'package:pravasitax_flutter/src/interface/screens/forum_nav/forum_user/forum_inside.dart';
import 'package:pravasitax_flutter/src/interface/screens/main_pages/notification.dart';
import 'package:pravasitax_flutter/src/interface/screens/main_pages/profile_page.dart';
import 'package:pravasitax_flutter/src/interface/widgets/loading_indicator.dart';
import 'dart:developer' as developer;

class ForumPage extends ConsumerWidget {
  final ForumCategory category;
  final String userToken;

  ForumPage({required this.category, required this.userToken});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threadsAsync = ref.watch(forumThreadsProvider((
      userToken: userToken,
      categoryId: category.id,
    )));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/pravasi_logo.png',
              height: 40,
              width: 90,
            ),
            SizedBox(width: 8),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://example.com/profile_pic.png',
                ),
                radius: 20,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.blue,
                child: Text(
                  category.title[0],
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                category.title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          threadsAsync.when(
            loading: () => LoadingIndicator(),
            error: (error, stack) {
              developer.log('Error loading threads: $error\n$stack',
                  name: 'ForumPage');
              return Center(child: Text('Error: $error'));
            },
            data: (threads) {
              developer.log('Loaded ${threads.length} threads',
                  name: 'ForumPage');
              return ListView.builder(
                itemCount: threads.length,
                itemBuilder: (context, index) {
                  final thread = threads[index];
                  developer.log('Building thread: ${thread.title}',
                      name: 'ForumPage');
                  return _buildThreadCard(context, thread);
                },
              );
            },
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () => _showCreateThreadDialog(context, ref),
              label: Text('Add post', style: TextStyle(color: Colors.white)),
              icon: Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.blue[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThreadCard(BuildContext context, ForumThread thread) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForumInside(
                thread: thread,
                userToken: userToken,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 1,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 20,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          thread.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _formatTime(thread.createdAt),
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(thread.description),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.mode_comment_outlined, size: 18),
                      label: Text(
                        '${thread.postCount} Comments',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.share_outlined, size: 18),
                      label: Text('Share', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCreateThreadDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Create New Thread',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (titleController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty) {
                          try {
                            await ref.read(createThreadProvider((
                              userToken: userToken,
                              title: titleController.text,
                              description: descriptionController.text,
                              categoryId: category.id,
                              postImage: null,
                            )).future);

                            Navigator.pop(context);

                            // Refresh threads
                            ref.refresh(forumThreadsProvider((
                              userToken: userToken,
                              categoryId: category.id,
                            )));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Failed to create thread: $e')),
                            );
                          }
                        }
                      },
                      child: Text('Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
