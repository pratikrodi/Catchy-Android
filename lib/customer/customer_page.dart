import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'cart_page.dart';
// import 'shopProductPage.dart'; // Import the ShopProductPage class

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    CustomerHomeTab(), // Updated tab content
    CustomerSearchTab(),
    CustomerProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Logic to navigate to the cart page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class CustomerHomeTab extends StatefulWidget {
  @override
  _CustomerHomeTabState createState() => _CustomerHomeTabState();
}

class _CustomerHomeTabState extends State<CustomerHomeTab> {
  late Future<List<ShopProfile>> _shopProfiles;

  @override
  void initState() {
    super.initState();
    _shopProfiles = fetchShopProfiles();
  }

  Future<List<ShopProfile>> fetchShopProfiles() async {
    try {
      // Access Firestore instance
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      // Query shop profiles from the 'shopProfile' collection
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await _firestore.collection('shopProfile').get();

      // Convert query snapshot to a list of ShopProfile objects
      List<ShopProfile> shopProfiles = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return ShopProfile(
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          imageUrl: data['imageUrl'] ?? '',
          shopId: data['shopId'] ?? '',
          // Add more fields as needed
        );
      }).toList();

      return shopProfiles;
    } catch (e) {
      print('Error fetching shop profiles: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _shopProfiles,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return Center(
            child: Text('No shops found.'),
          );
        } else {
          List<ShopProfile> shopProfiles = snapshot.data as List<ShopProfile>;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _getCrossAxisCount(context),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: shopProfiles.length,
            itemBuilder: (context, index) {
              ShopProfile shopProfile = shopProfiles[index];
              return GestureDetector(
                // onTap: () {
                //   // Handle shop profile tap
                //   // You can navigate to a detailed shop page or perform any other action
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => ShopProductsPage(shopProfile: shopProfile),
                //     ),
                //   );
                // },
                child: Card(
                  elevation: 2.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display shop image
                      Container(
                        height: _getImageContainerHeight(context),
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            shopProfile.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      // Display shop information
                      Text(
                        shopProfile.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        shopProfile.description,
                        style: TextStyle(fontSize: 14.0),
                      ),
                      // Add more fields as needed
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth / 200).floor(); // Adjust the item width as needed
  }

  double _getImageContainerHeight(BuildContext context) {
    // Adjust the image container height as needed
    return MediaQuery.of(context).size.width / _getCrossAxisCount(context);
  }
}

class ShopProfile {
  final String name;
  final String description;
  final String imageUrl;
  final String shopId;

  ShopProfile({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.shopId,
  });
}

class CustomerSearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Tab Content'),
    );
  }
}

class CustomerProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Tab Content'),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CustomerPage(),
  ));
}
