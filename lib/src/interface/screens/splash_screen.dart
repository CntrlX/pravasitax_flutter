import 'package:flutter/material.dart';
import 'dart:async'; // For Future.delayed

// Placeholder for AppPalette (Theme colors)
class AppPalette {
  static const Color kPrimaryColor = Colors.green; // Use any color of your choice
}

// Placeholder for AppTextStyle (Text styles)
class AppTextStyle {
  static const TextStyle kDisplayTitleR = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}

// Placeholder for AppRoutes (Define your app routes here)
class AppRoutes {
  static const String home = '/home'; // Change to your actual home route
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for fade effect
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Fade animation to make logo fade in
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Start the animation when the splash screen is shown
    _controller.forward();

    // Automatically navigate to the next screen after 3 seconds
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, AppRoutes.home); // Navigate to the appropriate route
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.kPrimaryColor, // Set the background color
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation, // Apply the fade animation
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Image (Make sure the path is correct in pubspec.yaml)
              Image.asset(
                'assets/pravasi_logo.png', // Add logo to your assets folder
                width: 150, // Adjust size based on your needs
                height: 150,
              ),
              const SizedBox(height: 20),
              // App name or tagline below the logo
              const Text(
                'Pravasi Tax',
                style: AppTextStyle.kDisplayTitleR, // Style for the app name
              ),
            ],
          ),
        ),
      ),
    );
  }
}
