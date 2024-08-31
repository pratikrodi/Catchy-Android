// lib/forgot_password_page.dart

import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
   ForgotPasswordPage();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter your email to reset your password',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                // Implement your password reset logic here
                // Access the entered email using the controller
                // For now, navigate back to the login page
                Navigator.pop(context);
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
