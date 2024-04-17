import 'package:flutter/material.dart';
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
                  "SI CE N'EST PAS MAINTENANT ,QUAND?",
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
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the login page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange, // Text color
                          padding: EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 14), // Adjust button padding
                          textStyle: TextStyle(
                              fontSize: 18), // Adjust button text style
                        ),
                        child: Text(
                          'SE CONNECTER',
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
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
                          backgroundColor: Colors.orange, // Text color
                          padding: EdgeInsets.symmetric(
                            horizontal: 70,
                            vertical: 14,
                          ), // Adjust button padding
                          textStyle: TextStyle(
                            fontSize: 18,
                          ), // Adjust button text style
                        ),
                        child: Text(
                          "S'INSCRIRE",
                        ),
                      ),
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
