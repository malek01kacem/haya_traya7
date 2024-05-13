import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayya_traya7/Profile.dart';
import 'package:hayya_traya7/durestade.dart';
import 'package:hayya_traya7/gazonstade.dart';
import 'package:hayya_traya7/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hayya_traya7/Profile.dart';
import 'package:hayya_traya7/terrebattue.dart';
import 'package:hayya_traya7/msakenclub.dart';

class stade {
  final String imageURL;
  final String category;
  final String stadeName;
  final double price;
  bool isFavorated;
  final Widget page; // Page to navigate to for each stade

  stade({
    required this.imageURL,
    required this.category,
    required this.stadeName,
    required this.price,
    this.isFavorated = false,
    required this.page,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<stade> _stadeList = [
    stade(
      imageURL: 'assets/images/surfaceterrebattue.jpg',
      category: 'Terre',
      stadeName: 'la terre battue',
      price: 20.0,
      page: TerreBattuePage(), // Specify the page for each stade
    ),
    stade(
      imageURL: 'assets/images/surffacedure.jpg',
      category: 'Dure',
      stadeName: 'le stade dure',
      price: 15.0,
      page: durestadePage(), // Specify the page for each stade
    ),
    stade(
      imageURL: 'assets/images/surffacegazon.jpg',
      category: 'Gazon',
      stadeName: 'le stade gazon',
      price: 30.0,
      page: gazonstadePage(), // Specify the page for each stade
    ),
  ];

  List<String> _stadeTypes = [
    'Terre',
    'Dure',
    'Gazon',
  ];

  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // Navigate to the login page
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 254, 251), // Light orange color
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 120,
                  bottom: 20,
                ),
                child: const Text(
                  'Nos stades',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
              GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 220,
                ),
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to the first page when the first card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => msakenclub()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.0),
                        bottom: Radius.circular(30.0),
                      ),
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: 200,
                              color: Color.fromARGB(255, 238, 236, 236),
                              child: Image.asset(
                                'assets/images/msclub.png',
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  9), // Add padding of 10 pixels on all sides
                              child: Text(
                                "Historique",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      17, // Change the font size as needed
                                ),
                                textAlign: TextAlign
                                    .center, // Align the text in the center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the second page when the second card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => msakenclub()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.0),
                        bottom: Radius.circular(30.0),
                      ),
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: 200,
                              color: Color.fromARGB(255, 238, 236, 236),
                              child: Image.asset(
                                'assets/images/msclub.png',
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  9), // Add padding of 10 pixels on all sides
                              child: Text(
                                "Notre Club",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      17, // Change the font size as needed
                                ),
                                textAlign: TextAlign
                                    .center, // Align the text in the center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the third page when the third card is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => msakenclub()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.0),
                        bottom: Radius.circular(30.0),
                      ),
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: 200,
                              color: Color.fromARGB(255, 238, 236, 236),
                              child: Image.asset(
                                'assets/images/msclub.png',
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  9), // Add padding of 10 pixels on all sides
                              child: Text(
                                "Nous rejoindre",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      16, // Change the font size as needed
                                ),
                                textAlign: TextAlign
                                    .center, // Align the text in the center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 120, bottom: 10, top: 10),
                child: const Text(
                  'Nos stades',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .4,
                child: ListView.builder(
                  itemCount: _stadeList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to detail page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => _stadeList[index].page),
                        );
                      },
                      child: Container(
                        width: 250,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            children: [
                              Image.asset(
                                _stadeList[index].imageURL,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Positioned(
                                top: 10,
                                right: 20,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        bool isFavorited = toggleIsFavorated(
                                          _stadeList[index].isFavorated,
                                        );
                                        _stadeList[index].isFavorated =
                                            isFavorited;
                                      });
                                    },
                                    icon: Icon(
                                      _stadeList[index].isFavorated
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.red,
                                    ),
                                    iconSize: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _stadeList[index].category,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration
                                            .none, // Pour supprimer tout soulignement du texte
                                        shadows: [
                                          Shadow(
                                            color: Colors
                                                .black, // Couleur de la bordure
                                            blurRadius: 3, // Rayon du flou
                                            offset: Offset(1,
                                                3), // Décalage horizontal et vertical de l'ombre
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      _stadeList[index].stadeName,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration
                                            .none, // Pour supprimer tout soulignement du texte
                                        shadows: [
                                          Shadow(
                                            color: Colors
                                                .black, // Couleur de la bordure
                                            blurRadius: 10,
                                            offset: Offset(1, 0),

                                            /// Rayon du flou
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${_stadeList[index].price.toString()}DT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(255, 11, 11, 11),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            const Color.fromARGB(255, 235, 179, 96), // Light orange color
        unselectedItemColor: const Color.fromARGB(
            255, 236, 142, 3), // Lighter orange color for unselected items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor:
            Color.fromARGB(255, 8, 42, 14), // Adjust color as needed
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          // Navigate to profile.dart
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                        token: '',
                      )), // Assuming ProfilePage is your profile.dart file
            );
          }
        },
      ),
    );
  }
}

class stadeWidget extends StatelessWidget {
  final int index;
  final List<stade> stadeList;

  const stadeWidget({
    Key? key,
    required this.index,
    required this.stadeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              stadeList[index].imageURL,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
            title: Text(stadeList[index].stadeName),
            subtitle: Text('\$${stadeList[index].price}'),
            trailing: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                // Toggle favorite status
              },
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Navigate to the page specified for this stade
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => stadeList[index].page),
              );
            },
            child: Text('Go to ${stadeList[index].stadeName} Page'),
          ),
        ],
      ),
    );
  }
}
