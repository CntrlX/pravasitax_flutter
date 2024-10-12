import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pravasitax_flutter/src/interface/screens/chat_nav/chat_page.dart';
import 'package:pravasitax_flutter/src/interface/screens/home_cards.dart/tax_filing_adv.dart';

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
              // Logo and Profile Avatar
              
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for any services',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Service Cards (2x2 grid)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildServiceCard(
                    title: 'Tax Filing and Advisory',
                    iconPath: 'assets/icons/tax_filing.svg',
                    color: Color(0xFFDCDCDC),
                    textColor: const Color(0xFF003366),
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
                    color: const Color(0xFFDCDCDC),
                    textColor: const Color(0xFF003366),
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
                    color: const Color(0xFFDCDCDC),
                    textColor: const Color(0xFF003366),
                  ),
                  _buildServiceCard(
                    title: 'PAN Related Services',
                    iconPath: 'assets/icons/pan.svg',
                    color: const Color(0xFFDCDCDC),
                    textColor: const Color(0xFF003366),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Property Services Banner
              _buildBanner(
                title: 'Assistance in Filing Form 15CA/15CB',
                description: 'Annual Information Statement',
                bgColor: const Color(0xFFFFF9E6),
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
                    _buildPropertyCard(context, 'Assistance in Property Purchase'),
                    _buildPropertyCard(context, 'Trying to Buy or Sell Land/Property?'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tools Section
              const Text(
                'Tools',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Column(
                      children: [
                      _buildToolCard(
                        context: context,
                        icon: Icons.refresh,
                        title: '',
                        color: const Color(0xFFFFF3F3),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tax refund calculator',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.black87),
                      ),
                      ],
                    ),
                    Column(
                      children: [
                      _buildToolCard(
                        context: context,
                        icon: Icons.attach_money,
                        title: '',
                        color: const Color(0xFFFFF3E6),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Income Tax Calculator',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.black87),
                      ),
                      ],
                    ),
                    Column(
                      children: [
                      _buildToolCard(
                        context: context,
                        icon: Icons.person,
                        title: '',
                        color: const Color(0xFFF2FFEE),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'NRI Status Calculator',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.black87),
                      ),
                      ],
                    ),
                    Column(
                      children: [
                      _buildToolCard(
                        context: context,
                        icon: Icons.receipt,
                        title: '',
                        color: const Color(0xFFE6F3FF),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Rent Receipt Generator',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.black87),
                      ),
                      ],
                    ),
                    ],
                ),
              ),
              const SizedBox(height: 24),

              // Event Section
              _buildEventCard(
                context: context,
                isLive: false,
                tag: 'Recorded',
                date: '02 Jan 2023',
                time: '09:00 PM',
                title: 'Empowering NRIs with Knowledge',
                description:
                    'Lorem ipsum dolor sit amet consectetur. Eget velit sagittis sapien in vitae ut.',
                imagePath: 'assets/images/event_placeholder.png', // Placeholder
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 36,
              height: 36,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner({
    required String title,
    required String description,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 80,
            height: 80,
            color: Colors.grey[300], // Grey box
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, String title) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      width: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: Colors.black54), // Placeholder icon
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required BuildContext context,
    required bool isLive,
    required String tag,
    required String date,
    required String time,
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event banner with image and tag
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isLive ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Date and time row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  date,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(time, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Title and description
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 16),

          // Join Now button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Join Now'),
          ),
        ],
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
          child: const Text(
            'Common Difficulties in filing taxes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      }

      // Help Section Widget
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
              child: const Text('Contact Us'),
            ),
          ],
        );
      }
    }

