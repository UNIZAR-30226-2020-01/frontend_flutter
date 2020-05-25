import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/artistDAO.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/screens/home/details/artist_detail.dart';
import 'package:spotiseven/usefullMethods.dart';

class ArtistFound extends StatefulWidget {
  String word;


  ArtistFound({@required this.word});
  @override
  _ArtistFoundState createState() => _ArtistFoundState();
}

class _ArtistFoundState extends State<ArtistFound> {
  ScrollController _scrollController;

  List<Artist> foundArtist;

  bool loading = true;
  @override
  void initState() {
    ArtistDAO.searchArtist(widget.word).then((List<Artist> list) => setState(() {
      foundArtist = list;
      loading = false;
    }));
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
    if (loading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else if ( !loading && foundArtist != null) {
      return CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              foundArtist
                  .map((el) => ArtistCardWidget(
                artista: el,
              ))
                  .toList(),
            ),
          ),
        ],
      );
    } else {
      return UsefulMethods.noItems(context);
    }
  }
}
