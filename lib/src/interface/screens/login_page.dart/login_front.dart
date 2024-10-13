import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginFrontPage extends StatefulWidget {
  const LoginFrontPage({Key? key}) : super(key: key);

  @override
  _LoginFrontPageState createState() => _LoginFrontPageState();
}

class _LoginFrontPageState extends State<LoginFrontPage> {
  final List<String> images = [
    'assets/images/login_image1.jpg',
    'assets/images/login_image2.jpg',
  ];

  final List<String> descriptions = [
    'Lorem ipsum dolor sit amet consectetur. Eget velit sagittis sapien in vitae ut. Lorem cursus sed nunc diam ullamcorper elit.',
    'Hi\nLogin to avail Services',
  ];

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPageItem(images[index]);
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Column(
              children: [
                Text(
                  descriptions[_currentIndex],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.asMap().entries.map((entry) {
                    return Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(
                          _currentIndex == entry.key ? 0.9 : 0.4,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _currentIndex == 0
                    ? ElevatedButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                        ),
                        child: const Text('Skip'),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _showPhoneNumberModal(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
                          minimumSize: const Size(double.infinity, 50), // Set the button size
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text('Get OTP'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageItem(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhoneNumberModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter your phone number',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        '+91',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Enter your phone number',
                          border: OutlineInputBorder(),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showOtpVerificationScreen(context);
                  },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    minimumSize: const Size(double.infinity, 50), // Set the button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    ),
                    child: const Text('Get OTP'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showOtpVerificationScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Hi',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please enter your OTP',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _otpControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: const InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 1 && index < 3) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showUserInfoScreen(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Verify'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // TODO: Implement resend OTP functionality
                },
                child: const Text('Resend OTP'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUserInfoScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Hi',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please enter your Name',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your Email ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement user information submission
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User information submitted successfully')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text('Proceed'),
              ),
            ],
          ),
        );
      },
    );
  }
}