import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/screens/home/details/artist_detail.dart';

class ArtistFound extends StatefulWidget {
  List<Artist> foundArtist;


  ArtistFound({@required this.foundArtist});
  @override
  _ArtistFoundState createState() => _ArtistFoundState();
}

class _ArtistFoundState extends State<ArtistFound> {
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

  @override
  Widget build(BuildContext context) {
    if (widget.foundArtist.isNotEmpty) {
      return CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              widget.foundArtist
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
