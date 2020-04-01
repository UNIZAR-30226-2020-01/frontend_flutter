import 'package:flutter/material.dart';
// Clase Artista
import 'package:spotiseven/audio/utils/artist.dart';
// Fuentes de Google
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/artist.dart';

class ArtistDiscography extends StatelessWidget {
  final Artist artista;


  ArtistDiscography({this.artista});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(34, 34, 34, 1),
    );
  }
}
