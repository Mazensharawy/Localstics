import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgColor, // Ensures color consistency
        elevation: 0, // Removes shadow effect
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(
            fontFamily: GoogleFonts.aleo().fontFamily,
          ),
        )),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

