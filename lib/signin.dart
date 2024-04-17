import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange, // Change icon color to orange
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            20.0, 10.0, 20.0, 20.0), // Adjust the padding
        child: Center(
          child: SingleChildScrollView(
            // Wrap with SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    // Logo Image
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/homepage.jpg', // Replace with your image asset path
                          width: 100, // Adjust the width as needed
                          height: 100, // Adjust the height as needed
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
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
                        color: Colors
                            .orange, // Use the same color as the other text
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    labelStyle: TextStyle(
                      color: Colors.orange, // Set label text color to orange
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(40.0), // Set border radius
                      borderSide: BorderSide(
                        color: Colors
                            .transparent, // Make border transparent initially
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                    labelStyle: TextStyle(
                      color: Colors.orange, // Set label text color to orange
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(40.0), // Set border radius
                      borderSide: BorderSide(
                        color: Colors
                            .transparent, // Make border transparent initially
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Téléphone',
                    labelStyle: TextStyle(
                      color: Colors.orange, // Set label text color to orange
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(40.0), // Set border radius
                      borderSide: BorderSide(
                        color: Colors
                            .transparent, // Make border transparent initially
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    labelStyle: TextStyle(
                      color: Colors.orange, // Set label text color to orange
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(40.0), // Set border radius
                      borderSide: BorderSide(
                        color: Colors
                            .transparent, // Make border transparent initially
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmer votre mot de passe',
                    labelStyle: TextStyle(
                      color: Colors.orange, // Set label text color to orange
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(40.0), // Set border radius
                      borderSide: BorderSide(
                        color: Colors
                            .transparent, // Make border transparent initially
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange, // Set border color
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle sign-in button press
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange, // Button color
                    padding: EdgeInsets.symmetric(
                        horizontal: 50, vertical: 14), // Button padding
                    textStyle: TextStyle(fontSize: 18), // Button text style
                  ),
                  child: Text('S\'INSCRIRE'),
                ),
                SizedBox(height: 10), // Add space between buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
