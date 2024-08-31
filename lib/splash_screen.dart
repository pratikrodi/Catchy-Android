// lib/splash_screen.dart

import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageLogo(),
            SizedBox(height: 16.0),
            const Text(
              '',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            const Text(
              'An online Selling and Shopping portal for Shop Owners and Customers',
              style: TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageLogo extends StatelessWidget {
  const ImageLogo();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/Screenshotlogo.png', // Adjust the path based on your project structure
      width: 400.0,
      height: 250.0,
    );
  }
}
