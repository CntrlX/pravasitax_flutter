import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pravasitax_flutter/src/core/theme/app_theme.dart';
import 'package:pravasitax_flutter/src/data/providers/auth_provider.dart';
import 'dart:developer' as developer;

class LoginFrontPage extends ConsumerStatefulWidget {
  const LoginFrontPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginFrontPage> createState() => _LoginFrontPageState();
}

class _LoginFrontPageState extends ConsumerState<LoginFrontPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  final TextEditingController _emailController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  bool _isLoading = false;
  String? _errorMessage;
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 2,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPageItem(index == 0
                  ? 'assets/images/login_image1.jpg'
                  : 'assets/images/login_image2.jpg');
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Column(
              children: [
                Text(
                  _currentIndex == 0
                      ? 'Welcome to Pravasi Tax'
                      : 'Login to access your account',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0, 1].map((index) {
                    return Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                            .withOpacity(_currentIndex == index ? 0.9 : 0.4),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _currentIndex == 0
                    ? ElevatedButton(
                        onPressed: () {
                          _pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.kPrimaryColor,
                          minimumSize: const Size(200, 50),
                        ),
                        child: const Text('Get Started'),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(color: Colors.white70),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            if (_errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _handleGetOTP,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppPalette.kPrimaryColor,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Get OTP'),
                            ),
                          ],
                        ),
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

  Future<void> _handleGetOTP() async {
    final email = _emailController.text.trim();
    developer.log('Handling OTP request for email: $email',
        name: 'LoginFrontPage._handleGetOTP');

    if (email.isEmpty) {
      developer.log('Email is empty', name: 'LoginFrontPage._handleGetOTP');
      setState(() {
        _errorMessage = 'Please enter your email';
      });
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      developer.log('Invalid email format: $email',
          name: 'LoginFrontPage._handleGetOTP');
      setState(() {
        _errorMessage = 'Please enter a valid email';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await ref.read(authProvider.notifier).sendOTP(email);
      final authState = ref.read(authProvider);

      if (authState.error != null) {
        developer.log('Error from auth state: ${authState.error}',
            name: 'LoginFrontPage._handleGetOTP');
        setState(() {
          _errorMessage = authState.error;
        });
        return;
      }

      if (mounted) {
        developer.log('OTP sent successfully, showing verification dialog',
            name: 'LoginFrontPage._handleGetOTP');
        _showOtpVerificationDialog(email);
      }
    } catch (e) {
      developer.log('Error sending OTP',
          error: e.toString(), name: 'LoginFrontPage._handleGetOTP');
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll('Exception: ', '');
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showOtpVerificationDialog(String email) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Enter OTP'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please enter the OTP sent to your email'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => OTPTextField(
                  controller: _otpControllers[index],
                  focusNode: _otpFocusNodes[index],
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 5) {
                      _otpFocusNodes[index + 1].requestFocus();
                    }
                  },
                  onBackspace: () {
                    if (index > 0) {
                      _otpControllers[index - 1].clear();
                      _otpFocusNodes[index - 1].requestFocus();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _verifyOTP(email),
            child: const Text('Verify'),
          ),
        ],
      ),
    );
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 15),
                Text('Verifying OTP...'),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _verifyOTP(String email) async {
    final otp = _otpControllers.map((controller) => controller.text).join();
    developer.log('Verifying OTP for email: $email',
        name: 'LoginFrontPage._verifyOTP');

    if (otp.length != 6) {
      developer.log('Invalid OTP length: ${otp.length}',
          name: 'LoginFrontPage._verifyOTP');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    _showLoadingDialog();

    try {
      await ref.read(authProvider.notifier).verifyOTP(email, otp);
      final authState = ref.read(authProvider);

      // Dismiss loading dialog
      if (mounted) {
        Navigator.of(context).pop(); // Pop loading dialog
      }

      if (authState.isAuthenticated) {
        developer.log('Authentication successful, navigating to home',
            name: 'LoginFrontPage._verifyOTP');
        if (mounted) {
          Navigator.of(context).pop(); // Pop OTP dialog
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } else {
        developer.log('Authentication failed: Invalid OTP',
            name: 'LoginFrontPage._verifyOTP');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid OTP')),
          );
        }
      }
    } catch (e) {
      // Dismiss loading dialog
      if (mounted) {
        Navigator.of(context).pop(); // Pop loading dialog
      }
      
      developer.log('Error verifying OTP',
          error: e.toString(), name: 'LoginFrontPage._verifyOTP');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}

class OTPTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function() onBackspace;

  const OTPTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspace,
  }) : super(key: key);

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent event) {
          if (event is RawKeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.backspace) {
              if (widget.controller.text.isEmpty) {
                widget.onBackspace();
              }
            }
          }
        },
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              widget.onChanged(value);
            } else {
              // Handle backspace when text is cleared
              widget.onBackspace();
            }
          },
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ),
    );
  }
}
