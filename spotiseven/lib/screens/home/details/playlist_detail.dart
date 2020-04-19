import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/generic_components/GenericCardWidget.dart';
import 'package:spotiseven/screens/playlist/playlist_screen.dart';
import 'package:spotiseven/usefullMethods.dart';

class PlaylistCardWidget extends StatelessWidget {
  final Playlist playlist;

  PlaylistCardWidget({this.playlist});

  @override
  Widget build(BuildContext context) {
    /*List<Widget> lista_text =
        generateStrings().map((Widget s) => Text(s)).toList();*/
    // TODO: Añadir imagen de playlist
    return GenericCardWidget(
      imageUrl:
//          'https://antitrustlair.files.wordpress.com/2012/09/work-in-progress.png',
      '${playlist.photoUrl}',
      args: generateStrings(),
      onPressedFunction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistScreen(playlist: playlist,))),
    );
  }

  List<Widget> generateStrings() {
    // TODO: Falta el usuario en la playlist
    return [
      UsefulMethods.text(playlist.title, 13.0, 0.0, 255, 255, 255, 1.0),
      UsefulMethods.text(playlist.user, 12.0, 0.0, 255, 255, 255, 1.0),
      UsefulMethods.text('${playlist.num_songs} songs', 10.0, 0.0, 255, 255, 255, 1.0),
    ];
  }
}
