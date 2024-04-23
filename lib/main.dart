import 'package:flutter/material.dart';
import 'package:hayya_traya7/Apps.dart';
import 'package:hayya_traya7/home.dart';
import 'package:hayya_traya7/login.dart';
import 'package:hayya_traya7/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Apps(),
    );
  }
}
