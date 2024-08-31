import 'package:flutter/material.dart';

class Product {
  final String name;
  final String image;
  final double price;
  final String details;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.details,
  });
}

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product.image,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Text(
              'Name: ${product.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Price: \$${product.price.toString()}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10.0),
            Text(
              'Details: ${product.details}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
