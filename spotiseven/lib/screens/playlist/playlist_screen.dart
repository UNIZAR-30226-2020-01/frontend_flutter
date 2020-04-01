import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
// Clase Playlist
import 'package:spotiseven/audio/utils/playlist.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';
// Fuentes de Google
import 'package:google_fonts/google_fonts.dart';

class PlaylistScreen extends StatelessWidget {
  final Playlist playlist;

  PlaylistScreen({this.playlist});

  @override
  Widget build(BuildContext context) {
    final double border_radius = 45;
    // Version alternativa dinamica
    return Container(
      color: Color(0xff9ad1e5),
      child: RefreshIndicator(
        onRefresh: () => Future.delayed(
            Duration(microseconds: 1), () => print('recargando')),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.cyan,
              elevation: 0,
              floating: true,
              snap: false,
              pinned: false,
              // Efectos
              stretch: true,
              onStretchTrigger: () => Future.delayed(
                  Duration(microseconds: 1), () => print('stretch')),
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                // Efectos
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                title: Text(
                  '${playlist.title}',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: 25,
                    letterSpacing: 3,
                    wordSpacing: 3,
                  ),
                ),
                centerTitle: true,
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      '${playlist.photoUrl}',
                      fit: BoxFit.cover,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.0, 0.5),
                          end: Alignment(0.0, 0.0),
                          colors: <Color>[
                            Color(0x60000000),
                            Color(0x00000000),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  // TODO: Aplicar estilo
                  child: RaisedButton(
                    onPressed: () => PlayingSingleton()
                      ..setPlayList(playlist)
                      ..randomize()
                      ..play(playlist.playlist[
                          Random().nextInt(playlist.playlist.length)]),
                    child: Text('PLAY RANDOM'),
                  ),
                )
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return buildSongPreview(playlist.playlist[index], playlist);
                },
                childCount: playlist.playlist.length,
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

  Widget buildSongPreviewTambo(Song s, Playlist p) {
    return Column(
      children: <Widget>[
        FlatButton(
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
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(s.photoUrl),
                    ),
                  ),
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
        ),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.grey[750],
              thickness: 1.5,
            )),
      ],
    );
  }
}
