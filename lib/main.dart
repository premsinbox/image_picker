import 'package:flutter/material.dart';
import 'package:imagepickerapp/View/image_view.dart';
import 'package:provider/provider.dart';
import 'Controller/image_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ImageController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImagePickerScreen(),
    );
  }
}
