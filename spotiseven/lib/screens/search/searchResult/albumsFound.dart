import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/albumDAO.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/screens/home/details/album_detail.dart';
import 'package:spotiseven/usefullMethods.dart';

class AlbumsFound extends StatefulWidget {

  String word;
  AlbumsFound({@required this.word});

  @override
  _AlbumsFoundState createState() => _AlbumsFoundState();
}

class _AlbumsFoundState extends State<AlbumsFound> {
  String get word => widget.word;
  List<Album> foundAlbum;

  ScrollController _scrollController;
  int items = 4;
  int offset = 0;

  bool fetching = false;

  @override
  void initState(){
    AlbumDAO.searchAlbum(8,0,word).then((List<Album> list) =>  setState(() {
      foundAlbum = list;
      offset = offset + 8;
    }));

    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (foundAlbum.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
        if (sn is ScrollEndNotification &&
            sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent && !fetching) {
          fetching = true;
          UsefulMethods.snack(context);
          AlbumDAO.searchAlbum(items, offset, word).then((List<Album> list) {
            if (list.length > 0) {
              setState(() {
                print('fetching more items');
                foundAlbum.addAll(list);
                offset = offset + items;
                fetching= false;
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
            children: foundAlbum
                .map((el) => AlbumCardWidget(
              album: el,
            ))
                .toList(),
          ),
        ],
      ));
    }
    else if(foundAlbum == null){
      return UsefulMethods.noItems(context);
    }
    else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
