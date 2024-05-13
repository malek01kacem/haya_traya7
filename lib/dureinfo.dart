import 'package:flutter/material.dart';
import 'package:hayya_traya7/durestade.dart';
import 'package:hayya_traya7/terrebattue.dart';
import 'home.dart'; // Import the Home page if not already imported

class dureinfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dureinfo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => durestadePage(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Text(
          'dureinfo',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
