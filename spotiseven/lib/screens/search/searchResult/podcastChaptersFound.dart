import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/generic_components/GenericNewPodChapter.dart';

class ChaptersFound extends StatefulWidget {
  List<PodcastChapter> chapsFound;

  ChaptersFound({@required this.chapsFound});

  @override
  _ChaptersFoundState createState() => _ChaptersFoundState();
}

class _ChaptersFoundState extends State<ChaptersFound> {
  List<PodcastChapter> get chapsFound => widget.chapsFound;

  ScrollController _scrollController;
  @override
  void initState(){
//    _listPlaylist = List();
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
    if(chapsFound.isNotEmpty){
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
