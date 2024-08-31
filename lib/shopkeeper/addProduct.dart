import 'dart:io' as io;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDetailsController = TextEditingController();
  Uint8List? productImageBytes;

  Future<void> _pickImage() async {
    try {
      if (kIsWeb) {
        FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

        if (result != null) {
          final bytes = result.files.first.bytes;
          setState(() {
            productImageBytes = bytes;
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
            productImageBytes = bytes;
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

      final Map<String, dynamic> productData = {
        'name': productNameController.text,
        'price': double.parse(productPriceController.text),
        'details': productDetailsController.text,
        'timestamp': timestamp,
      };

      if (productImageBytes != null) {
        final String imagePath =
            'products/${timestamp.seconds}_${timestamp.nanoseconds}.jpg';

        await _firebaseStorage.ref(imagePath).putData(productImageBytes!);
        productData['image'] = await _firebaseStorage.ref(imagePath).getDownloadURL();
      }

      await _firestore.collection('products').add(productData);

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
    if (productImageBytes != null) {
      return Image.memory(
        productImageBytes!,
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
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: productNameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: productPriceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Product Price'),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: productDetailsController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Product Details'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _pickImage(),
              child: Text('Select Product Image'),
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
