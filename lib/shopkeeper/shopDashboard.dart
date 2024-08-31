import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductCountWidget(),
      ),
    );
  }
}

class ProductCountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        int productCount = snapshot.data!.docs.length;

        return ColoredBox(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Product Count: $productCount',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        );
      },
    );
  }
}
