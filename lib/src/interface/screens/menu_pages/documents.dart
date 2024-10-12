// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// class DocumentsPage extends StatefulWidget {
//   @override
//   _DocumentsPageState createState() => _DocumentsPageState();
// }

// class _DocumentsPageState extends State<DocumentsPage> {
//   List<String> _uploadedDocuments = [];

//   Future<void> _pickDocument() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();

//     if (result != null) {
//       setState(() {
//         _uploadedDocuments.add(result.files.single.name);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Documents'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _pickDocument,
//             child: Text('Upload Document'),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _uploadedDocuments.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_uploadedDocuments[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }