import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hayya_traya7/dureinfo.dart';
import 'package:hayya_traya7/dureres.dart';
import 'package:hayya_traya7/msakenclub.dart';
import 'home.dart'; // Import the Home page if not already imported

class durestadePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10, top: 10), // Adjust padding
          child: Align(
            alignment: Alignment.topLeft, // Align to top left corner
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.4),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/surffacedure.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Dans ce type de terrain, les échanges tendent à être plus tactiques, évoquant une partie d'
                          'échecs. Les joueurs qui s'
                          'appuient sur leur service pour engranger des points supplémentaires peuvent être confrontés à des obstacles, car la surface dure neutralise bon nombre des avantages du service rapide.',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to Plus d'informations page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => dureinfo(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 40, 40,
                                    40)!), // Light grey background color
                            minimumSize: MaterialStateProperty.all<Size>(Size(
                                double.infinity,
                                50)), // Make button width match the parent and set height to 50
                          ),
                          child: Text(
                            'Plus d\'informations',
                            style: TextStyle(
                              color: Colors.white, // White text color
                              fontSize: 16, // Adjust font size
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to Réserver page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => dureres(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 40, 40,
                                    40)!), // Light grey background color
                            minimumSize: MaterialStateProperty.all<Size>(Size(
                                double.infinity,
                                50)), // Make button width match the parent and set height to 50
                          ),
                          child: Text(
                            'Réserver',
                            style: TextStyle(
                              color: Colors.white, // White text color
                              fontSize: 16, // Adjust font size
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
