import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ManageShopsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage ShopKeepers'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ShopKeeper').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Data is ready
            var shopkeeper = snapshot.data?.docs;

            // Check for null or empty list
            if (shopkeeper == null || shopkeeper.isEmpty) {
              return Text('No shopkeeper available.');
            }

            // Build a list of ListTile widgets with customer details
            var shopkeeperListTiles = shopkeeper.map<Widget>((shopkeeper) {
              var data = shopkeeper.data() as Map<String, dynamic>;
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
              children: shopkeeperListTiles,
            );
          }
        },
      ),
    );
  }
}
