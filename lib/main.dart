// lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'splash_screen.dart'; // Import the SplashScreen class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyDc_yQfSwBU8e-j2x9IdhpfdATSEJZz844',
      authDomain: 'catchy-b68d8.firebaseapp.com',
      projectId: 'catchy-b68d8',
      storageBucket: 'catchy-b68d8.appspot.com',
      messagingSenderId: '874843638794',
      appId: '1:874843638794:android:9cca7ec01f60c6652ea3f3',
    ),
  );
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
