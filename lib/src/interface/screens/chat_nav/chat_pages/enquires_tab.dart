import 'package:flutter/material.dart';
import 'package:pravasitax_flutter/src/interface/screens/chat_nav/chat_pages/chat_screen.dart';
class EnquiriesTab extends StatelessWidget {
  const EnquiriesTab({Key? key}) : super(key: key);

  final List<Map<String, String>> enquiries = const [
    {
      "name": "Suresh",
      "date": "23 Mar 2024, 03:46 PM",
      "imageUrl":
          "https://example.com/profile1.jpg",
    },
    {
      "name": "Ramesh",
      "date": "22 Mar 2024, 11:30 AM",
      "imageUrl":
          "https://example.com/profile2.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: enquiries.length,
      itemBuilder: (context, index) {
        final enquiry = enquiries[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserChatScreen(
                  title: enquiry["name"]!,
                  imageUrl: enquiry["imageUrl"]!,
                ),
              ),
            );
          },
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(enquiry["imageUrl"]!),
              ),
              title: Text(enquiry["name"]!),
              subtitle: Text(enquiry["date"]!),
            ),
          ),
        );
      },
    );
  }
}