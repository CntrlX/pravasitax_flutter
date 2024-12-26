import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pravasitax_flutter/mainpage.dart';
import 'package:pravasitax_flutter/src/interface/screens/chat_nav/chat_page.dart';
import 'package:pravasitax_flutter/src/interface/screens/feed_nav/feed_page.dart';
import 'package:pravasitax_flutter/src/interface/screens/forum_nav/forum_user/forum_list.dart';
import 'package:pravasitax_flutter/src/interface/screens/forum_nav/forum_user/forum_page.dart';
import 'package:pravasitax_flutter/src/interface/screens/i_hub_nav/hub_page.dart';
import 'package:pravasitax_flutter/src/interface/screens/main_pages/home_page.dart';
import 'package:pravasitax_flutter/src/interface/screens/main_pages/notification.dart';
import 'package:pravasitax_flutter/src/interface/screens/main_pages/profile_page.dart'; // Import ProfilePage

class MainPageConsultantPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // List of pages to display for each tab
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(), // Home Page
    FeedPage(), // Feed Page
    HubPage(), // I-Hub Page
    ForumList(), // Forum Page
    ChatPage(), // Chat Page
  ];

  // Method to update the selected index when an item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Helper method to dynamically build the navigation icons
  Widget _buildNavBarIcon(String activeIcon, String inactiveIcon, int index) {
    return SvgPicture.asset(
      _selectedIndex == index ? activeIcon : inactiveIcon,
      height: 24,
      width: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/pravasi_logo.png', // Pravasi Tax logo
              height: 40, // Adjusted size
              width: 90,
            ),
            SizedBox(width: 8),
          ],
        ),
        actions: [
          IconButton(
            icon:
                Icon(Icons.notifications_active_outlined), // Notification icon
            onPressed: () {
              // Navigate to NotificationPage when pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              // Navigate to ProfilePage when the profile image is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Add padding
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://example.com/profile_pic.png', // Replace with actual URL for profile image
                ),
                radius: 20,
              ),
            ),
          ),
        ],
      ),

      // The body will dynamically change based on the selected index
      body: _widgetOptions[_selectedIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: _buildNavBarIcon(
              'assets/icons/home_active.svg',
              'assets/icons/home_inactive.svg',
              0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildNavBarIcon(
              'assets/icons/feed_active.svg',
              'assets/icons/feed_inactive.svg',
              1,
            ),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: _buildNavBarIcon(
              'assets/icons/chklist_active.svg',
              'assets/icons/chklist_inactive.svg',
              2,
            ),
            label: 'I-Hub',
          ),
          BottomNavigationBarItem(
            icon: _buildNavBarIcon(
              'assets/icons/chat_active_consultant.svg',
              'assets/icons/chat_inactive_consultant.svg',
              3,
            ),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: _buildNavBarIcon(
              'assets/icons/people_active.svg',
              'assets/icons/people_inactive.svg',
              4,
            ),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
