import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // Ensure this file is correctly generated and configured
import 'splash_screen.dart'; // Import the SplashScreen class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Use this if using Firebase CLI configuration
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Handle initialization error (e.g., show an error message or exit the app)
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catchy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Set SplashScreen as the home widget
    );
  }
}
