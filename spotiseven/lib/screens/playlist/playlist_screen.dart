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
//      appBar: AppBar(
//        elevation: 0,
//        centerTitle: true,
//        // TODO: Change this color
//        backgroundColor: Color(0xff9ad1e5),
//        title: Text('${playlist.title}'),
//      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Container(
                padding: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://image.shutterstock.com/image-photo/serious-computer-hacker-dark-clothing-600w-1557297230.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${playlist.title}',
                      style: TextStyle(
                        // TODO: Poner la fuentes
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 80,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(border_radius),
                      topRight: Radius.circular(border_radius)),
                  color: Color(0xff9ad1e5),
                ),
                child: ListView.builder(
                  itemCount: playlist.playlist.length,
                  itemBuilder: (context, index) {
                    return buildSongPreview(playlist.playlist[index], playlist);
                  },
                ),
              ),
            ),
          ],
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
