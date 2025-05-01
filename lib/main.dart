import 'package:flutter/material.dart';
import 'splash.dart'; // Import splash.dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'business_info_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: SplashScreen()));

  print("firebase run correct");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(); // Start the app with SplashScreen

  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Main Page'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Welcome to the Mainnn Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
