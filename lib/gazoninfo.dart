import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import services library
import 'package:hayya_traya7/gazonstade.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Gazoninfo extends StatefulWidget {
  @override
  _GazoninfoState createState() => _GazoninfoState();
}

class _GazoninfoState extends State<Gazoninfo> {
  final videoURL = "https://www.youtube.com/watch?v=CXcMlRWlLt0";
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
                image: AssetImage('assets/images/troisstade.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10), // Espace au-dessus du texte
                  Text(
                    "Découvrez les trois types de terrains de tennis avec cette vidéo.",
                    textAlign: TextAlign.center, // Aligner le texte au centre
                    style: TextStyle(
                      fontSize: 25, // Taille de la police
                      fontWeight: FontWeight.bold, // Police en gras
                      color: Color.fromARGB(
                          255, 255, 252, 252), // Couleur du texte
                    ),
                  ),
                  SizedBox(height: 20), // Espace entre le texte et la vidéo
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3.0),
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
