import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hayya_traya7/Apps.dart';
import 'package:hayya_traya7/home.dart';
import 'package:hayya_traya7/config.dart';

class Settingspage extends StatefulWidget {
  final String token;

  const Settingspage({Key? key, required this.token}) : super(key: key);

  @override
  _SettingspageState createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String brear_token = prefs.getString('token') ?? '';
    print('Token : ${brear_token}');
    if (brear_token.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('${defaultBaseUrls}api/users/details'),
          headers: {'Authorization': 'Bearer $brear_token'},
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body)['user'];
          setState(() {
            _firstNameController =
                TextEditingController(text: userData['firstName']);
            _lastNameController =
                TextEditingController(text: userData['lastName']);
            _emailController = TextEditingController(text: userData['email']);
            _phoneNumberController =
                TextEditingController(text: userData['phoneNumber']);
          });
        } else {
          throw Exception('Failed to fetch user data');
        }
      } catch (error) {
        print('Error fetching user data: $error');
        // Handle error gracefully (e.g., show error message to the user)
      }
    }
  }

  Future<void> _updateUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String brear_token = prefs.getString('token') ?? '';
    if (brear_token.isNotEmpty) {
      try {
        final response = await http.put(
          Uri.parse('${defaultBaseUrls}api/users/update/profile'),
          headers: {
            'Authorization': 'Bearer $brear_token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'firstName': _firstNameController.text,
            'lastName': _lastNameController.text,
            'email': _emailController.text,
            'phoneNumber': _phoneNumberController.text,
            'oldPassword': _oldPasswordController.text,
            'newPassword': _newPasswordController.text,
          }),
        );

        if (response.statusCode == 200) {
          print('User data updated successfully');
          // Show success message and navigate to home page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Informations mises à jour avec succès')),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()), // Replace Apps with your main app widget
            (Route<dynamic> route) => false,
          );
        } else {
          throw Exception('Failed to update user data');
        }
      } catch (error) {
        print('Error updating user data: $error');
        // Handle error gracefully (e.g., show error message to the user)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erreur lors de la mise à jour des informations')),
        );
      }
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // You might also want to navigate the user to the login screen or perform any other necessary actions after logout.
  }

  Future<void> _deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String brear_token = prefs.getString('token') ?? '';
    if (brear_token.isNotEmpty) {
      try {
        // Call logout function before sending the delete account request
        await _logout();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Apps(), // Navigate to Apps.dart
          ),
        );
        final response = await http.delete(
          Uri.parse('${defaultBaseUrls}api/users/permanent/delete'),
          headers: {'Authorization': 'Bearer $brear_token'},
        );

        if (response.statusCode == 200) {
          // User deleted successfully
          print('User deleted successfully');
          return; // Return to prevent showing error message
        } else {
          throw Exception('Failed to delete user');
        }
      } catch (error) {
        print('Error deleting user: $error');
        // Handle error gracefully (e.g., show error message to the user)
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 100, // Specify the desired height
                  width: 100, // Specify the desired width
                  child: Image.asset('assets/images/setting.png'),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Éditer vos coordonnées ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildEditableField(
                  controller: _firstNameController,
                  labelText: 'Prénom', // Change label text to French
                  fieldName: 'firstName',
                  isBold: true,
                  fontSize: 18.0),
              SizedBox(height: 15.0),
              _buildEditableField(
                controller: _lastNameController,
                labelText: 'Nom de famille', // Change label text to French
                fieldName: 'lastName',
                isBold: true,
                fontSize: 18.0,
              ),
              SizedBox(height: 15.0),
              _buildEditableField(
                controller: _emailController,
                labelText: 'Adresse e-mail', // Change label text to French
                fieldName: 'email',
                isBold: true,
                fontSize: 18.0,
              ),
              SizedBox(height: 15.0),
              _buildEditableField(
                controller: _phoneNumberController,
                labelText: 'Numéro de téléphone', // Change label text to French
                fieldName: 'phoneNumber',
                isBold: true,
                fontSize: 18.0,
              ),
              _buildPasswordFields(),
              SizedBox(height: 20.0),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: 300,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _updateUserData();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.orange, // Background color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Border radius
                              ),
                            ),
                            child: Text(
                              'Modifier', // Change button text to French
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22, // Font size
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: 300,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _confirmDeleteUser();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.red, // Red color for delete button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Border radius
                              ),
                            ),
                            child: Text(
                              'Supprimer compte', // Change button text to French
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white, // Font size
                              ),
                            ),
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
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String labelText,
    required String fieldName,
    bool isBold = false,
    double fontSize = 16.0,
  }) {
    return TextField(
      controller: controller,
      style: TextStyle(
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.orange),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.orange),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _buildPasswordFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Text(
          'Modifier le mot de passe', // Change title text to French
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: _oldPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Ancien mot de passe', // Change label text to French
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.orange),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.orange),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: _newPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Nouveau mot de passe', // Change label text to French
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.orange),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.orange),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }

  void _confirmDeleteUser() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Confirmation",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Divider(height: 0, color: Color.fromARGB(255, 255, 114, 33)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Êtes-vous sûr de vouloir supprimer votre compte ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(height: 0, color: Color.fromARGB(255, 68, 184, 58)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Annuler",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 11, 11),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    VerticalDivider(width: 0, color: Colors.grey),
                    TextButton(
                      onPressed: () {
                        _deleteUser();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Confirmer",
                        style: TextStyle(
                          color: Color.fromARGB(255, 12, 146, 12),
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
