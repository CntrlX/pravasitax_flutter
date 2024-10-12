import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/my_filings.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/about.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/privacy_policy.dart';
import 'package:pravasitax_flutter/src/interface/screens/menu_pages/termsandconditions.dart';

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
                        // Placeholder in case of error (e.g. network failure)
                        return Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey, // Gray color placeholder
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
                      // Navigate to Edit Profile Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfilePage()),
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
            // Section Title
            _buildSectionHeader('ACCOUNT'),

            // Menu List Items
            _buildListTile(context, Icons.help_outline, 'Help Center'),
            Container(color: Color(0xFFD9D9D9), height: 1),
             _buildListTile(
              context,
              Icons.rule,
              'My Filings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyFilingsPage()),
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
                  MaterialPageRoute(
                      builder: (context) => AboutPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(context, Icons.file_present_outlined, 'Documents'),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(context, Icons.subscriptions_outlined, 'Subscriptions'),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(context, Icons.post_add_outlined, 'My Posts'),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(
              context,
              Icons.rule,
              'Privacy Policy',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrivacyPolicyPage()),
                );
              },
            ),

      
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(context, Icons.save_alt_outlined, 'Saved News'),
            Container(color: Color(0xFFD9D9D9), height: 1),
             _buildListTile(
              context,
              Icons.rule,
              'Terms and Conditions',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditionsPage()),
                );
              },
            ),
            Container(color: Color(0xFFD9D9D9), height: 1),
            _buildListTile(context, Icons.rule_outlined, 'Notification Settings'),
            Container(color: Color(0xFFF2F2F2), height: 15),
            _buildListTile(context, Icons.logout, 'Logout', onTap: () {
              // Handle Logout
              _showLogoutDialog(context);
            }),
            Container(color: Color(0xFFF2F2F2), height: 15),
            _buildListTile(context, Icons.delete_forever, 'Delete Account', onTap: () {
              // Handle Delete Account
              _showDeleteAccountDialog(context);
            }),
            Container(color: Color(0xFFF2F2F2), height: 100),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper Method to build section header
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

  // Helper Method to build each ListTile
  Widget _buildListTile(BuildContext context, IconData icon, String title,
      {Function()? onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(icon, color: const Color(0xFF797474)),
      ),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      trailing: SvgPicture.asset(
        'assets/icons/polygon.svg', // Add the correct path to your asset
        height: 16,
        width: 16,
        color: const Color(0xFFC4C4C4),
      ),
      onTap: onTap ?? () {},
    );
  }

  // Helper Method to show Logout Confirmation Dialog
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
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Handle actual logout logic
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  // Helper Method to show Delete Account Confirmation Dialog
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
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Handle account deletion logic
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

// Edit Profile Page


class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
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
                      Center(
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            'https://example.com/profile_picture.jpg', // Replace with the URL of the profile picture
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
                          onPressed: () {
                            // Handle save profile changes
                          },
                          child: const Text(
                            "Proceed",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF9B406),
                            padding: EdgeInsets.symmetric(horizontal: 120, vertical: 18),
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
      child: Text("Edit Profile"),
    );
  }
}
