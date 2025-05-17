import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth/signup_screen.dart';
import 'auth/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to left
                children: [
                  // Onboarding Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Embrace\nlocal finds &\nSustainable\nMinds.",
                      style: GoogleFonts.abhayaLibre(
                        fontSize: 64,
                        fontWeight: FontWeight.w800, // ExtraBold
                        height: 51.2 / 64, // Line height ratio
                        letterSpacing: -0.05 * 64, // Letter spacing (-0.05em)
                      ),
                    ),
                  ),
                  // SizedBox(height: 100),
                  Image.asset(
                    'images/onboard_wave.png',
                    width: 390, // Set the desired width
                    fit: BoxFit.fill,
                  ),
                  SizedBox(height: 60),

                  // Create Account Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to sign-up screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.black, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Create an Account",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Log in Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          // Navigate to login screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: Colors.black), // Border color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Log In",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Continue as Guest
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: TextButton(
                      onPressed: () {
                        // Navigate as guest
                      },
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Continue as a guest",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
