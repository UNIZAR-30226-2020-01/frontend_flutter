import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/podcastChapterDAO.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/generic_components/GenericNewPodChapter.dart';
import 'package:spotiseven/usefullMethods.dart';

class ChaptersFound extends StatefulWidget {
  String word;

  ChaptersFound({@required this.word});

  @override
  _ChaptersFoundState createState() => _ChaptersFoundState();
}

class _ChaptersFoundState extends State<ChaptersFound> {
  String get word => widget.word;
  List<PodcastChapter> chapsFound;

  int items = 4;
  int offset = 0;

  bool fetching = false;
  bool vacio = true;

  ScrollController _scrollController;
  @override
  void initState(){
    chapsFound = List();
    PodcastChapterDAO.searchPodChap(8,0,word).then((List<PodcastChapter> list) =>
      setState(() {
        chapsFound = list;
        offset = offset + 8;
        vacio = false;
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
    if (offset==0){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else if (chapsFound.isNotEmpty) {
      return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification sn) {
        if (sn is ScrollEndNotification &&
            sn.metrics.pixels >= 0.7 * sn.metrics.maxScrollExtent && !fetching) {
          fetching = true;
          UsefulMethods.snack(context);
          PodcastChapterDAO.searchPodChap(items, offset,word).then((List<PodcastChapter> list) {
            if (list.length > 0) {
              setState(() {
                print('fetching more items');
                chapsFound.addAll(list);
                offset = offset + items;
                fetching= false;
              });
            }
          });
        }
        return true;
      },
    child:  CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              chapsFound.map((el) => GenericNewPodChapter(
                podcastChapter: el,
              ))
                  .toList(),
            ),
          ),
        ],
      ));
    }
    else if (vacio){
      return UsefulMethods.noItems(context);
    }
    else
      return UsefulMethods.noItems(context);
  }
}
