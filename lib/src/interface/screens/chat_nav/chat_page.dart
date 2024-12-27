// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../widgets/loading_indicator.dart';
// import '../../../data/providers/chat_provider.dart';
// import '../../../data/models/chat_model.dart';

// class ChatPage extends ConsumerWidget {
//   final String userToken =
//       'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3MzE5MDk5NTAsImV4cCI6MTc2MzAxMzk1MCwiaWQiOiI2NmZlYTZlNTM1ZDQxZTQxY2E3MjVmMzIiLCJuYW1lIjoiU2Fpam8gR2VvcmdlIiwiZW1haWwiOiJzYWlqb0BjYXBpdGFpcmUuY29tIn0.gI-7QRIjGJBVdOTTdy88__Hlutvb5X55YmL66i_cFEw';

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final conversationsAsync = ref.watch(conversationsProvider(userToken));

//     return Scaffold(
//       body: Column(
//         children: [
//           Divider(color: Color.fromARGB(255, 17, 16, 16), thickness: 0.2),
//           Expanded(
//             child: conversationsAsync.when(
//               loading: () => LoadingIndicator(),
//               error: (error, stack) => Center(child: Text('Error: $error')),
//               data: (conversations) => ListView.separated(
//                 separatorBuilder: (context, index) => Divider(
//                   color: Color.fromARGB(255, 17, 16, 16),
//                   thickness: 0.2,
//                 ),
//                 itemCount: conversations.length,
//                 itemBuilder: (context, index) {
//                   final conversation = conversations[index];
//                   return _buildConversationTile(context, conversation);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildConversationTile(
//       BuildContext context, Conversation conversation) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ChatScreen(
//               conversation: conversation,
//               userToken: userToken,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         color: Colors.white,
//         padding: EdgeInsets.all(16),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: AssetImage('assets/profile_picture.png'),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     conversation.title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     conversation.type,
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             if (conversation.status == 'ACTIVE')
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   shape: BoxShape.circle,
//                 ),
//                 padding: EdgeInsets.all(8),
//                 child: Text(
//                   '!',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChatScreen extends ConsumerStatefulWidget {
//   final Conversation conversation;
//   final String userToken;

//   ChatScreen({required this.conversation, required this.userToken});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends ConsumerState<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();

//   void _sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;

//     try {
//       await ref.read(sendMessageProvider((
//         userToken: widget.userToken,
//         conversationId: widget.conversation.id,
//         message: _messageController.text,
//       )).future);

//       _messageController.clear();
//       // Refresh messages
//       ref.refresh(conversationMessagesProvider((
//         userToken: widget.userToken,
//         conversationId: widget.conversation.id,
//       )));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to send message: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final messagesAsync = ref.watch(conversationMessagesProvider((
//       userToken: widget.userToken,
//       conversationId: widget.conversation.id,
//     )));

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFFFCD29),
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: AssetImage('assets/profile_picture.png'),
//               radius: 20,
//             ),
//             SizedBox(width: 10),
//             Text(
//               widget.conversation.title,
//               style: TextStyle(color: Colors.black),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.call, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: messagesAsync.when(
//               loading: () => LoadingIndicator(),
//               error: (error, stack) => Center(child: Text('Error: $error')),
//               data: (messages) => ListView.builder(
//                 controller: _scrollController,
//                 padding: EdgeInsets.all(16),
//                 itemCount: messages.length,
//                 itemBuilder: (context, index) {
//                   final message = messages[index];
//                   final bool isSender = message.senderType == 'USER';
//                   return _buildMessageBubble(message, isSender);
//                 },
//               ),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   offset: Offset(0, -2),
//                   blurRadius: 4,
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color(0xFFA9A9A9)),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 8.0),
//                             child: TextField(
//                               controller: _messageController,
//                               decoration: InputDecoration(
//                                 hintText: 'Type your message here',
//                                 border: InputBorder.none,
//                               ),
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           icon:
//                               Icon(Icons.attach_file, color: Color(0xFFB4B4B4)),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 5),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFFFDBA2F),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.send, color: Colors.white),
//                     onPressed: _sendMessage,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageBubble(Message message, bool isSender) {
//     return Align(
//       alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4),
//         decoration: BoxDecoration(
//           color: isSender ? Color(0xFFFDE79F) : Color(0xFFF6F6F6),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16),
//             topRight: Radius.circular(16),
//             bottomLeft: isSender ? Radius.circular(16) : Radius.zero,
//             bottomRight: isSender ? Radius.zero : Radius.circular(16),
//           ),
//         ),
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment:
//               isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//           children: [
//             Text(
//               message.content,
//               style: TextStyle(color: Colors.black),
//             ),
//             SizedBox(height: 4),
//             Text(
//               _formatTime(message.createdAt),
//               style: TextStyle(fontSize: 12, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatTime(DateTime dateTime) {
//     return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
//   }
// }
import 'package:flutter/material.dart';
import 'package:pravasitax_flutter/src/interface/screens/chat_nav/chat_pages/enquires_tab.dart';
import 'package:pravasitax_flutter/src/interface/screens/chat_nav/chat_pages/services_tab.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.amber, // Line under the selected tab
            indicatorWeight: 4, // Thickness of the indicator
            labelColor: Colors.amber, // Selected tab text color
            unselectedLabelColor: Colors.grey, // Unselected tab text color
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold, // Style for selected tab text
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal, // Style for unselected tab text
            ),
            tabs: [
              Tab(text: 'ENQUIRIES'),
              Tab(text: 'SERVICES'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EnquiriesTab(),
            ServicesTab(),
          ],
        ),
      ),
    );
  }
}
