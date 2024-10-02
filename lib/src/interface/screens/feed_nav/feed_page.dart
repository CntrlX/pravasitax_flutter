import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<String> newsList = [
    'News 1',
    'News 2',
    'News 3',
    'News 4',
    'News 5',
  ];
  int currentIndex = 0;

  void goToNextNews() {
    setState(() {
      currentIndex = (currentIndex + 1) % newsList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              newsList[currentIndex],
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: goToNextNews,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}