import 'dart:convert';

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
  static Artist _pruebaArtista1 = Artist(
    name: 'Eminem',
    numAlbums: 10,
    totalTracks: 45,
    photoUrl: 'https://corazonurbano.com/wp-content/uploads/2020/01/eminem-fotografia-1024x683.jpg'
  );
  static Artist _pruebaArtista2 = Artist(
      name: 'Travis Scott',
      numAlbums: 4,
      totalTracks: 123,
      photoUrl: 'https://images.squarespace-cdn.com/content/v1/59e612b318b27d015329f16f/1571257176088-D'
          '09BX0YYL8CYTU5D7K7J/ke17ZwdGBToddI8pDm48kGXuwhHa7x8Jn1cmn2xeUmRZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExg'
          'lNqGp0IvTJZamWLI2zvYWH8K3-s_4yszcp2ryTI0HqTOaaUohrI8PIeX4uU_ElXq2yJfDTRwNR32wzBeyDl5KNsu--KqOTN'
          '60KMshLAGzx4R3EDFOm1kBS/travis-scott-knee-injury-surgery.jpg'
  );
  var _listArtist = [
    _pruebaArtista1,
    _pruebaArtista2,
    _pruebaArtista1,
    _pruebaArtista2,
    _pruebaArtista1,
    _pruebaArtista2,
    _pruebaArtista1,
    _pruebaArtista2,
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            _listArtist
                .map((el) => ArtistCardWidget(
              artista: el,
            ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
