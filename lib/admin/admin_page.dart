import 'package:catchy/admin/admin_page.dart';
import 'package:catchy/admin/manage_customer.dart';
import 'package:catchy/admin/manage_deliveryman.dart';
import 'package:catchy/admin/manage_shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int customerCount = 0;
  int shopkeeperCount = 0;
  int deliverymanCount = 0;

  @override
  void initState() {
    super.initState();
    fetchDataCounts();
  }

  Future<void> fetchDataCounts() async {
    try {
      // Fetch customer count
      QuerySnapshot customerSnapshot = await FirebaseFirestore.instance.collection('Customer').get();
      setState(() {
        customerCount = customerSnapshot.size;
      });

      // Fetch shopkeeper count
      QuerySnapshot shopkeeperSnapshot = await FirebaseFirestore.instance.collection('ShopKeeper').get();
      setState(() {
        shopkeeperCount = shopkeeperSnapshot.size;
      });

      // Fetch deliveryman count
      QuerySnapshot deliverymanSnapshot = await FirebaseFirestore.instance.collection('deliveryMan').get();
      setState(() {
        deliverymanCount = deliverymanSnapshot.size;
      });
    } catch (e) {
      print('Error fetching counts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Admin Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Manage Shops'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageShopsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Manage Customers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageCustomersPage()),
                );
              },
            ),
            ListTile(
              title: Text('Manage Deliverymen'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageDeliverymenPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            children: [
              _buildCountCard('Customers', customerCount, Colors.blue),
              _buildCountCard('Shopkeepers', shopkeeperCount, Colors.green),
              _buildCountCard('Deliverymen', deliverymanCount, Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountCard(String title, int count, Color color) {
    return GestureDetector(
      onTap: () {
        // Redirect to respective pages
        if (title == 'Customers') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageCustomersPage()),
          );
        } else if (title == 'Shopkeepers') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageShopsPage()),
          );
        } else if (title == 'Deliverymen') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageDeliverymenPage()),
          );
        }
      },
      child: Card(
        color: color,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}