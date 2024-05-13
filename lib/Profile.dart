import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // For making network requests

class ProfilePage extends StatefulWidget {
  final String token; // Pass the JWT token from the previous page

  const ProfilePage({Key? key, required this.token}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName = '';
  String _lastName = '';
  String _profileImageUrl = ''; // Optional, for user profile image

  Future<void> fetchProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String brear_token = prefs.getString('token') ?? '';
    print('Token : ${brear_token}');
    if (brear_token != '') {
      // Replace 'your_api_endpoint' with the actual URL for fetching user data
      final response = await http.get(
        Uri.parse('http://192.168.1.8:3500/api/users/details'),
        headers: {'Authorization': 'Bearer ${brear_token}'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Handle potential errors in the data structure
        if (data.containsKey('user')) {
          Map<String, dynamic> user = data['user'];
          if (user.containsKey('firstName') && user.containsKey('lastName')) {
            setState(() {
              _userName = user['firstName'];
              _lastName = user['lastName'];
              _profileImageUrl = user['profileImg'];
            });
          }
        } else {
          // Display error message if data structure is incorrect
          print('Error: Missing required fields in user data');
        }
      } else {
        // Handle other error scenarios
        print('Error fetching profile data: ${response.statusCode}');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfileData(); // Fetch data on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display profile image if available
            _profileImageUrl.isNotEmpty
                ? CircleAvatar(
                    //backgroundImage: FileImage(File(_profileImageUrl)),
                    radius: 50.0,
                  )
                : const Icon(
                    Icons.account_circle,
                    size: 80.0,
                  ),
            const SizedBox(height: 20.0),

            // Conditional rendering for user name and last name
            _userName.isNotEmpty && _lastName.isNotEmpty
                ? Text(
                    '$_userName $_lastName',
                    style: const TextStyle(fontSize: 20.0),
                  )
                : const Text(
                    'Loading Profile...', // Display loading message while fetching data
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),

            // Add additional profile information if needed
          ],
        ),
      ),
    );
  }
}
