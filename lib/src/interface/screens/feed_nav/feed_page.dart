import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Network Image as the background
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://via.placeholder.com/400', // Replace with actual image URL
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Pop-up Content
                    Text(
                      'Get access to our unlimited resources',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur     adipiscing elit.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54, // Light black color
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),

                    // Subscribe Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add your subscription logic here
                        },
                        child: Text('Subscribe now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF040F4F), // Button color
                          foregroundColor: Colors.white, // Text color
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Close Icon at the top right
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for the image
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey, // Gray rectangle placeholder
              child: Center(
                child: Text(
                  'Event Image Placeholder',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // News Category
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'FINANCE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  // News Title
                  Text(
                    'Tech Mahindra employees start hashtags on social media on Manish Vyas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Timestamp and Read Time
                  Row(
                    children: [
                      Text(
                        'Sep 07, 2021, 01:28 PM IST',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Spacer(),
                      Text(
                        '2 min read',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // News Description
                  Text(
                    'Tech Mahindra employees have sparked a wave of social media activity, '
                    'rallying behind the hashtag campaigns centered around Manish Vyas, '
                    'a key executive at the company. The hashtags, which have gained significant '
                    'traction, are aimed at expressing both support and concerns about leadership '
                    'decisions under his tenure...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Button to show pop-up
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Left Arrow Button
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFE2E8F0), // Arrow padding color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xFF004797), // Arrow color
                          ),
                        ),
                        SizedBox(width: 8), // Add spacing between elements

                        // "TAP TO READ" Text
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2), // Background color
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _showPopup(context); // Show the pop-up on press
                            },
                            child: Text(
                              'TAP TO READ',
                              style: TextStyle(
                                color: Color(0xFF828282), // Text color
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF2F2F2), // Button background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 32.0),
                            ),
                          ),
                        ),
                        SizedBox(width: 8), // Add spacing between elements

                        // Right Arrow Button
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFE2E8F0), // Arrow padding color
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Color(0xFF004797), // Arrow color
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
