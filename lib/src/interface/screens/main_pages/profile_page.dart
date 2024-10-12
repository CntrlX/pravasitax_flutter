import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/documents.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/help_center.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/my_filings.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/about.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/my_posts.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/privacy_policy.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/saved_news.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/subscriptions.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/termsandconditions.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/notification_setting.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      'https://invalid-url.com', // Invalid URL for testing
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey,
                          child: const Icon(Icons.person, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Ramakrishna Panikar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '984575223',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // Display the modal bottom sheet directly on 'Edit' button press
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 16,
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                           child: Wrap(
  children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Close Icon at the top-right corner
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop(); // Close the bottom sheet
              },
            ),
          ],
        ),
        Center(
          child: CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(
              'https://example.com/profile_picture.jpg',
            ),
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            labelText: "Name",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            labelText: "Phone Number",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            labelText: "Email ID",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            labelText: "DOB",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Proceed",
              style: TextStyle(color: Colors.black),
            ),
            
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF9B406),
              padding: const EdgeInsets.symmetric(horizontal: 185, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    ),
  ],
),

                          );
                        },
                      );
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            _buildSectionHeader('ACCOUNT'),

            _buildListTile(context, Icons.help_outline, 'Help Center',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpCenterPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(
              context,
              Icons.rule,
              'My Filings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyFilingsPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(
              context,
              Icons.rule,
              'About Us',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(context, Icons.file_present_outlined, 'Documents',
               onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DocumentsPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(context, Icons.subscriptions_outlined, 'Subscriptions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubscriptionsPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(context, Icons.post_add_outlined, 'My Posts',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPostsPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(
              context,
              Icons.rule,
              'Privacy Policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(context, Icons.save_alt_outlined, 'Saved News',
             onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SavedNewsPage()),
                ),
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(
              context,
              Icons.rule,
              'Terms and Conditions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TermsAndConditionsPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(
              context,
              Icons.rule_outlined,
              'Notification Settings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationSettingsPage()),
                );
              },
            ),
            Container(color: Color(0xFFF2F2F2), height: 15),
            _buildListTile(context, Icons.logout, 'Logout', onTap: () {
              _showLogoutDialog(context);
            }),
            Container(color: Color(0xFFF2F2F2), height: 15),
            _buildListTile(context, Icons.delete_forever, 'Delete Account', onTap: () {
              _showDeleteAccountDialog(context);
            }),
            Container(color: Color(0xFFF2F2F2), height: 100),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF2F2F2),
      padding: const EdgeInsets.only(left: 16.0, top: 10, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title,
      {Function()? onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(icon, color: const Color(0xFF797474)),
      ),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      trailing: SvgPicture.asset(
        'assets/icons/polygon.svg',
        height: 16,
        width: 16,
        color: const Color(0xFFC4C4C4),
      ),
      onTap: onTap ?? () {},
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text("Are you sure you want to delete your account? This action is irreversible."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
