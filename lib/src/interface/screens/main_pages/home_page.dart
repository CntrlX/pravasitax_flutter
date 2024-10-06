import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for any services',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 2x2 Grid Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildServiceCard(
                    title: 'Tax Filing and Advisory',
                    iconPath:
                        'C:/Code/AcuteAngle/Pravasitax_Flutter/pravasitax_flutter/assets/icons/home-hashtag.svg',
                    color: const Color(0xFFFFECEC),
                    textColor: const Color(0xFF561313),
                  ),
                  _buildServiceCard(
                    title: 'Wealth Planning',
                    iconPath:
                        'C:/Code/AcuteAngle/Pravasitax_Flutter/pravasitax_flutter/assets/icons/percentage-square.svg',
                    color: const Color(0xFFFFF2E3),
                    textColor: const Color(0xFF7D4502),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildServiceCard(
                    title: 'Property Related Services',
                    iconPath:
                        'C:/Code/AcuteAngle/Pravasitax_Flutter/pravasitax_flutter/assets/icons/airplane.svg',
                    color: const Color(0xFFE6FFE2),
                    textColor: const Color(0xFF114B08),
                  ),
                  _buildServiceCard(
                    title: 'PAN Related Services',
                    iconPath:
                        'C:/Code/AcuteAngle/Pravasitax_Flutter/pravasitax_flutter/assets/icons/receipt-2.svg',
                    color: const Color(0xFFE7EFFC),
                    textColor: const Color(0xFF0B1F39),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Banner with Gray Rectangular Card
              Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                color: Colors.grey.shade300, // Gray rectangular card
              ),
              const SizedBox(height: 24),

              // Text Content Section
              const Text(
                'Lorem ipsum dolor sit amet consectetur. Porttitor fames vehicula netus nunc. Augue sit pulvinar.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sep 02, 2021 01:28 PM IST    2m read',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // "Tap to Read" Button Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios, size: 16, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300,
                      ),
                      child: const Text(
                        'Tap to Read',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 24),

              // Tools Section (same as before)
              const Text(
                'Tools',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildToolCard(context, 'Tax Refund Calculator'),
                    _buildToolCard(context, 'Income Tax Calculator'),
                    _buildToolCard(context, 'NRI Status Calculator'),
                    _buildToolCard(context, 'Rent Receipt Generator'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widgets for Service Cards
  Widget _buildServiceCard({
    required String title,
    required String iconPath,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      width: 160,
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(iconPath, height: 50, width: 50),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Reusable Tool Card
  Widget _buildToolCard(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.blueGrey.shade100,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
