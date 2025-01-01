import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pravasitax_flutter/mainPage_consultant.dart';
import 'package:pravasitax_flutter/src/core/theme/app_theme.dart';
import 'package:pravasitax_flutter/src/interface/screens/login_pages/splash_screen.dart';
import 'package:pravasitax_flutter/mainpage.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pravasi Tax',
      theme: ThemeData(
        primaryColor: AppPalette.kPrimaryColor,
        // colorScheme: ColorScheme.fromSwatch().copyWith(
        //   primary: AppPalette.kPrimaryColor,
        //   secondary: AppPalette.kSecondaryColor,
        // ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => MainPage(),
        '/home_consultant': (context) => MainPageConsultantPage(),
      },
    );
  }
}
