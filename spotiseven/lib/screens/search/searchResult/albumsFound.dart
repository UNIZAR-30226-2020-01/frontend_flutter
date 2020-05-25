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

  List<Album> foundAlbum;

  ScrollController _scrollController;
  bool loading = true;
  @override
  void initState(){
    AlbumDAO.searchAlbum(widget.word).then((List<Album> list) =>  setState(() {
      foundAlbum = list;
      loading = false;
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
    if (loading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else if(!loading && foundAlbum != null) {
      return CustomScrollView(
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
      );
    } else {
      return UsefulMethods.noItems(context);
    }
  }
}
