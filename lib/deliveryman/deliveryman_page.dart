import 'package:flutter/material.dart';

class DeliveryPartnerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery Partner Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Welcome, Delivery Partner!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to view delivered products
                // Redirect to a page to view delivered products
              },
              child: Text('View Delivered Products'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logic to view remaining products
                // Redirect to a page to view remaining products
              },
              child: Text('View Remaining Products'),
            ),
          ],
        ),
      ),
    );
  }
}
