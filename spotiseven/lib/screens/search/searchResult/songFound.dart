import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/songDAO.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/home/details/album_detail.dart';
import 'package:spotiseven/screens/home/details/artist_detail.dart';
import 'package:spotiseven/screens/home/details/song_detail.dart';
import 'package:spotiseven/usefullMethods.dart';

class SongFound extends StatefulWidget {
  String word;
  SongFound({@required this.word});
  @override
  _SongFoundState createState() => _SongFoundState();
}

class _SongFoundState extends State<SongFound> {

  List<Song> foundsong;
  bool loading;

  ScrollController _scrollController;
  @override
  void initState(){
    SongDAO.searchSong(widget.word).then((List<Song> list) => setState(() {
      foundsong = list;
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
    else if(!loading && foundsong != null){
      return Scaffold(
        body: CustomScrollView(
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
        ),
      );
    }
    else {
      return UsefulMethods.noItems(context);
    }
  }
}
