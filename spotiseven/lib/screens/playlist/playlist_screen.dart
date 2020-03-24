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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // TODO: Change this color
        backgroundColor: Colors.white,
        title: Text('${playlist.title}'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // TODO: Change this
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:
              playlist.playlist.map((Song s) => buildSongPreview(s, playlist)).toList(),
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
