import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/genres.dart';
import 'package:spotiseven/screens/genres/GenresPodFound.dart';

class GenresWidgetItem extends StatefulWidget {
  Genres g;
  GenresWidgetItem({this.g});
  @override
  _GenresWidgetItemState createState() => _GenresWidgetItemState();
}

class _GenresWidgetItemState extends State<GenresWidgetItem> {
  Genres get g => widget.g;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('presed gnre');
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  PodFromGenre(pods: g
            .podcasts, g: g)));

      },
      child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      margin: EdgeInsets.fromLTRB(10, 40, 10, 30),
        child: Center(
          child: Text(
            g.name,
            style: GoogleFonts.roboto(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
