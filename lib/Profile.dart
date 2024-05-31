import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hayya_traya7/feedback.dart';
import 'package:hayya_traya7/messages.dart';
import 'package:hayya_traya7/settingspage.dart';
import 'package:hayya_traya7/terrebattue.dart';
import 'package:http/http.dart' as http;
import 'package:hayya_traya7/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// For making network requests

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
        Uri.parse('${defaultBaseUrls}api/users/details'),
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
              print("$_profileImageUrl,_profileImageUrl");
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
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Settingspage(
                          token: '',
                        )),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              // Navigate to messages page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Messages()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display profile image if available
                _profileImageUrl.isNotEmpty
                    ? ClipOval(
                        child: CachedNetworkImage(
                          height: 50,
                          width: 50,
                          cacheManager: CacheManager(Config(
                            "fluttercampus",
                            stalePeriod: const Duration(days: 20),
                            //one week cache period
                          )),
                          imageUrl: "$_profileImageUrl",
                          fadeInCurve: Curves.fastOutSlowIn,
                          placeholder: (context, url) => SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.face,
                              color: Colors.white30,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.black87,
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.face,
                              color: Colors.white30,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(
                        width: 100.0,
                        height: 90,
                      ),

                // Conditional rendering for user name and last name
                _userName.isNotEmpty && _lastName.isNotEmpty
                    ? Text(
                        '$_userName $_lastName',
                        style: TextStyle(
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 254, 95, 67)
                                  .withOpacity(1), // Add shadow
                              offset: Offset(1, 2), // Set shadow offset
                              blurRadius: 5, // Set shadow blur radius
                            ),
                          ],
                        ),
                      )
                    : const Text(
                        'Loading Profile...', // Display loading message while fetching data
                        style: TextStyle(fontSize: 16.0, color: Colors.grey),
                      ),
              ],
            ),
            SizedBox(height: 70), // Add some spacing

            // New row with three icons and text below each icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.pin_outlined),
                      onPressed: () {
                        // Navigate to Points page
                      },
                    ),
                    Text(
                      'Points',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(1), // Add shadow
                            offset: Offset(1, 1), // Set shadow offset
                            blurRadius: 0, // Set shadow blur radius
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.card_giftcard),
                      onPressed: () {
                        // Navigate to Coupons page
                      },
                    ),
                    Text(
                      'Coupons',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(1), // Add shadow
                            offset: Offset(0, 1), // Set shadow offset
                            blurRadius: 0, // Set shadow blur radius
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.credit_card),
                      iconSize: 40, // Set the size to 40 (or any desired size)
                      onPressed: () {
                        // Navigate to Ma Carte page
                      },
                    ),
                    Text(
                      'Ma Carte',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(255, 0, 0, 0)
                                .withOpacity(1), // Add shadow
                            offset: Offset(0, 1), // Set shadow offset
                            blurRadius: 0, // Set shadow blur radius
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 200),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackPage(
                                    token: '',
                                  )),
                        );
                        // navigate to feedbackpage
                      },
                      child: Text(
                        'Donnez votre avis',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 63, 196, 36)
                                  .withOpacity(1), // Add shadow
                              offset: Offset(1, 2), // Set shadow offset
                              blurRadius: 5, // Set shadow blur radius
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to History page
                      },
                      child: Text(
                        'Historique',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 63, 196, 36)
                                  .withOpacity(1),
                              // Add shadow
                              offset: Offset(1, 2),
                              // Set shadow offset
                              blurRadius: 5,
                              // Set shadow blur radius
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to History page
                      },
                      child: Text(
                        'Support',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(255, 63, 196, 36)
                                  .withOpacity(1), // Add shadow
                              offset: Offset(1, 2), // Set shadow offset
                              blurRadius: 5, // Set shadow blur radius
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
