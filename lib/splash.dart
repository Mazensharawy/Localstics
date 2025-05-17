import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'onboard.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'features/Seller/user_mode.dart';

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
    await Future.delayed(Duration(milliseconds: 2600));
    if (!mounted) return;
    // Check if user is logged in
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // User is logged in, go to home (UserModeWrapper)
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => UserModeWrapper(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 1200),
        ),
      );
    } else {
      // Not logged in, go to onboarding
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 1200),
        ),
      );
    }
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

// Prevent back navigation to login/onboarding after login
// Use pushAndRemoveUntil in your login/signup screens after successful login/signup:
// Navigator.of(context).pushAndRemoveUntil(
//   MaterialPageRoute(builder: (context) => UserModeWrapper()),
//   (route) => false,
// );
// This ensures the user cannot go back to onboarding/login after logging in.