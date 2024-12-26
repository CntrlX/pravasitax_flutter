import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pravasitax_flutter/src/data/models/forum_model.dart';
import 'package:pravasitax_flutter/src/data/providers/forum_provider.dart';
import 'package:pravasitax_flutter/src/interface/screens/forum_nav/forum_user/forum_page.dart';
import 'package:pravasitax_flutter/src/interface/widgets/loading_indicator.dart';

class ForumList extends ConsumerWidget {
  final String userToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzE5MDk5NTAsImV4cCI6MTc2MzAxMzk1MCwiaWQiOiI2NmZlYTZlNTM1ZDQxZTQxY2E3MjVmMzIiLCJuYW1lIjoiU2Fpam8gR2VvcmdlIiwiZW1haWwiOiJzYWlqb0BjYXBpdGFpcmUuY29tIn0.gI-7QRIjGJBVdOTTdy88__Hlutvb5X55YmL66i_cFEw';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(forumCategoriesProvider(userToken));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 1,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: categoriesAsync.when(
            loading: () => LoadingIndicator(),
            error: (error, stack) => Center(child: Text('Error: $error')),
            data: (categories) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    height: .4,
                    color: Colors.grey[300],
                  ),
                  itemBuilder: (context, index) {
                    return _buildForums(context, categories[index]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForums(BuildContext context, ForumCategory category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForumPage(
                category: category,
                userToken: userToken,
              ),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 20,
                  child: category.icon != null
                      ? Image.network(category.icon!)
                      : Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10),
                Text(
                  category.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            if (category.threadCount > 0)
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  category.threadCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
