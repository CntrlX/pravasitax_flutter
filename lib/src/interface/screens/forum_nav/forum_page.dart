import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<String> feeds = []; // List to store the feeds

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: feeds.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(feeds[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Open a dialog to allow consultants to post feeds
                showDialog(
                  context: context,
                  builder: (context) {
                    String newFeed = ''; // Variable to store the new feed

                    return AlertDialog(
                      title: Text('Post a Feed'),
                      content: TextField(
                        onChanged: (value) {
                          newFeed = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your feed',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              feeds.add(newFeed); // Add the new feed to the list
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Post'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Post a Feed'),
            ),
          ),
        ],
      ),
    );
  }
}