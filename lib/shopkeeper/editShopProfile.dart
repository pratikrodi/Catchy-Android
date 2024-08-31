import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class EditShopProfilePage extends StatefulWidget {
  @override
  _EditShopProfilePageState createState() => _EditShopProfilePageState();
}

class _EditShopProfilePageState extends State<EditShopProfilePage> {
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopCategoryController = TextEditingController();
  final TextEditingController shopDetailsController = TextEditingController();
  final TextEditingController shopAddressController = TextEditingController();
  Uint8List? shopImageBytes;

  Future<void> _pickImage() async {
    try {
      if (kIsWeb) {
        FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

        if (result != null) {
          final bytes = result.files.first.bytes;
          setState(() {
            shopImageBytes = bytes;
          });
        }
      } else {
        // For non-web platforms, use ImagePicker
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );

        if (pickedFile != null) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            shopImageBytes = bytes;
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
        ),
      );
    }
  }

  Future<void> _submitProduct() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
      final Timestamp timestamp = Timestamp.now();

      final Map<String, dynamic> shopData = {
        'name': shopNameController.text,
        'category': shopCategoryController.text,
        'details': shopDetailsController.text,
        'address': shopAddressController.text,
        'timestamp': timestamp,
      };

      if (shopImageBytes != null) {
        final String imagePath =
            'shopProfile/${timestamp.seconds}_${timestamp.nanoseconds}.jpg';

        await _firebaseStorage.ref(imagePath).putData(shopImageBytes!);
        shopData['image'] = await _firebaseStorage.ref(imagePath).getDownloadURL();
      }

      await _firestore.collection('shopProfile').add(shopData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added successfully!'),
        ),
      );
    } catch (e) {
      print('Error submitting product: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting product: $e'),
        ),
      );
    }
  }

  Widget _buildProductImageWidget() {
    if (shopImageBytes != null) {
      return Image.memory(
        shopImageBytes!,
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: shopNameController,
              decoration: InputDecoration(labelText: 'Shop Name'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: shopCategoryController,
              decoration: InputDecoration(labelText: 'Shop Category'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: shopDetailsController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Shop Details'),
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 20.0),
            TextFormField(
              controller: shopAddressController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Shop Address'),
            ),
            ElevatedButton(
              onPressed: () => _pickImage(),
              child: Text('Select Shop Image'),
            ),
            SizedBox(height: 20.0),
            _buildProductImageWidget(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _submitProduct(),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
