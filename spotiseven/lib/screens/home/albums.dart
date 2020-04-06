import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/DAO/albumDAO.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/screens/home/details/album_detail.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  // Lista de albumes que aparecen
  List<Album> _listAlbum;

  // Suscription to avoid exception of setstate
  StreamSubscription _subscription;

  @override
  void initState() {
    _listAlbum = List();
    _subscription = AlbumDAO.getAllAlbums()
        .asStream()
        .listen((List<Album> list) => setState(() => _listAlbum = list));
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_listAlbum.isNotEmpty) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverGrid.count(
            crossAxisCount: 2,
            children: _listAlbum
                .map((el) => AlbumCardWidget(
                      album: el,
                    ))
                .toList(),
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
