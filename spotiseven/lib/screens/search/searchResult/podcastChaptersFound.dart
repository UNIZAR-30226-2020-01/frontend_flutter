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
  List<PodcastChapter> chapsFound;

  ScrollController _scrollController;
  bool loading=true;
  @override
  void initState(){
    PodcastChapterDAO.searchPodChap(widget.word).then((List<PodcastChapter> list) => setState(() {
      chapsFound = list;
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
    else if(!loading && chapsFound != null ){
      return CustomScrollView(
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
      );
    }else{
      return UsefulMethods.noItems(context);
    }
  }
}
