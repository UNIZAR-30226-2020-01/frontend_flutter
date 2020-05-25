import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  ScrollController _scrollController;

  int items = 4;
  int offset = 0;

  bool fetching = false;

  @override
  void initState() {
    _listAlbum = List();
    _subscription = AlbumDAO.pagedAlbum(8, 0).asStream().listen((List<Album> list) {
      setState(() {
        _listAlbum = list;
        offset = offset + 8;
        return _listAlbum;
      });
    });
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_listAlbum.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
            if (sn is ScrollEndNotification &&
                sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent &&
                !fetching) {
              fetching = true;
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  'loading more items',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                duration: Duration(milliseconds: 200),
                backgroundColor: Colors.black,
              ));
              AlbumDAO.pagedAlbum(items, offset).then((List<Album> list) {
                if (list.length > 0) {
                  setState(() {
                    print('fetching more items');
                    _listAlbum.addAll(list);
                    offset = offset + items;
                    fetching = false;
                  });
                }
              });
            }
            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
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
          ));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
