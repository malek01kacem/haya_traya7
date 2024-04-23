import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

import 'login.dart';

import 'config.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignInPage extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool _isNotValidate = false;

  void registerUser() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty) {
      // Make HTTP POST request to register endpoint
      var response = await http.post(
        Uri.parse(
            'http://192.168.1.6:3500/api/users/register'), // Update with your backend API endpoint
        body: {
          'email': emailController.text,
          'password': passwordController.text,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'phoneNumber': phoneNumberController.text,
          // Add other fields as needed
        },
      );
      var jsonResponse = jsonDecode(response.body);
      // Handle response
      if (response.statusCode == 201) {
        print('Registration successful: ${response.body}');
        // Navigate user to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginPage()), // Replace LoginPage() with the widget for your login screen
        );
      } else {
        // Registration failed
        // Display error message to user
        print('Registration failed: ${response.body}');
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.orange,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/LOGO.png',
                          width: 100,
                          height: 100,
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
                    SizedBox(height: 0),
                    Text(
                      "SI CE N'EST PAS MAINTENANT, QUAND?",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                    labelText: 'Nom',
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                    labelText: 'Prénom',
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                    labelText: 'Téléphone',
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Adresse email',
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _isNotValidate ? "Enter Proper Info" : null,
                    labelText: 'Mot de passe',
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    registerUser();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('S\'INSCRIRE'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
