import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hayya_traya7/home.dart';
import 'package:http/http.dart' as http;
import 'package:hayya_traya7/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hayya_traya7/config.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var response = await http.post(
        Uri.parse('${defaultBaseUrls}api/users/login'),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var responseData = json.decode(response.body);
        var token = responseData['token'];
        await prefs.setString(
            'token', token); // Save token to SharedPreferences
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        print('Login failed: ${response.body}');
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
        padding: const EdgeInsets.fromLTRB(
          20.0,
          10.0,
          20.0,
          20.0,
        ),
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
                      "SI CE N'EST PAS MAINTENANT ,QUAND?",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
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
                    labelText: 'Mot de passe',
                    labelStyle: TextStyle(
                      color: Colors.orange,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 14,
                    ),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('SE CONNECTER'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 14,
                    ),
                    textStyle: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  child: Text(
                    "S'INSCRIRE",
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Action for "Mot de passe oublié ?" button
                  },
                  child: Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
