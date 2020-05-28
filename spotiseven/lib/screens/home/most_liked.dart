import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/songDAO.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/home/details/song_detail.dart';
import 'package:spotiseven/usefullMethods.dart';

class MostLiked extends StatefulWidget {
  @override
  _MostLikedState createState() => _MostLikedState();
}

class _MostLikedState extends State<MostLiked> {
  List<Song> foundsong;
  ScrollController _scrollController;

  int items = 4;
  int offset = 0;

  bool fetching = false;

  @override
  void initState() {
    foundsong = List();
    SongDAO.mostLiked(8, 0).then((List<Song> list) => setState(() {
      foundsong = list;
      offset = offset + 8;
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
    if (foundsong.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
            if (sn is ScrollEndNotification &&
                sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent &&
                !fetching) {
              fetching = true;
              UsefulMethods.snack(context);
              SongDAO.mostPlayed(items, offset).then((List<Song> list) {
                if (list.length > 0) {
                  setState(() {
                    print('fetching more items');
                    foundsong.addAll(list);
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
              SliverList(
                delegate: SliverChildListDelegate(
                  foundsong
                      .map((el) => SongCardWidget(
                    song: el,
                  ))
                      .toList(),
                ),
              ),
            ],
          ));
    }
    else if (foundsong == null) {
      return UsefulMethods.noItems(context);
    }
    else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
