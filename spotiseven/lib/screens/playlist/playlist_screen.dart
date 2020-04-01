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

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;

  PlaylistScreen({this.playlist});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  // Control del scroll
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: RefreshIndicator(
              onRefresh: () => Future.delayed(
                  Duration(microseconds: 1), () => print('recargando')),
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    leading: IconButton(
                      onPressed: () => print('Pressed 3 dot button'),
                      icon: Icon(Icons.more_vert),
                      color: Colors.white,
                    ),
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
                              '${widget.playlist.title}',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w300,
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
                        '${widget.playlist.photoUrl}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      // TODO: Esto es para hacer pruebas con listas largas
                      (BuildContext context, int index) {
                        return buildSongPreview_v2(
                            widget.playlist.playlist[
                                index],
                            widget.playlist,
                            context);
                      },
                      childCount: widget.playlist.playlist.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _fabReproduction(),
        ],
      ),
    );
  }

  Widget _fabReproduction() {
    //starting fab position
    final double defaultTopMargin = 270 - 4.0;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;

    if (_scrollController.hasClients) {
      // Modificacion de la altura del boton
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 16,
      child: Transform(
        transform: new Matrix4.identity()..scale(scale),
        child: Container(
          child: RaisedButton(
            onPressed: () => PlayingSingleton()
              ..setPlayList(widget.playlist)
              ..randomize()
              ..play(PlayingSingleton().song),
            child: Text('PLAY', style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            )),
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSongPreview_v2(Song s, Playlist p, BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 15, 30, 15),
      child: GestureDetector(
        onTap:() async {
          var playingSingleton = PlayingSingleton();
          playingSingleton.setPlayList(p);
          await playingSingleton.play(s);
          print('Reproduciendo ${playingSingleton.song.title}');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    s.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.only(left: 30, right: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${s.title}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${s.album.artista}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    color: Colors.white,
                    onPressed: () => print('Presed ${s.title} options'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
