import 'package:flutter/material.dart';
import 'package:spotiseven/screens/home/details/artist_detail.dart';
import 'package:spotiseven/audio/utils/artist.dart';

class ArtistScreen extends StatefulWidget {
  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  // TODO: Quitar. Es para hacer pruebas
  static Artist _pruebaArtista = Artist(

  );
  var _listArtist = [
    _pruebaArtista,
    _pruebaArtista,
    _pruebaArtista,
    _pruebaArtista,
    _pruebaArtista,
    _pruebaArtista,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverGrid.count(
          crossAxisCount: 2,
          children: _listArtist
              .map((el) => ArtistCardWidget(
            artista: el,
          ))
              .toList(),
        ),
      ],
    );
  }
}
