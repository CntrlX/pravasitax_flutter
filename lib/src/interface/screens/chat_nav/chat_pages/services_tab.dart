import 'package:flutter/material.dart';

class ServicesTab extends StatelessWidget {
  const ServicesTab({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> services = const [
    {
      "title": "INCOME TAX FILING: 2023-2024",
      "serviceId": "BX2312323",
      "date": "23 Jan 2024, 03:46 PM",
      "status": "Ongoing",
      "statusColor": Colors.amber,
      "icon": Icons.receipt_long,
    },
    {
      "title": "INCOME TAX FILING: 2022-2023",
      "serviceId": "BX2312323",
      "date": "17 Dec 2022, 01:28 PM",
      "status": "Closed",
      "statusColor": Colors.red,
      "icon": Icons.receipt_long,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: .7,
                      color: const Color.fromARGB(255, 219, 213, 213)),
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(service['icon'], size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service['title'],
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Service ID: ${service['serviceId']}'),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(service['date']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: service['statusColor'].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      service['status'],
                      style: TextStyle(
                        color: service['statusColor'],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
