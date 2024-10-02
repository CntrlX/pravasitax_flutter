import 'package:flutter/material.dart';

class HubPage extends StatefulWidget {
  @override
  _HubPageState createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  bool _showBlogs = true;
  bool _showEvents = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hub Page'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showBlogs = true;
                    _showEvents = false;
                  });
                },
                child: Text('Blogs'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showBlogs = false;
                    _showEvents = true;
                  });
                },
                child: Text('Events'),
              ),
            ],
          ),
          SizedBox(height: 20),
          if (_showBlogs) ...[
            Text('Blogs Section'),
            // Add your blog posts and feeds widgets here
          ],
          if (_showEvents) ...[
            Text('Events Section'),
            // Add your events widgets here
          ],
        ],
      ),
    );
  }
}