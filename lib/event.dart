import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hayya_traya7/config.dart';
import 'package:http/http.dart' as http;

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<dynamic> events = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final response = await http.get(
        Uri.parse('${defaultBaseUrls}api/events/all'),
      );

      print('Event fetch status: ${response.statusCode}');
      print('Event fetch response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> responseData = data['data'];
        setState(() {
          events = responseData;
        });
      } else {
        print(
            'Failed to fetch event data: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to fetch event data');
      }
    } catch (error) {
      print('Error fetching event data: $error');
      // Handle error gracefully (e.g., show error message to the user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              'Événements',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [
                  Shadow(
                    color: Color.fromARGB(255, 255, 132, 0)
                        .withOpacity(1), // Add shadow
                    offset: Offset(1, 2), // Set shadow offset
                    blurRadius: 5, // Set shadow blur radius
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          if (events.isEmpty)
            Center(child: CircularProgressIndicator())
          else
            ..._buildEventCards(),
          Card(
            color: Color.fromARGB(255, 65, 220, 27),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Si vous voulez participer à un événement, appelez l\'agent du stade',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.call,
                        size: 40, // Adjust the size as desired
                      ),
                      SizedBox(width: 10),
                      Text(
                        ' : 55563355',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildEventCards() {
    return events.map((event) {
      return SizedBox(
        height: 200, // Adjust the height as desired
        child: Card(
          color: const Color.fromARGB(255, 255, 153, 0),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    event['title'],
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
                Text(
                  'Start Time: ${event['startTime']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 30, 29, 29),
                  ),
                ),
                Text(
                  'End Time: ${event['endTime']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 30, 29, 29),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Description: ${event['description']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 30, 29, 29),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
