import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/image_controller.dart';

class ImagePickerScreen extends StatelessWidget {
  void _showImageSourceBottomSheet(BuildContext context) {
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
                Provider.of<ImageController>(context, listen: false).pickImageFromCamera(useFrontCamera: false);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                Provider.of<ImageController>(context, listen: false).pickImageFromGallery();
              },
            ),
          ],
        );
      },
    );
  }



  void _showErrorDialog(BuildContext context, String message) {
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
    var imageController = Provider.of<ImageController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Take a photo of the document',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Please ensure photos are clear and visible',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50),
            Center(
              child: GestureDetector(
                onTap: () => _showImageSourceBottomSheet(context),
                child: Container(
                  width: 250,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: imageController.imageModel.imagePath == null
                      ? Icon(Icons.add, size: 50)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(imageController.imageModel.imagePath!),
                            fit: BoxFit.cover,
                            width: 250,
                            height: 300,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (imageController.imageModel.imagePath != null)
              Center(
                child: Container(
                  width: 250,
                  child: ElevatedButton(
                    child: Text('Clear Image'),
                    onPressed: () {
                      Provider.of<ImageController>(context, listen: false).clearImage();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 30),
            if (imageController.imageModel.imagePath != null)
              Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: () => _showImageSourceBottomSheet(context),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}