import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hayya_traya7/config.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TerreresPage extends StatefulWidget {
  final String bearerToken;

  TerreresPage({required this.bearerToken});

  @override
  _TerreresPageState createState() => _TerreresPageState();
}

class _TerreresPageState extends State<TerreresPage> {
  String? selectedTerrainType;
  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;
  List<String> terrainTypes = ["Gazon", "Terre Battue", "Dure"];
  Map<String, String> terrainImages = {
    "Gazon": "assets/images/surffacegazon.jpg",
    "Terre Battue": "assets/images/surfaceterrebattue.jpg",
    "Dure": "assets/images/surffacedure.jpg",
  };
  Map<String, String> terrainDescriptions = {
    "Gazon": "Tarifs:\nTerrain:30DT/1Hr\nRaquette:5DT  3Balles:1DT\n ",
    "Terre Battue": "Tarifs:\nTerrain:20DT/1Hr\nRaquette:5DT  3Balles:1DT\n ",
    "Dure": "Tarifs:\nTerrain:30DT/1Hr\nRaquette:5DT  3Balles:1DT\n ",
  };
  String? userId;
  String? status = '';
  String? selectedUserId;

  Color _getTerrainColor(String terrainType) {
    switch (terrainType) {
      case 'Gazon':
        return Colors.green;
      case 'Dure':
        return Colors.lightBlue;
      case 'Terre Battue':
        return Colors.orange;
      default:
        return Colors.white; // Default color
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? brearToken = prefs.getString('token');
    print('Jeton : $brearToken');
    if (brearToken != null && brearToken.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('${defaultBaseUrls}api/users/details'),
          headers: {'Authorization': 'Bearer $brearToken'},
        );

        if (response.statusCode == 200) {
          final userData = jsonDecode(response.body)['user'];
          final userId = userData['_id']; // Retrieve the user ID
          setState(() {
            selectedUserId = userId;
          });
        } else {
          throw Exception('Failed to fetch user data');
        }
      } catch (error) {
        print('Error fetching user data: $error');
        // Handle the error appropriately (e.g., show an error message to the user)
      }
    }
  }

  Future<void> _makeReservation() async {
    if (selectedStartDateTime == null || selectedEndDateTime == null) {
      setState(() {
        status = 'Please select both start and end times.';
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select both start and end times.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      var response = await http.post(
        Uri.parse('${defaultBaseUrls}api/reservations/create'),
        headers: {
          'Authorization': 'Bearer ${widget.bearerToken}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': selectedUserId,
          'startTime': selectedStartDateTime!.toIso8601String(),
          'endTime': selectedEndDateTime!.toIso8601String(),
          'status': 'pending',
          'terrainType': selectedTerrainType!,
        }),
      );
      if (response.statusCode == 201) {
        setState(() {
          status = 'Reservation successful!';
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Reservation successful!'),
          backgroundColor: Colors.green,
        ));
      } else {
        setState(() {
          status = 'Reservation failed. Please try again later.';
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Reservation failed. Please try again later.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      setState(() {
        status = 'Network error. Please check your internet connection.';
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Network error. Please check your internet connection.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> _selectDateTime(bool isStart) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStart) {
            selectedStartDateTime = pickedDateTime;
          } else {
            selectedEndDateTime = pickedDateTime;
          }
        });
      }
    }
  }

  Widget _buildTerrainCard(String terrainType, String imagePath) {
    return SizedBox(
      height: 150, // Adjust the height as needed
      child: Container(
        width: 250,
        child: Card(
          color: _getTerrainColor(terrainType),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  terrainType,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  terrainDescriptions[terrainType]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 1),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10), // Adjust spacing as needed
            ],
          ),
        ),
      ),
    );
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: terrainTypes.map((terrainType) {
                  return _buildTerrainCard(
                    terrainType,
                    terrainImages[terrainType]!,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200, // Define specific width
              decoration: BoxDecoration(
                color: Colors.grey[200], // Background color
                borderRadius: BorderRadius.circular(
                    8.0), // Optional: Add border radius for rounded corners
              ),
              child: DropdownButton<String>(
                value: selectedTerrainType,
                items: terrainTypes.map((terrainType) {
                  return DropdownMenuItem<String>(
                    value: terrainType,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        terrainType,
                        style: TextStyle(
                          color: _getTerrainColor(terrainType),
                          fontSize: 27, // type terrains size
                          fontWeight: FontWeight.bold, // Make text bold
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTerrainType = value;
                  });
                },
                hint: Text(
                  'Choix du terrain',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), // Text color
                    fontSize: 30, // Font size
                    fontWeight: FontWeight.bold, // Bold font weight
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            if (selectedTerrainType != null) ...[
              Text(
                'Type de terrain sélectionné: $selectedTerrainType',
                style: TextStyle(
                  fontSize: 20, // Font size
                  fontWeight: FontWeight.bold, // Bold font weight
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDateTime(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: Text(
                      'Heure du début',
                      style: TextStyle(
                        fontSize:
                            18, // Ajustez la taille de la police selon vos besoins
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDateTime(false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: Text(
                      'Heure de la fin',
                      style: TextStyle(
                        fontSize:
                            18, // Ajustez la taille de la police selon vos besoins
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (selectedStartDateTime != null)
                Text(
                  'Heure de début sélectionnée: ${DateFormat('yyyy-MM-dd HH:mm').format(selectedStartDateTime!)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              Text(
                'Heure de fin sélectionnée: ${selectedEndDateTime != null ? DateFormat('yyyy-MM-dd HH:mm').format(selectedEndDateTime!) : 'Svp sélectioner'}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 60),
              ElevatedButton(
                onPressed: _makeReservation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: Text(
                  'Réserver',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18, // Adjust font size if needed
                    fontWeight: FontWeight.bold, // Make text bold
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
