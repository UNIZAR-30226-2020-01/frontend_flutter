import 'package:flutter/material.dart';
// Clase playlist
import 'package:spotiseven/audio/utils/artist.dart';
// GenericCardWidget
import 'package:spotiseven/generic_components/GenericHorizontalWidget.dart';
import 'package:spotiseven/screens/artist/artist_screen.dart';

class ArtistCardWidget extends StatelessWidget {
  final Artist artista;

  ArtistCardWidget({this.artista});

  @override
  Widget build(BuildContext context) {
    List<Widget> lista_text =
    generateStrings().map((String s) => Text(s)).toList();
    // TODO: Añadir imagen de playlist
    return GenericCardWidget(
      imageUrl:
//          'https://antitrustlair.files.wordpress.com/2012/09/work-in-progress.png',
      '${artista.photoUrl}',
      args: lista_text,
      onPressedFunction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ArtistScreen(artista: artista,))),
    );
  }

  List<String> generateStrings() {
    // TODO: Falta el usuario en la playlist
    return [
      '${artista.name}',
      '${artista.numAlbums} albums',
      '•',
      '${artista.totalTracks} tracks'
    ];
  }
}
