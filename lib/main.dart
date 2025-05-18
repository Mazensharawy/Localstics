import 'package:flutter/material.dart';
import 'splash.dart'; // Import splash.dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'business_info_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("***** Firebase run correct *****");
  await Supabase.initialize(
    url: "https://knhumcyeelxdpcinhnyq.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtuaHVtY3llZWx4ZHBjaW5obnlxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc0NzMyNzAyNywiZXhwIjoyMDYyOTAzMDI3fQ.06xQaq1RTTjgcIn0dBf9E6ibDs11MpFlPB80UWZ4cUU",
  );


  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: SplashScreen()));

  
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
