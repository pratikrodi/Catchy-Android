// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'deliveryman_page.dart';
// import 'forgot_password_page.dart';
// import 'registration_page.dart';
// import 'admin_page.dart';
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App Title',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoginPage(),
//     );
//   }
// }
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Page'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: LoginForm(),
//       ),
//     );
//   }
// }
//
// class LoginForm extends StatefulWidget {
//   @override
//   _LoginFormState createState() => _LoginFormState();
// }
//
// class _LoginFormState extends State<LoginForm> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   String userType = 'volunteers'; // Default user type
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> _login(BuildContext context) async {
//     try {
//       final String username = usernameController.text.trim().toLowerCase();
//       final String password = passwordController.text.trim();
//
//       // Try to sign in with the provided credentials
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: username,
//         password: password,
//       );
//
//       // Check if the user exists in the selected collection based on the user type
//       QuerySnapshot userQuery = await _firestore
//           .collection(userType)
//           .where('email', isEqualTo: username)
//           .get();
//
//       if (userQuery.docs.isNotEmpty) {
//         // Determine user type and navigate accordingly
//         var user = userQuery.docs.first.data();
//         if (userType == 'admins' && user['type'] == 'admin') {
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => adminPage()));
//         } else if (userType == 'donor' && user['type'] == 'Donor') {
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeliveryPartnerPage()));
//         } else if (userType == 'volunteers' && user['type'] == 'Volunteer') {
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeliveryPartnerPage()));
//         } else {
//           // If the user is not found, show an error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Invalid credentials or user type mismatch'),
//             ),
//           );
//         }
//       } else {
//         // If the user is not found, show an error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Invalid credentials'),
//           ),
//         );
//       }
//     } catch (e) {
//       // Handle login error (e.g., show an error message)
//       print('Login failed: $e');
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Login failed: $e'),
//         ),
//       );
//     }
//   }
//
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   // TODO: implement build
//   //   throw UnimplementedError();
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           TextFormField(
//             controller: usernameController,
//             decoration: InputDecoration(labelText: 'Username'),
//           ),
//           SizedBox(height: 20),
//           TextFormField(
//             controller: passwordController,
//             obscureText: true,
//             decoration: InputDecoration(labelText: 'Password'),
//           ),
//           SizedBox(height: 20),
//           DropdownButton<String>(
//             value: userType,
//             onChanged: (String? newValue) {
//               setState(() {
//                 userType = newValue!;
//               });
//             },
//             items: <String>['admins', 'donor', 'volunteers']
//                 .map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               _login(context);
//             },
//             child: Text('Login'),
//           ),
//           SizedBox(height: 10),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => RegistrationPage()),
//               );
//             },
//             child: Text('New User? Register here'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
//               );
//             },
//             child: Text('Forgot Password?'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:aahar/RegistrationPage.dart';
// import 'package:aahar/admin_page.dart';
// import 'package:aahar/DonorPage.dart';
// import 'package:aahar/volunteer_page.dart';
//
// class LoginPage extends StatelessWidget {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   void _login(BuildContext context) {
//     final String username = usernameController.text.trim().toLowerCase();
//     final String password = passwordController.text.trim();
//
//     if (username == 'saloni' && password == '12345') {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => adminPage()));
//     } else if (username == 'shivani' && password == '12345') {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VolunteerPage()));
//     } else if (username == 'shruti' && password == '12345') {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DonorPage()));
//     } else {
//       // Handle unknown user type or other cases
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
//     }
//   }
//
//   void _navigateToRegistrationPage(BuildContext context) {
//     Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Be the wellwisher'),
//         leading: Image.asset(
//           'images/icon.png', // Replace with your actual icon path
//           width: 36.0, // Adjust the size as needed
//           height: 36.0,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               controller: usernameController,
//               decoration: InputDecoration(labelText: 'Username'),
//             ),
//             TextFormField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             ElevatedButton(
//               onPressed: () => _login(context),
//               child: Text('Login'),
//             ),
//             ElevatedButton(
//               onPressed: () => _navigateToRegistrationPage(context),
//               child: Text('Click here to Register'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: LoginPage(),
//   ));
// }
import 'package:catchy/forgot_password_page.dart';
import 'package:catchy/registration_page.dart';
import 'package:catchy/shopkeeper/shopkeeper_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'admin/admin_page.dart';
import 'customer/customer_page.dart';
import 'deliveryman/deliveryman_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String userType = 'admin'; // Default user type

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _login(BuildContext context) async {
    try {
      final String username = usernameController.text.trim().toLowerCase();
      final String password = passwordController.text.trim();

      // Try to sign in with the provided credentials
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      // Check if the user exists in the selected collection based on the user type
      QuerySnapshot userQuery = await _firestore.collection(userType).where('email', isEqualTo: username).get();

      if (userQuery.docs.isNotEmpty) {
        // Determine user type and navigate accordingly
        var user = userQuery.docs.first.data();
        if (userType == 'admin') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPage()));
        } else if (userType == 'deliveryMan') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeliveryPartnerPage()));
        } else if (userType == 'Customer') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CustomerPage()));
        } else if (userType == 'ShopKeeper') {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopkeeperPage()));
        } else {
          // If the user is not found or the type is mismatched, show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid credentials or user type mismatch'),
            ),
          );
        }
      } else {
        // If the user is not found, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid credentials'),
          ),
        );
      }
    } catch (e) {
      // Handle login error (e.g., show an error message)
      print('Login failed: $e');
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
        ),
      );
    }
  }

  void _navigateToRegistrationPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
  }
  void _navigateToForgotPasswordPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catchy anything you can'),
        leading: Image.asset(
          'assets/images/Screenshotlogo.png', // Replace with your actual icon path
          width: 36.0, // Adjust the size as needed
          height: 36.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            DropdownButtonFormField<String>(
              value: userType,
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    userType = value;
                  });
                }
              },
              items: <String>['admin', 'Customer', 'ShopKeeper', 'DeliveryMan'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToRegistrationPage(context),
              child: Text('Click here to Register'),
            ),
            ElevatedButton(
              onPressed: () => _navigateToForgotPasswordPage(context),
              child: Text('Forgotten Password'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}