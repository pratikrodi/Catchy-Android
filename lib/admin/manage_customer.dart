import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageCustomersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Customers'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Customer').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Data is ready
            var customers = snapshot.data?.docs;

            // Check for null or empty list
            if (customers == null || customers.isEmpty) {
              return Text('No customers available.');
            }

            // Build a list of ListTile widgets with customer details
            var customerListTiles = customers.map<Widget>((customer) {
              var data = customer.data() as Map<String, dynamic>;
              var name = data['name'];
              var email = data['email'];
              var phone = data['phone'];
              var address = data['address'];

              return ListTile(
                title: Text('Name: $name'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: $email'),
                    Text('Phone: $phone'),
                    Text('Address: $address'),
                  ],
                ),
              );
            }).toList();

            // Return a ListView with the customer details
            return ListView(
              children: customerListTiles,
            );
          }
        },
      ),
    );
  }
}


