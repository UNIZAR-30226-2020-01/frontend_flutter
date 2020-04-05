import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/artistDAO.dart';
import 'package:spotiseven/screens/home/details/artist_detail.dart';
import 'package:spotiseven/audio/utils/artist.dart';

class ArtistScreen extends StatefulWidget {
  @override
  _ArtistScreenState createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {

  // Lista de artistas
  var _listArtist = [];

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    ArtistDAO.getAllArtist()
        .then((List<Artist> list) => setState(() => _listArtist = list));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_listArtist.isNotEmpty) {
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
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
