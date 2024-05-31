import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hayya_traya7/config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReservationResponsePage extends StatefulWidget {
  final String bearerToken;

  ReservationResponsePage({required this.bearerToken});

  @override
  _ReservationResponsePageState createState() =>
      _ReservationResponsePageState();
}

class _ReservationResponsePageState extends State<ReservationResponsePage> {
  List<dynamic> reservations = [];
  String? userId;
  String? selectedUserId;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bearerToken = prefs.getString('token') ?? '';
    print('Token : $bearerToken');
    if (bearerToken.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('${defaultBaseUrls}api/users/details'),
          headers: {'Authorization': 'Bearer $bearerToken'},
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body)['user'];
          final userId = userData['_id']; // Fetching user ID
          setState(() {
            selectedUserId = userId;
          });
          _fetchReservations(
              userId); // Fetch reservations after getting user ID
        } else {
          print(
              'Failed to fetch user data: ${response.statusCode} - ${response.body}');
          throw Exception('Failed to fetch user data');
        }
      } catch (error) {
        print('Error fetching user data: $error');
        // Handle error gracefully (e.g., show error message to the user)
      }
    }
  }

  Future<void> _fetchReservations(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('${defaultBaseUrls}api/reservations/getrespond/$userId'),
        headers: {'Authorization': 'Bearer ${widget.bearerToken}'},
      );

      print('Reservation fetch status: ${response.statusCode}');
      print('Reservation fetch response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> responseData = data['data'];
        setState(() {
          reservations = responseData;
        });
      } else {
        print(
            'Failed to fetch reservation data: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to fetch reservation data');
      }
    } catch (error) {
      print('Error fetching reservation data: $error');
      // Handle error gracefully (e.g., show error message to the user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Mes réservations',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 111, 255, 22).withOpacity(1),
                      offset: Offset(1, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          if (reservations.isEmpty) Center(child: CircularProgressIndicator()),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.6, // Adjust the height as needed
              child: ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Color.fromARGB(255, 255, 153, 0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Center(
                        child: Text(
                          'Reservation ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Color.fromARGB(243, 255, 255, 255),
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(3, 3),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status: ${reservation['status']}',
                            style: TextStyle(
                              fontSize: 22,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Date de début: ${reservation['startTime']}',
                            style: TextStyle(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Date de fin: ${reservation['endTime']}',
                            style: TextStyle(
                              fontSize: 18,
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
