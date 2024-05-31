import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services library

import 'package:hayya_traya7/home.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Msakenclub extends StatefulWidget {
  @override
  _Msakenclub createState() => _Msakenclub();
}

class _Msakenclub extends State<Msakenclub> {
  final videoURL = "https://www.youtube.com/watch?v=C6mHFaWEIxc";
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoURL)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
        disableDragSeek: false,
        hideControls: false,
        enableCaption: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.4),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  // Navigate back to the previous page
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/blackgreen.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 254, 254).withOpacity(0),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 90), // Espace au-dessus du texte
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " M'SKAEN TENNIS CLUB ",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 24, 87, 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 20,
                        color: Color.fromARGB(255, 39, 139, 19),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Tél: 73 312 700",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 39, 139, 19),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align children to the top
                    children: [
                      Icon(
                        Icons.home,
                        size: 30,
                        color: Color.fromARGB(255, 39, 139, 19),
                      ),
                      SizedBox(
                        width: 10,
                      ), // Add some space between the icon and the text
                      Expanded(
                        child: Text(
                          "Adresse: Msaken Tennis Club, Rue Al Ons derrière la salle couverte, Msaken, 4070",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 39, 139, 19),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20), // Espace entre le texte et la vidéo
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0),
                    ),
                    child: YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        onReady: () => debugPrint('ready'),
                      ),
                      builder: (context, player) {
                        return Column(
                          children: [
                            player,
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
