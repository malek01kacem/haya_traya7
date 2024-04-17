import 'package:flutter/material.dart';
// Import the Login class
import 'Apps.dart'; // Import the apps class with lowercase 'h'

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Apps(), // Use the Login widget as the home page
    );
  }
}
