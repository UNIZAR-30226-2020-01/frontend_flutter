import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/home/details/album_detail.dart';
import 'package:spotiseven/screens/home/details/artist_detail.dart';
import 'package:spotiseven/screens/home/details/song_detail.dart';

class SongFound extends StatefulWidget {
  final List<Song> foundsong;

  SongFound({@required this.foundsong}){
    print('tamano lista canciones'+foundsong.length.toString());
  }
  @override
  _SongFoundState createState() => _SongFoundState();
}

class _SongFoundState extends State<SongFound> {

  ScrollController _scrollController;
  @override
  void initState(){
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
    if(widget.foundsong.isNotEmpty){
      return Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                widget.foundsong
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
