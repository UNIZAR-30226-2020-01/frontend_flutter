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
  String get word => widget.word;
  ScrollController _scrollController;

  List<Artist> foundArtist;

  int items = 4;
  int offset = 0;

  bool fetching = false;
  @override
  void initState() {
    ArtistDAO.searchArtist(6,0,word).then((List<Artist> list) => setState(() {
      foundArtist = list;
      offset = offset + 6;
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
    if (foundArtist.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
        if (sn is ScrollEndNotification &&
            sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent && !fetching) {
          fetching = true;
          UsefulMethods.snack(context);
          ArtistDAO.searchArtist(items, offset, word).then((List<Artist> list) {
            if (list.length > 0) {
              setState(() {
                print('fetching more items');
                foundArtist.addAll(list);
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
      ));
    }
    else if(foundArtist == null){
      return UsefulMethods.noItems(context);
    }
    else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
