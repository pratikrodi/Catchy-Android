import 'package:catchy/shopkeeper/addProduct.dart';
import 'package:catchy/shopkeeper/editProductDetails.dart';
import 'package:catchy/shopkeeper/editShopProfile.dart';
import 'package:catchy/shopkeeper/removeProduct.dart';
import 'package:catchy/shopkeeper/shopDashboard.dart';
import 'package:flutter/material.dart';

class Product {
  String name;
  String image;
  double price;
  String details;

  Product({required this.name, required this.image, required this.price, required this.details});
}

class ShopkeeperPage extends StatefulWidget {
  @override
  _ShopkeeperPageState createState() => _ShopkeeperPageState();
}

class _ShopkeeperPageState extends State<ShopkeeperPage> {
  List<Product> products = [
    Product(name: 'Product 1', image: 'image1.jpg', price: 20.0, details: 'Product 1 details'),
    Product(name: 'Product 2', image: 'image2.jpg', price: 30.0, details: 'Product 2 details'),
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopkeeper Page'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Shopkeeper Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Edit Shop Profile'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the EditShopNamePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditShopProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('Add Product'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the AddProductPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                );
              },
            ),
            ListTile(
              title: Text('Remove Product'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the RemoveProductPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RemoveProductPage()),
                );
              },
            ),
            ListTile(
              title: Text('Edit Product Details'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the RemoveProductPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProductPage()),
                );
              },
            ),
            ListTile(
              title: Text('Shop Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the ShopDashboardPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopDashboardPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Product product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: \$${product.price.toString()}'),
                Text('Details: ${product.details}'),
              ],
            ),
            leading: Image.asset(
              'assets/${product.image}', // Make sure to replace 'assets/' with your actual asset path
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            onTap: () {
              // Handle tapping on a product
              // You can navigate to a detailed product page or perform other actions
            },
          );
        },
      ),
    );
  }
}
