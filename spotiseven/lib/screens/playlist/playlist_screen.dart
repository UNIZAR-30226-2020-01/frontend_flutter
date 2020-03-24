import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
// Clase Playlist
import 'package:spotiseven/audio/utils/playlist.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

class PlaylistScreen extends StatelessWidget {
  final Playlist playlist;

  PlaylistScreen({this.playlist});

  @override
  Widget build(BuildContext context) {
    final double border_radius = 45;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        // TODO: Change this color
        backgroundColor: Color(0xff9ad1e5),
        title: Text('${playlist.title}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(border_radius),
              topRight: Radius.circular(border_radius)),
          color: Color(0xff9ad1e5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // TODO: Change this
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: playlist.playlist
              .map((Song s) => buildSongPreview(s, playlist))
              .toList(),
        ),
      ),
    );
  }

  Widget buildSongPreview(Song s, Playlist p) {
    return FlatButton(
      onPressed: () async {
        var playingSingleton = PlayingSingleton();
        playingSingleton.setPlayList(p);
        await playingSingleton.play(s);
        print('Reproduciendo ${playingSingleton.song.title}');
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(s.photoUrl),
              radius: 40,
            ),
            SizedBox(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${s.title}'),
                Text('${s.album.artista}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
