import 'dart:async';

import 'package:flutter/material.dart';
// Class Album
import 'package:spotiseven/audio/utils/album.dart';
// Class AlbumDAO
import 'package:spotiseven/audio/utils/albumDAO.dart';
// Class AlbumCardWidget
import 'package:spotiseven/screens/home/details/album_detail.dart';

class AlbumScreen extends StatefulWidget {

  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  List<Album> _listAlbum;

  // Suscription to avoid exception of setstate
  StreamSubscription _subscription;

  @override
  void initState() {
    _listAlbum = List();
    _subscription = AlbumDAO.getAllAlbums().asStream().listen((List<Album> list) => setState(() => _listAlbum = list));
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_listAlbum.isNotEmpty){
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
    }else{
      return Center(child: CircularProgressIndicator(),);
    }
  }
}