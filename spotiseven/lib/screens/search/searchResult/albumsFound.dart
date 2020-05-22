import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height*.05,
              width: MediaQuery.of(context).size.width*0.5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    'No items found',
                    style: GoogleFonts.roboto(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ),
      );
    }
  }
}
