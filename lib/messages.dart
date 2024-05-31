import 'package:flutter/material.dart';
import 'package:hayya_traya7/Profile.dart';
import 'home.dart'; // Ensure the Home page is imported

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('messages'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous page
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          'messages',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
