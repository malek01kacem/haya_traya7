import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hayya_traya7/config.dart';

class FeedbackPage extends StatelessWidget {
  final String token; // Pass the JWT token from the previous page

  FeedbackPage({Key? key, required this.token}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _sendFeedback(String fullName, String email, String feedback,
      BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('${defaultBaseUrls}api/feedback/create'),
          body: {'fullName': fullName, 'email': email, 'feedback': feedback},
        );
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Feedback submitted successfully!'),
            ),
          );
        } else {
          throw Exception('Failed to submit feedback');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Erreur lors de la soumission du feedback. Veuillez réessayer plus tard.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 100, // Specify the desired height
                  width: 100, // Specify the desired width
                  child: Image.asset('assets/images/feedback.png'),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Donnez votre avis ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Nom et Prénom',
                        hintText: 'Écrire votre nom et prénom',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre nom complet';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Écrire votre email',
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
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre email';
                        }
                        // You can add more email validation logic here if needed
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _feedbackController,
                      decoration: InputDecoration(
                        labelText: 'Feedback',
                        hintText: 'Écrire votre avis ici',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer votre feedback';
                        }
                        return null;
                      },
                      maxLines: 5,
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _sendFeedback(
                            _fullNameController.text,
                            _emailController.text,
                            _feedbackController.text,
                            context,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Adjust border radius as needed
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          child: Text(
                            'Envoyer ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
