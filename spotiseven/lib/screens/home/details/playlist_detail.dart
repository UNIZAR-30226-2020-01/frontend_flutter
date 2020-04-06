import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/generic_components/GenericCardWidget.dart';
import 'package:spotiseven/screens/playlist/playlist_screen.dart';

class PlaylistCardWidget extends StatelessWidget {
  final Playlist playlist;

  PlaylistCardWidget({this.playlist});

  @override
  Widget build(BuildContext context) {
    List<Widget> lista_text =
        generateStrings().map((String s) => Text(s)).toList();
    // TODO: Añadir imagen de playlist
    return GenericCardWidget(
      imageUrl:
//          'https://antitrustlair.files.wordpress.com/2012/09/work-in-progress.png',
      '${playlist.photoUrl}',
      args: lista_text,
      onPressedFunction: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlaylistScreen(playlist: playlist,))),
    );
  }

  List<String> generateStrings() {
    // TODO: Falta el usuario en la playlist
    return [
      '${playlist.title}',
      '${playlist.user}',
      '${playlist.playlist.length} songs'
    ];
  }
}
