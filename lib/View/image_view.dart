import 'dart:io';
import 'package:flutter/material.dart';
import '../Controller/image_controller.dart';  // Import your ImageController

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;
  final ImageController _imageController = ImageController();

  void _showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    String? result = await _imageController.pickImageFromCamera(useFrontCamera: false); // No flipping
    if (result == null) {
      setState(() {
        _imageFile = File(_imageController.imageModel.imagePath!);
      });
    } else {
      _showErrorDialog(result);
    }
  }

  Future<void> _pickImageFromGallery() async {
    String? result = await _imageController.pickImageFromGallery();
    if (result == null) {
      setState(() {
        _imageFile = File(_imageController.imageModel.imagePath!);
      });
    } else {
      _showErrorDialog(result);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
        backgroundColor: Colors.white,  // Change to your desired color
      ),
      body: Container(
        color: Colors.white,  // Set the background color of the body to white
        padding: EdgeInsets.all(16.0), // Add some padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          children: <Widget>[
            // Two lines of text aligned to the left
            Text(
              'Take a photo of the document',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8), // Space between the lines
            Text(
              'Please ensure photos are clear and visible',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50), // Space before the image container
            Center(
              child: GestureDetector(
                onTap: _showImageSourceBottomSheet,
                child: Container(
                  width: 250,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _imageFile == null
                      ? Icon(Icons.add, size: 50)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                            width: 250,
                            height: 300,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (_imageFile != null)
            Center(
              child:
              Positioned(
                      bottom: 10, // Position from the bottom
                      child: Container(
                        width: 40, // Circle width
                        height: 40, // Circle height
                        decoration: BoxDecoration(
                          color: Colors.black, // Circle color
                          shape: BoxShape.circle, // Make it circular
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.white),
                          onPressed: _showImageSourceBottomSheet,
                          padding: EdgeInsets.zero, // Remove padding from IconButton
                        ),
                      ),),),
          ],
        ),
      ),
    );
  }
}
