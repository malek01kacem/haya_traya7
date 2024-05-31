import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hayya_traya7/durestadevisi.dart';
import 'package:hayya_traya7/event.dart';
import 'package:hayya_traya7/gazonstadevisi.dart';
import 'package:hayya_traya7/login.dart';
import 'package:hayya_traya7/rejoindre.dart';
import 'package:hayya_traya7/msakenclub.dart';
import 'package:hayya_traya7/signin.dart';
import 'package:hayya_traya7/terrebattuevisi.dart';

class stade {
  final String imageURL;
  final String category;
  final String stadeName;
  final double price;
  bool isFavorated;
  final Widget page;

  stade({
    required this.imageURL,
    required this.category,
    required this.stadeName,
    required this.price,
    this.isFavorated = false,
    required this.page,
  });
}

class Visiteur extends StatefulWidget {
  const Visiteur({Key? key}) : super(key: key);

  @override
  State<Visiteur> createState() => _VisiteurState();
}

class _VisiteurState extends State<Visiteur> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<stade> _stadeList = [
    stade(
      imageURL: 'assets/images/surfaceterrebattue.jpg',
      category: 'Terre',
      stadeName: 'la terre battue',
      price: 20.0,
      page: TerreBattuevisiPage(),
    ),
    stade(
      imageURL: 'assets/images/surffacedure.jpg',
      category: 'Dure',
      stadeName: 'le stade dure',
      price: 15.0,
      page: durestadevisiPage(),
    ),
    stade(
      imageURL: 'assets/images/surffacegazon.jpg',
      category: 'Gazon',
      stadeName: 'le stade gazon',
      price: 30.0,
      page: gazonstadevisiPage(),
    ),
  ];

  bool toggleIsFavorated(bool isFavorited) {
    return !isFavorited;
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 252, 251),
        actions: [],
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 254, 251),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.login, color: Colors.orange, size: 30),
                          SizedBox(width: 10),
                          Text(
                            'Se Connecter',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person_add,
                              color: Colors.orange, size: 30),
                          SizedBox(width: 10),
                          Text(
                            'Créer un compte',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventPage()),
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
                              width: 300,
                              color: Color.fromARGB(255, 238, 236, 236),
                              child: Image.asset(
                                'assets/images/event.png',
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(9),
                              child: Text(
                                "Événements",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Msakenclub()),
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
                              padding: EdgeInsets.all(9),
                              child: Text(
                                "Notre Club",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RejoindrePage(),
                        ),
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
                              padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                              width: 200,
                              color: Color.fromARGB(255, 238, 236, 236),
                              child: Image.asset(
                                'assets/images/rejoindre.png',
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(9),
                              child: Text(
                                "Haya Traya7",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Terrains',
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          Shadow(
                            color:
                                Color.fromARGB(255, 254, 95, 67).withOpacity(1),
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
                ),
              ),
              Container(
                height: 10,
              ),
              SizedBox(
                height: 380,
                child: ListView.builder(
                  itemCount: _stadeList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _stadeList[index].page,
                          ),
                        );
                      },
                      child: Container(
                        width: 300,
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
                                        decoration: TextDecoration.none,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            blurRadius: 3,
                                            offset: Offset(1, 3),
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
                                        decoration: TextDecoration.none,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black,
                                            blurRadius: 10,
                                            offset: Offset(1, 0),
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
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 120, bottom: 10, top: 10),
                child: Text(
                  'GALERIE',
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
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height:
                    350, // This height can be adjusted based on your layout requirements
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      [
                        'assets/images/msclub.png',
                        'assets/images/LOGO.png',
                        'assets/images/homepage.jpg'
                      ][index],
                      fit: BoxFit.cover,
                      width: 300, // Adjust the width as desired
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
