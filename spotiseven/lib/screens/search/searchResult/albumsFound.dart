import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/screens/home/details/album_detail.dart';





class AlbumsFound extends StatefulWidget {
  List<Album> foundAlbum;

  AlbumsFound({@required this.foundAlbum});

  @override
  _AlbumsFoundState createState() => _AlbumsFoundState();
}

class _AlbumsFoundState extends State<AlbumsFound> {

  @override
  Widget build(BuildContext context) {
    if (widget.foundAlbum.isNotEmpty) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverGrid.count(
            crossAxisCount: 2,
            children: widget.foundAlbum
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
