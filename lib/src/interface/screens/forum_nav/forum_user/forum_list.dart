import 'package:flutter/material.dart';
import 'package:pravasitax_flutter/src/data/models/forum_model.dart';
import 'package:flutter/material.dart';
import 'package:pravasitax_flutter/src/interface/screens/forum_nav/forum_user/forum_page.dart';

class ForumList extends StatefulWidget {
  @override
  _ForumListState createState() => _ForumListState();
}

List<ForumCategory> groups = [
  ForumCategory(
      id: '1245124arvara', title: 'Group 1', createdAt: DateTime.now()),
  ForumCategory(
      id: '1245124arvara', title: 'Group 2', createdAt: DateTime.now()),
  ForumCategory(
      id: '1245124arvara', title: 'Group 3', createdAt: DateTime.now())
];

class _ForumListState extends State<ForumList> {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wraps the content height
            children: [
              ListView.separated(
                shrinkWrap:
                    true, // Ensures the ListView doesn't take extra height
                physics:
                    NeverScrollableScrollPhysics(), // Prevents internal scrolling
                itemCount: groups.length,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  height: .4,
                  color: Colors.grey[300],
                ),
                itemBuilder: (context, index) {
                  return _buildForums(groups[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForums(ForumCategory group) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ForumPage(),
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
                  child: Icon(Icons.person,
                      color: Colors.white), // Placeholder for avatar
                ),
                SizedBox(width: 10),
                Text(
                  group.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '2',
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
