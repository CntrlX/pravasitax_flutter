import 'package:flutter/material.dart';

class ForumList extends StatefulWidget {
  @override
  _ForumListState createState() => _ForumListState();
}

List<Community> communities = [
  Community(
      title: 'Communites by pravasi tax',
      groups: [GroupModel(title: 'Group 1', unreadMessages: 2)])
];

class _ForumListState extends State<ForumList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: communities.length,
                  itemBuilder: (context, index) {
                    return _buildFeedCard(communities[index]);
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () {},
              label: Text('Add post', style: TextStyle(color: Colors.white)),
              icon: Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.blue[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedCard(Community community) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
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
                    child: Icon(Icons.person,
                        color: Colors.white), // Placeholder for avatar
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        community.title ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Dynamically show all groups
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: community.groups?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 20,
                          child: Icon(Icons.person,
                              color: Colors.white), // Placeholder for avatar
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            community.groups?[index].title ?? '',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          '${community.groups?[index].unreadMessages ?? 0} unread',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Community {
  final String? title;
  final List<GroupModel>? groups;

  Community({this.title, this.groups});
}

class GroupModel {
  final String? title;
  final String? image;

  final int? unreadMessages;

  GroupModel({
    this.title,
    this.image,
    this.unreadMessages,
  });
}
