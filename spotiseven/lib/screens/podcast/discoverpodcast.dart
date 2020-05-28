
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/genresDAO.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/genres.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericHorizontalListView.dart';
import 'package:spotiseven/screens/genres/GenresWidget.dart';
import 'package:spotiseven/usefullMethods.dart';

class DiscoverPodcast extends StatefulWidget {
  @override
  _DiscoverPodcastState createState() => _DiscoverPodcastState();
}




class _DiscoverPodcastState extends State<DiscoverPodcast> {
  List<Podcast> _listPodcasts;

  bool hayForYou;

  List<Genres> genres;
  bool hayGenres;

  int offset = 0;
  int items =4;

  @override
  void initState() {
    _listPodcasts = List();
    PodcastDAO.getForU().then((List<Podcast> list) => setState(() {
      _listPodcasts = list;
      hayForYou = true;
    }));
    GenresDAO.searchGenres(15, 0).then((List<Genres> list) => setState(() {
        genres = list;
      }));
    super.initState();
  }

  _foruBar() {
          return Container(
        color: Colors.black,
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        height: MediaQuery
            .of(context)
            .size
            .width * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            UsefulMethods.text(
                'FOR YOU',
                14.0,
                0.0,
                255,
                255,
                255,
                1.0),
          ],
        ),
      );
    }



    _foruElem() {
      if (!hayForYou) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (_listPodcasts.length == 0) {
        return Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                'You don`t have any subscription',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        );
      } else
        return GenericHorizontalListView(
          lista: _listPodcasts,
        );
    }


  _suggestionsGrid() {
    if (genres.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_listPodcasts.length == 0) {
      return Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              'You don`t have any subscription',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      );
    } else
      return GenresWidget(
        lista: genres,
      );
  }


  _suggestionsBar() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      height: MediaQuery.of(context).size.width * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          UsefulMethods.text('GENRES', 14.0, 0.0, 255, 255, 255, 1.0),
        ],
      ),
    );
  }





    @override
    Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _foruBar(),
            ),
            Expanded(
              flex: 4,
              child: _foruElem(),
            ),
            Expanded(
              flex: 1,
              child: _suggestionsBar(),
            ),
            Expanded(
              flex: 6,
              child: _suggestionsGrid(),
            )
          ],
        ),
      );
    }
}




