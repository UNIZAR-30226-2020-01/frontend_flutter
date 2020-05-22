import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/DAO/songDAO.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/home/details/song_detail.dart';

class MostPlayed extends StatefulWidget {

  @override
  _MostPlayedState createState() => _MostPlayedState();
}

class _MostPlayedState extends State<MostPlayed> {
  List<Song> foundsong;
  ScrollController _scrollController;
  bool cargado;

  @override
  void initState(){
    cargado = false;
    foundsong = List();
    SongDAO.mostPlayed()
        .then((List<Song> list) => setState(() {
          foundsong = list;
          cargado = true;
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
    if(foundsong.isNotEmpty){
      return CustomScrollView(
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
        );
    }
    else if (!cargado){
      return Center(
        child: CircularProgressIndicator(

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
