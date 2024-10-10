import 'package:flutter/material.dart';

class TaxFilingAdvPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tax filing and Advisory', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Section
            Container(
              height: 200,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Placeholder for image
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.image, color: Colors.grey, size: 40), // Resized Icon
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'File your taxes with us!',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Very easy and Intuitive way to do tax filing',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        SizedBox(height: 16), // Add space between text and button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => IncomeSourcesPage()), // Navigate to new page
                            );
                          },
                          child: Text('Start your journey'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'OTHER SERVICES',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            // Service Cards Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 10,
                children: [
                  _ServiceCard(
                    icon: Icons.account_balance,
                    color: Colors.orange[100]!,
                    label: 'Individual Tax Advisory',
                  ),
                  _ServiceCard(
                    icon: Icons.emoji_people,
                    color: Colors.green[100]!,
                    label: 'Retirement Planning',
                  ),
                  _ServiceCard(
                    icon: Icons.credit_card,
                    color: Colors.blue[100]!,
                    label: 'PAN Application',
                  ),
                  _ServiceCard(
                    icon: Icons.edit,
                    color: Colors.green[100]!,
                    label: 'PAN Correction Services',
                  ),
                  _ServiceCard(
                    icon: Icons.family_restroom,
                    color: Colors.lightBlue[100]!,
                    label: 'Succession Planning',
                  ),
                  _ServiceCard(
                    icon: Icons.link,
                    color: Colors.purple[100]!,
                    label: 'PAN – Aadhaar Linking',
                  ),
                  _ServiceCard(
                    icon: Icons.phone,
                    color: Colors.grey[200]!,
                    label: 'On-Call Tax Consultation',
                  ),
                ],
              ),
            ),
            // Footer Section with "Contact Us"
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Icon(Icons.help_outline, color: Colors.yellow[700]),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Difficulties in filing taxes?',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[900],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Eget velit sagittis sapien in vitae ut.',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.amber, width: 2),
                        padding: EdgeInsets.symmetric(horizontal: 150, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Contact us',
                        style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  _ServiceCard({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.black, size: 30), // Adjust icon size here
        ),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}

class IncomeSourcesPage extends StatefulWidget {
  @override
  _IncomeSourcesPageState createState() => _IncomeSourcesPageState();
}

class _IncomeSourcesPageState extends State<IncomeSourcesPage> {
  // List to keep track of selected checkboxes
  List<bool> _selectedSources = List.filled(8, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income Tax filing', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What are your income sources?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Select multiple if needed',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            // Income source checkboxes
            Expanded(
              child: ListView(
                children: [
                  _buildIncomeSourceCheckbox('NIL income', 0),
                  _buildIncomeSourceCheckbox('Rental income', 1),
                  _buildIncomeSourceCheckbox('Share Trading income', 2),
                  _buildIncomeSourceCheckbox('Professional/Business income', 3),
                  _buildIncomeSourceCheckbox('Income from Firm/LLP', 4),
                  _buildIncomeSourceCheckbox('Bank interest income', 5),
                  _buildIncomeSourceCheckbox('Property Sale income', 6),
                  _buildIncomeSourceCheckbox('Other source', 7),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Back and Next buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous page
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 85, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'BACK',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement "Next" button functionality
                    // You can navigate to the next page or process the selection
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF9B406),
                    padding: EdgeInsets.symmetric(horizontal: 85, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'NEXT',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build income source checkboxes
  Widget _buildIncomeSourceCheckbox(String title, int index) {
    return CheckboxListTile(
      title: Text(title),
      value: _selectedSources[index],
      onChanged: (bool? value) {
        setState(() {
          _selectedSources[index] = value!;
        });
      },
    );
  }
}
