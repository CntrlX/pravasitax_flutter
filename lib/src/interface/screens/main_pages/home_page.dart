import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../home_cards.dart/tax_filing_adv.dart';


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
                  prefixIcon: const Icon(Icons.search),
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

              // 2x2 Grid Service Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildServiceCard(
                    title: 'Tax Filing and Advisory',
                    iconPath: 'assets/icons/tax_filing.svg',
                    color: const Color(0xFFFFECEC),
                    textColor: const Color(0xFF561313),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaxFilingAdvPage(),
                        ),
                      );
                    },
                  ),
                  _buildServiceCard(
                    title: 'Wealth Planning',
                    iconPath: 'assets/icons/wealth.svg',
                    color: const Color(0xFFFFF2E3),
                    textColor: const Color(0xFF7D4502),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildServiceCard(
                    title: 'Property Related Services',
                    iconPath: 'assets/icons/property.svg',
                    color: const Color(0xFFE6FFE2),
                    textColor: const Color(0xFF114B08),
                  ),
                  _buildServiceCard(
                    title: 'PAN Related Services',
                    iconPath: 'assets/icons/pan.svg',
                    color: const Color(0xFFE7EFFC),
                    textColor: const Color(0xFF0B1F39),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Property Related Services Section
              const Text(
                'Property Related Services',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildPropertyCard(context, 'Lower Deduction Certificate'),
                    _buildPropertyCard(
                        context, 'Assistance in \nProperty Purchase'),
                    _buildPropertyCard(
                        context, 'Trying to Buy or sell Land/Property?'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Empowering NRIs Banner Section
              _buildBannerSection(),
              const SizedBox(height: 24),

              // Tools Section
              const Text(
                'Tools',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
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
              const SizedBox(height: 24),

              // Common Difficulties Banner Section
              _buildCommonDifficultiesBanner(),
              const SizedBox(height: 24),

              // Help Section
              _buildHelpSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the chat screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        backgroundColor: const Color(0xFF040F4F),
        child: const Icon(Icons.chat, color: Color(0xFFF9B406)),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String iconPath,
    required Color color,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            SvgPicture.asset(iconPath, height: 50, width: 50, color: textColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, String title) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            color: Colors.grey.shade300, // Placeholder for image
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('View more', style: TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _buildBannerSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade200,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            color: Colors.grey.shade300, // Placeholder for image
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Empowering NRIs with Knowledge',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Lorem ipsum dolor sit amet consectetur.'),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: () {}, child: const Text('Join Now'))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, String title) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCommonDifficultiesBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: const Text(
          'Common Difficulties in filing taxes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildHelpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Difficulties in filing taxes?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Lorem ipsum dolor sit amet consectetur.'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xFFFDBA2F),
            side: const BorderSide(color: Color(0xFFFDBA2F)),
            shadowColor: Colors.transparent,
          ),
          child: const Text('Contact Us'),
        ),
      ],
    );
  }
}



class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: const Center(child: Text('Chat Content')),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: HomePage()));
}
