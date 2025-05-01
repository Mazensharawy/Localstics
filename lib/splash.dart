import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'onboard.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Set the status bar and navigation bar to match the background color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    // Initialize navigation sequence
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() async {
    // Create onboarding screen instance
    final onboardingScreen = OnboardingScreen();

    // Initial display time before transition starts (1.8 seconds)
    await Future.delayed(Duration(milliseconds: 2600));

    if (!mounted) return;

    // Navigate to onboarding with fade transition (1.2 seconds)
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => onboardingScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              // Using easeInOut for smoother transition
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
        // Slower transition duration (1.2 seconds)
        transitionDuration: Duration(milliseconds: 1200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Image.asset(
              'images/localstics_black.png',
              width: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 70),
            Lottie.asset(
              'images/splash.json',
              width: 125,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}