import 'dart:async';
import 'package:flutter/material.dart';
import 'signin.dart'; // Ensure this path is correct
import 'login.dart'; // Ensure this path is correct

class RejoindrePage extends StatefulWidget {
  @override
  _RejoindrePageState createState() => _RejoindrePageState();
}

class _RejoindrePageState extends State<RejoindrePage> {
  final PageController _pageController = PageController();
  final List<String> _imageUrls = [
    'assets/images/teamhayya.jpg',
    'assets/images/eventcup.png', // Replace with your image URLs
    'assets/images/playertenis.png',
    'assets/images/homepage.jpg',
  ];

  int _currentPage = 0;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _imageUrls.length - 1) {
        setState(() {
          _currentPage++;
        });
      } else {
        setState(() {
          _currentPage = 0;
        });
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Bienvenue!',
                style: TextStyle(
                  fontSize: 35,
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
              SizedBox(height: 20),
              Text(
                'Le tennis est un sport fantastique qui améliore votre condition physique et mentale. Rejoignez notre club pour profiter de nombreux avantages et pour faire partie de notre communauté passionnée de tennis.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold, // Set the font weight to bold
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                child: Text(
                  _expanded ? 'Voir moins' : 'Voir plus',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 123, 0),
                    decoration: TextDecoration.underline, // Add underline
                    decorationColor:
                        Color.fromARGB(255, 255, 123, 0), // Add underline color
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                ),
              ),
              SizedBox(height: 90),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                height: _expanded ? 300 : 0,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _imageUrls.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      _imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Image.asset(
                    'assets/images/LOGO.png',
                    width: 250,
                    height: 250,
                  ),
                ],
              ),
              SizedBox(height: 02),
              Text(
                'hayya traya7 est une application qui vous aide à participer et à explorer le monde du tennis.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 300, // Set the width to fill the available space
                height: 40, // Set the height as desired
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  icon: Icon(Icons.person_add, color: Colors.white),
                  label: Text(
                    'Créer un Compte',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 300, // Set the width to fill the available space
                height: 40, // Set the height as desired
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  icon: Icon(Icons.login, color: Colors.white),
                  label: Text(
                    'Se Connecter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
