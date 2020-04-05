import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
// Clase Playlist
import 'package:spotiseven/audio/utils/playlist.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';
// Fuentes de Google
import 'package:google_fonts/google_fonts.dart';

class PlaylistScreenOptions extends StatelessWidget {
  final Playlist playlist;

  PlaylistScreenOptions({this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment(0, -0.6),
//            stops: [0.05, 0.30, 0.7, 0.9, 0.95, 1],
//            colors: [
//              Colors.black,
//              Colors.grey[900],
//              Colors.grey[800],
//              Colors.grey[600],
//              Colors.grey[400],
//              Colors.white
//            ], // whitish to gray
            colors: [Colors.grey[900], Colors.grey[500]],
            tileMode: TileMode.clamp, // repeats the gradient over the canvas
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              // Propiedades sliverappbar
              floating: false,
              snap: false,
              pinned: true,
              // Efectos
              stretch: true,
              onStretchTrigger: () => Future.delayed(
                  Duration(microseconds: 1), () => print('stretch')),
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                // Efectos
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                title: SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '${playlist.title}',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 25,
                          letterSpacing: 3,
                          wordSpacing: 3,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
                background: Image.network(
                  '${playlist.photoUrl}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 80,),
                _buildFlatButton('SHARE', () => print('SHARE')),
                _buildFlatButton('FOLLOW', () => print('FOLLOW')),
                _buildFlatButton('ORDER BY DATE', () => print('ORDER BY DATE')),
                _buildFlatButton(
                    'ORDER BY ARTIST', () {
                      print('ORDER BY ARTIST');
                      playlist.playlist.sort((Song s1, Song s2) => s1.album.artista.name.compareTo(s2.album.artista.name));
                    }),
                _buildFlatButton(
                    'ALPHABETICAL ORDER', () {
                      print('ALPHABETICAL ORDER');
                      playlist.playlist.sort((Song s1, Song s2) => s1.title.compareTo(s2.title));
                }),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlatButton(String text, Function f) {
    return FlatButton(
      onPressed: f,
      child: Center(
          child: Text(
        text,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          fontSize: 30,
          color: Colors.white,
        ),
      ),),
    );
  }
}
