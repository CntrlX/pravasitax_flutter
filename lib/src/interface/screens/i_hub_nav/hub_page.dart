import 'package:flutter/material.dart';

class HubPage extends StatefulWidget {
  @override
  _HubPageState createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  bool _showBlogs = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _showBlogs = true;
                });
              },
              child: Column(
                children: [
                  Text(
                    'BLOGS',
                    style: TextStyle(
                      fontSize: 12, // Constant font size
                      color: _showBlogs ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (_showBlogs)
                    Container(
                      height: 2,
                      width: screenWidth / 2, // Bar goes to the middle
                      color: Colors.black,
                    ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showBlogs = false;
                });
              },
              child: Column(
                children: [
                  Text(
                    'EVENTS',
                    style: TextStyle(
                      fontSize: 12, // Constant font size
                      color: !_showBlogs ? Colors.black : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!_showBlogs)
                    Container(
                      height: 2,
                      width: screenWidth / 2, // Bar goes to the middle
                      color: Colors.black,
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _showBlogs ? BlogsSection() : EventsSection(),
    );
  }
}

class BlogsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTagButton('All', isActive: true),
                SizedBox(width: 8),
                _buildTagButton('Stock'),
                SizedBox(width: 8),
                _buildTagButton('Current trends'),
                SizedBox(width: 8),
                _buildTagButton('Land Tax'),
                SizedBox(width: 8),
                _buildTagButton('Economy'),
              ],
            ),
          ),
          SizedBox(height: 16),
          _buildBlogCard(),
          SizedBox(height: 16),
          _buildBlogCard(),
        ],
      ),
    );
  }

  Widget _buildTagButton(String text, {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        // Handle tag button click
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? Color(0x66A9F3C7) : Colors.transparent, // 40% opacity
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.grey,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Color(0xFF0F7036) : Colors.grey, // Adjusted color
          ),
        ),
      ),
    );
  }

  Widget _buildBlogCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Icon(Icons.play_circle_outline, size: 50, color: Colors.white),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Color(0x66A9F3C7), // 40% opacity for LAND TAX padding
            child: Text(
            'LAND TAX',
            style: TextStyle(
              fontSize: 10, // Decreased font size
              color: Color(0xFF0F7036),
              fontWeight: FontWeight.bold,
            ),
            ),
        ),
        SizedBox(height: 8),
        Text(
          'Essential Tips on Land Tax for NRIs',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Everything You Need to Know to Comply with Indian Land Tax Laws',
          style: TextStyle(color: Colors.grey[600]),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(backgroundColor: Colors.grey, radius: 15),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Jessica Felicio', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                Text('11 Jan 2022 • 5 min video', style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF9B406), // Yellow color change
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4), // More rectangular shape
            ),
          ),
          onPressed: () {},
          child: Text('Watch video', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}

class EventsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
            TextField(
            decoration: InputDecoration(
              hintText: 'Search Events',
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Reduced edges for search bar
              borderSide: BorderSide(color: Color.fromARGB(255, 223, 221, 221), width: 0.5), // Thin border
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              prefixIcon: Icon(Icons.search),
            ),
            ),
          SizedBox(height: 16),
          _buildEventCard(
            title: 'KICK OFF Event',
            date: '02 JAN 2023',
            time: '09:00 PM',
            tag: 'LIVE',
            isLive: true,
          ),
          SizedBox(height: 16),
          _buildEventCard(
            title: 'Second Event',
            date: '02 JAN 2023',
            time: '09:00 PM',
            tag: 'UPCOMING',
            isLive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required String time,
    required String tag,
    required bool isLive,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Icon(Icons.play_circle_outline, size: 50, color: Colors.white),
        ),
         Row(
          children: [
            Text(
              'TOPIC',
              style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
              children: [
                Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xFFF3F0A9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                  Icon(
                    Icons.calendar_today,
                    size: 12,
                    color: Color(0xFF700F0F),
                  ),
                  SizedBox(width: 4),
                  Text(
                    date,
                    style: TextStyle(
                    color: Color(0xFF700F0F),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  ],
                ),
                ),
                SizedBox(width: 4),
                Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Color(0xFFAED0E9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                  Icon(
                    Icons.access_time,
                    size: 12,
                    color: Color(0xFF0E1877),
                  ),
                  SizedBox(width: 4),
                  Text(
                    time,
                    style: TextStyle(
                    color: Color(0xFF0E1877),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
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
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: isLive
              ? Color(0x66A9F3C7) // 40% opacity for LIVE
              : Color(0x663497F9), // 40% opacity for UPCOMING
          child: Text(
            tag,
            style: TextStyle(
              color: isLive ? Color(0xFF0F7036) : Color(0xFF1266B9),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'The goal of the event is to raise awareness, streamline the filing process, and encourage timely and accurate tax submissions.',
          style: TextStyle(color: Colors.grey[600]),
        ),
        SizedBox(height: 8),
       
        SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4), // Reduced edges for "View More"
            ),
            backgroundColor: Color(0xFFF9B406), // Changed padding color to FFF9B406
          ),
          onPressed: () {},
          child: Text('View more', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
