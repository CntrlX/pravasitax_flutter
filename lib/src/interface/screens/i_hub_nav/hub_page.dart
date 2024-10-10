import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HubPage extends StatefulWidget {
  @override
  _HubPageState createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: TabBar(
            controller: _tabController,
            isScrollable: false,
            indicatorColor: Color(0xFF004797), // Navy blue color
            indicatorWeight: 1.0,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontSize: 12, // Match font size from the image
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: "BLOGS"),
              Tab(text: "EVENTS"),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BlogsSection(),
          EventsSection(),
        ],
      ),
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
          color: isActive ? Color(0x66A9F3C7) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.grey,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Color(0xFF0F7036) : Colors.grey,
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
          color: Color(0x66A9F3C7),
          child: Text(
            'LAND TAX',
            style: TextStyle(
              fontSize: 10,
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
                Text('Jessica Felicio', style: TextStyle(color: Colors.black)),
                Text('11 Jan 2022 • 5 min video', style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF9B406),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () {},
          child: Text('Watch video', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}

// Events section

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
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFFD4D4D4), width: 0.5),
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 16),
          _buildEventCard(
            context,
            title: 'KICK OFF Event',
            date: '02 JAN 2023',
            time: '09:00 PM',
            tag: 'LIVE',
            isLive: true,
            description: 'The goal of the event is to raise awareness, streamline the filing process, and encourage timely and accurate tax submissions.',
          ),
          SizedBox(height: 16),
          _buildEventCard(
            context,
            title: 'Second Event',
            date: '02 JAN 2023',
            time: '09:00 PM',
            tag: 'UPCOMING',
            isLive: false,
            description: 'Join us for this upcoming event to gain insights into the latest trends and developments.',
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required String title,
    required String date,
    required String time,
    required String tag,
    required bool isLive,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              color: Colors.grey,
              alignment: Alignment.center,
              child: Icon(Icons.play_circle_outline, size: 50, color: Colors.white),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isLive ? Color(0xFF0F7036) : Color(0xFF1266B9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'TOPIC',
              style: TextStyle(color: Colors.grey, fontSize: 10),
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
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, size: 12, color: Color(0xFF700F0F)),
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
                      color: Color(0xFF1266B9),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          time,
                          style: TextStyle(
                            color: Colors.white,
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
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF9B406),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          onPressed: () {
            // Navigate to the EventDetailPage when "View more" is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventDetailPage(title: title)),
            );
          },
          child: Text('View more', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}

// New screen for EventDetailPage


class EventDetailPage extends StatelessWidget {
  final String title;

  EventDetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red), // Red back arrow
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event video and LIVE tag
            Stack(
              children: [
                Container(
                  height: 200,
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: Icon(Icons.play_circle_outline, size: 50, color: Colors.white),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Event title
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

            // Date and time with icons
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Nov 19 2023',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  '08:00 - 08:30',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16),

             Container(
              height: 1,
              color: Colors.grey[300],
            ),
             const SizedBox(height: 16),
            // Event description
            Text(
              'The goal of the event is to raise awareness, streamline the filing process, and encourage timely and accurate tax submissions.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            // Gray line
           

 const SizedBox(height: 16),
            // Speakers section
            Text(
              'Speakers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildSpeakerTile('Céline Wolf', 'Event Manager'),
            SizedBox(height: 8),
            _buildSpeakerTile('Céline Wolf', 'Event Manager'),
            SizedBox(height: 24),

            // Venue section
            Text(
              'Venue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              height: 150,
              color: Colors.grey[300], // Placeholder for map
              alignment: Alignment.center,
              child: Icon(Icons.map, size: 50, color: Colors.grey),
            ),
            SizedBox(height: 24),

            // Register button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF9B406),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text('REGISTER EVENT', style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create the speaker tile widget
  Widget _buildSpeakerTile(String name, String role) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[400], // Placeholder for speaker image
          child: Icon(Icons.person, color: Colors.white, size: 30),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              role,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          icon: Icon(FontAwesomeIcons.linkedin, color: Color(0xFF0A66C2), size: 30),
          onPressed: () {
            // Handle LinkedIn button press
          },
        ),
      ],
    );
  }
}

