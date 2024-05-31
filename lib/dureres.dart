import 'package:flutter/material.dart';
import 'package:hayya_traya7/durestade.dart';
import 'home.dart'; // Import the Home page if not already imported

class dureres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dureres'),
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
          'dureres',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
