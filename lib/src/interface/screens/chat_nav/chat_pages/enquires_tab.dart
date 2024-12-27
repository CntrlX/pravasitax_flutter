import 'package:flutter/material.dart';
import 'package:pravasitax_flutter/src/interface/screens/chat_nav/chat_pages/chat_screen.dart';

class EnquiriesTab extends StatelessWidget {
  const EnquiriesTab({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> enquiries = const [
    {
      "name": "Suresh",
      "date": "23 Mar 2024, 03:46 PM",
      "imageUrl": "https://example.com/profile1.jpg",
      "unreadCount": 5,
    },
    {
      "name": "Ramesh",
      "date": "22 Mar 2024, 11:30 AM",
      "imageUrl": "https://example.com/profile2.jpg",
      "unreadCount": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: enquiries.length,
      itemBuilder: (context, index) {
        final enquiry = enquiries[index];
        final int unreadCount = enquiry["unreadCount"] ?? 0;

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
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(
                    width: .7, color: const Color.fromARGB(255, 219, 213, 213)),
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(enquiry["imageUrl"]!),
                  radius: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        enquiry["name"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        enquiry["date"]!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
}
