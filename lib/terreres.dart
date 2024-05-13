import 'package:flutter/material.dart';
import 'package:hayya_traya7/terrebattue.dart';
import 'home.dart'; // Import the Home page if not already imported

class terreres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('terreres'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TerreBattuePage(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Text(
          'terreres',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
