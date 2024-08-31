// lib/registration_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: RegistrationForm(),
      ),
    );
  }
}
class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String userType = 'Customer'; // Default registration type

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _registerUser() async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Determine the selected registration type
      String collectionName = '';
      if (userType == 'Customer') {
        collectionName = 'Customer';
      } else if (userType == 'ShopKeeper') {
        collectionName = 'ShopKeeper';
      } else if (userType == 'Admin') {
        collectionName = 'admin';
      } else if (userType == 'DeliveryMan') {
        collectionName = 'deliveryMan';
      }

      // Store user details in Firestore
      await _firestore.collection(collectionName).doc(userCredential.user?.uid).set({
        'name': nameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'password': passwordController.text,
        'email': emailController.text,
        'type': userType,
      });

      // Redirect to the WelcomePage.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      // Handle registration error (e.g., show an error message)
      print('Registration failed: $e');

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(labelText: 'Phone Number'),
        ),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password'),
        ),
        TextFormField(
          controller: addressController,
          decoration: InputDecoration(labelText: 'Address'),
        ),
        DropdownButton<String>(
          value: userType,
          onChanged: (String? newValue) {
            setState(() {
              userType = newValue!;
            });
          },
          items: <String>['Customer', 'ShopKeeper', 'Admin', 'DeliveryMan']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        ElevatedButton(
          onPressed: _registerUser,
          child: Text('Register'),
        ),
      ],
    );
  }
}
