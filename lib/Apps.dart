import 'package:flutter/material.dart';
import 'package:hayya_traya7/home.dart';
import 'package:hayya_traya7/visiteur.dart';
import 'login.dart';
import 'signin.dart';

class Apps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 60.0, // Adjust the top padding as needed
            ),
            child: Column(
              children: [
                Text(
                  'Haya traya7',
                  style: TextStyle(
                    fontSize: 42,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 0), // Add some space between the texts
                Text(
                  "SI PAS MAINTENANT , QUAND?",
                  style: TextStyle(
                    fontSize: 19, // Adjust the font size as needed
                    color:
                        Colors.orange, // Use the same color as the other text
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/homepage.jpg', // Replace 'your_image.png' with the path to your image asset
                  fit: BoxFit.cover, // Adjust the fit as needed
                  width:
                      double.infinity, // Make the image take all the page width
                  height: double
                      .infinity, // Make the image take all the page height
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 125),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to the login page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.orange,
                                textStyle: TextStyle(fontSize: 18),
                              ),
                              child: Text('SE CONNECTER'),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 200,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to the sign-in page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.orange,
                                textStyle: TextStyle(fontSize: 18),
                              ),
                              child: Text("S'INSCRIRE"),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 200,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to the home page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Visiteur()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.orange,
                                textStyle: TextStyle(fontSize: 18),
                              ),
                              child: Text("VISITER"),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
