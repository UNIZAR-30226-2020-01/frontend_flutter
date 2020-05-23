import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/DAO/playlistDAO.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/album/album_screen_options.dart';
import 'package:spotiseven/screens/playlist/create_playlist.dart';
import 'package:spotiseven/usefullMethods.dart';

class AlbumDetailScreen extends StatefulWidget {
  final Album album;

  AlbumDetailScreen({this.album});

  @override
  _AlbumDetailScreenState createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  // Control del scroll
  ScrollController _scrollController;

  // Para añadir a la playlist
  List<Playlist> _playlists = List();

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    widget.album.fetchRemote().whenComplete(() {
      print('${widget.album.photoUrl}');
      setState(() {});
    });
    PlaylistDAO.getAllPlaylists().then((List<Playlist> playlist) {
      print('listas: ${playlist.length}');
      setState(() {
        _playlists = playlist;
      });
    });
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => widget.album.fetchRemote(),
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.black,
                      leading: IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AlbumScreenOptions(
                                      album: this.widget.album,
                                    ))),
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
                        centerTitle: true,
                        background: Image.network(
                          '${widget.album.photoUrl}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(widget
                              .album.list.isNotEmpty
                          ? widget.album.list
                              .map((Song s) =>
                                  buildSongPreview_v2(s, widget.album, context))
                              .toList()
                          : [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 200, vertical: 50),
                                child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CircularProgressIndicator()),
                              )
                            ]),
                    ),
                  ],
                ),
              ),
              _fabReproduction(),
              _name(),
            ],
          ),
        ),
      ),
    );
  }

  _name() {
    final double defaultTopMargin = 271 - 15.0;
    double top = defaultTopMargin;
    return Positioned(
      top: top,
      left: 10,
      child: Container(
//          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
          padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
          height: MediaQuery.of(context).size.width * 0.085,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child:
              UsefulMethods.text(widget.album.titulo, 25.0, 0.0, 0, 0, 0, 1.0)),
    );
  }

  Widget _fabReproduction() {
    //starting fab position
    final double defaultTopMargin = 271 - 20.0;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(
              onPressed: () => PlayingSingleton()
                ..setPlayList(Playlist(
                    title: widget.album.titulo,
                    photoUrl: widget.album.photoUrl,
                    playlist: widget.album.list))
                ..randomize()
                ..play(PlayingSingleton().song),
              child: UsefulMethods.text('PLAY', 25.0, 0.0, 0, 0, 0, 1.0),
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSongPreview_v2(Song s, Album a, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      margin: EdgeInsets.fromLTRB(30, 15, 30, 15),
      child: GestureDetector(
        onTap: () async {
          var playingSingleton = PlayingSingleton();
          // TODO: Integrar la reproduccion de un album como playlist (poner como lista de canciones las del album)
          playingSingleton.setPlayListWithoutPlaying(Playlist(
              title: widget.album.titulo,
              photoUrl: widget.album.photoUrl,
              playlist: widget.album.list));
          await playingSingleton.play(s);
          print('Reproduciendo ${playingSingleton.song.title}');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
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
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: 1,
              ),
            ),
            Expanded(
              flex: 13,
              child: Container(
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
                          '${s.album.artista.name}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          onPressed: () => setState(() {
                            s.setFavorite(!s.favorite);
                          }),
                          icon: Icon(
                            s.favorite ? Icons.star : Icons.star_border,
                            color: s.favorite ? Colors.yellow : Colors.white,
                          ),
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          color: Colors.white,
                          itemBuilder: (context) => <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'add_next',
                              child: Text('Play Next'),
                            ),
                            PopupMenuItem<String>(
                              value: 'add_to_playlist',
                              child: Text('Add to playlist'),
                            ),
                          ],
                          onSelected: (String value) async {
                            switch (value) {
                              case 'add_next':
                                PlayingSingleton().addSongNext(s);
                                break;
                              case 'add_to_playlist':
                                print('Añadiendo a playlist');
                                String opt = await showDialog<String>(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Select Playlist to add'),
                                        elevation: 0,
                                        actions: [
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context, 'new');
                                                },
                                                child: Text(
                                                  'New Playlist',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )
                                            ] +
                                            _playlists
                                                .map((Playlist pl) =>
                                                    _createPlaylistFlatButton(
                                                        context, pl, s))
                                                .toList(),
                                      );
                                    });
                                print('$opt');
                                if (opt == 'new') {
                                  Playlist nueva = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreatePlaylistScreen()));
                                  if (nueva != null) {
                                    // TODO: Cambiar esto para que nueva tenga url
                                    PlaylistDAO.addSongToPlaylist(nueva, s);
                                  }
                                }
                                break;
                              default:
                                print('No action?');
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlatButton _createPlaylistFlatButton(
      BuildContext context, Playlist pl, Song s) {
    return FlatButton(
      onPressed: () {
        print('Añadir cancion ${s.title} a playlist ${pl.title}');
        PlaylistDAO.addSongToPlaylist(pl, s);
        Navigator.pop(context, 'not_new');
      },
      child: Text(
        '${pl.title}',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
