import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopProductsPage extends StatefulWidget {
  final ShopProfile shopProfile;

  ShopProductsPage({required this.shopProfile});

  @override
  _ShopProductsPageState createState() => _ShopProductsPageState();
}

class _ShopProductsPageState extends State<ShopProductsPage> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('products')
          .where('shopId', isEqualTo: widget.shopProfile.shopId)
          .get();

      List<Product> products = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Product(
          name: data['name'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          details: data['details'] ?? '',
        );
      }).toList();

      return products;
    } catch (e) {
      print('Error fetching products: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products for ${widget.shopProfile.name}'),
      ),
      body: FutureBuilder(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error fetching products: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(
              child: Text('No products found for ${widget.shopProfile.name}.'),
            );
          } else {
            List<Product> products = snapshot.data as List<Product>;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                Product product = products[index];
                return Card(
                  elevation: 2.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display product image
                      Container(
                        height: 100.0,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Display product information
                      Text(
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Price: \$${product.price.toString()}',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Text(
                        product.details,
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String details;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.details,
  });
}

class ShopProfile {
  final String name;
  final String details;
  final String imageUrl;
  final String shopId;

  ShopProfile({
    required this.name,
    required this.details,
    required this.imageUrl,
    required this.shopId,
  });
}
