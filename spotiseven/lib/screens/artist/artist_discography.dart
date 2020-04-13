import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:spotiseven/audio/utils/album.dart';
// Clase Artista
import 'package:spotiseven/audio/utils/artist.dart';
// Fuentes de Google
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/screens/artist/artist_info.dart';

import 'package:spotiseven/generic_components/GenericHorizontalWidget.dart';
import 'package:spotiseven/screens/album/album_screen.dart';

class ArtistDiscography extends StatefulWidget {
  final Artist artista;

  ArtistDiscography({this.artista});

  @override
  _ArtistDiscographyState createState() => _ArtistDiscographyState();
}

class _ArtistDiscographyState extends State<ArtistDiscography> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    if (widget.artista.albums.isEmpty) {
      widget.artista.fetchRemote().whenComplete(() => setState(() {}));
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _text(context, id, size, r, g, b, op) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        id,
        textAlign: TextAlign.end,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          fontSize: size,
          letterSpacing: 8,
          wordSpacing: 2,
          color: Color.fromRGBO(r, g, b, op),
        ),
      ),
    );
  }

  _image(context, url) {
    return Image(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      image: NetworkImage(url),
    );
  }

  _border() {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.white,
    );
  }

  _borderBlack() {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: Colors.black,
    );
  }

  _imageContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: _image(context, widget.artista.photoUrl),
      ),
    );
  }

  _textContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: _border(),
      //color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: AutoSizeText(
                  widget.artista.name,
                  maxLines: 2,
//                maxFontSize: 300,
                  minFontSize: 19,
                  wrapWords: true,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 8,
                    wordSpacing: 2,
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                  ),
                ),
                //_text(context, '${widget.artista.name} asdas', 15.0, 0, 0, 0, 1.0),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: IconButton(
                  onPressed: () {
                    print('presionado boton info del artista');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ArtistInfo(artista: widget.artista)));
                  },
                  icon: Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: _text(context, '${widget.artista.numAlbums} Albums', 15.0, 0,
                0, 0, 1.0),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: _text(context, '${widget.artista.totalTracks} Tracks', 15.0,
                0, 0, 0, 1.0),
          ),
          _text(context, '${widget.artista.name}', 25.0, 0, 0, 0, 1.0),
          IconButton(
            onPressed: () {
              print('presionado boton info del artista');
            },
            icon: Icon(
              Icons.info,
              color: Colors.black,
            ),
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  _botonFollow() {
    return FlatButton(
      child: Container(
        height: 30,
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//        margin: EdgeInsets.all(),
        decoration: _borderBlack(),
        child: _text(context, '+FOLLOW', 20.0, 255, 255, 255, 1.0),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  _appBar(context) {
    return SliverAppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Propiedades sliverappbar
        floating: true,
        snap: true,
        pinned: true,
        // Efectos
        leading: SizedBox(),
        stretch: true,
        onStretchTrigger: () =>
            Future.delayed(Duration(microseconds: 1), () => print('stretch')),
        expandedHeight: 300,
        flexibleSpace: FlexibleSpaceBar(
          stretchModes: [
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          background: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _imageContainer(),
                    _textContainer(),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: _text(context, 'ALBUMS', 15.0, 0, 0, 0, 1.0),
                      ),
                      _botonFollow(),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  indent: 20,
                  endIndent: 20,
                  thickness: 4.0,
                ),
              ],
            ),
          ),
        ));
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
                  _appBar(context),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      widget.artista.albums
                          .map((Album album) => GenericHorizontalWidget(
                                args: [
                                  '${album.titulo}',
                                  '${album.numberSongs} songs',
                                  'p2'
                                ],
                                imageUrl: album.photoUrl,
                                onPressedFunction: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AlbumDetailScreen(
                                              album: album,
                                            ))),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
