import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericHorizontalListView.dart';
import 'package:spotiseven/generic_components/GenericNewPodChapter.dart';

class PodcastFound extends StatefulWidget {
  List<Podcast> pods;

  PodcastFound({@required this.pods});
  @override
  _PodcastFoundState createState() => _PodcastFoundState();
}

class _PodcastFoundState extends State<PodcastFound> {
  List<Podcast> get podsFound => widget.pods;

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
    if(podsFound.isNotEmpty){
      return GenericHorizontalListView(lista: podsFound,);
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


