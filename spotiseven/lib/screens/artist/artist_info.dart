import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/artist.dart';


class ArtistInfo extends StatefulWidget {
  final Artist artista;
  ArtistInfo({@required this.artista});
  @override
  _ArtistInfoState createState() => _ArtistInfoState();
}

class _ArtistInfoState extends State<ArtistInfo> {


  _image(context, url) {
    return Image(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      image: NetworkImage(url),
    );
  }

  _imageContainer(){
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: _image(context, widget.artista.photoUrl),
      ),
    );
  }
  _text(context, id, size, r, g, b, op) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        id,
        textAlign: TextAlign.end,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w300,
          fontSize: size,
          letterSpacing: 8,
          wordSpacing: 2,
          color: Color.fromRGBO(r, g, b, op),
        ),
      ),
    );
  }



  _textContainer(){
    return Container(
      padding:EdgeInsets.fromLTRB(20, 0, 0, 0),
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.2,
      //color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _text(context, '${widget.artista.name}', 25.0, 0, 0, 0, 1.0),
          SizedBox(height: 10,),
          _text(context, '${widget.artista.numAlbums} Albums', 15.0, 0, 0, 0, 1.0),
          SizedBox(height: 10,),
          _text(context, '${widget.artista.totalTracks} Tracks', 15.0,  0, 0, 0, 1.0),
        ],
      ),
    );
  }

  _infoContainer(){
    String infoEminem = 'Marshall Bruce Mathers III (born October 17, 1972, St. Joseph, Missouri), known by his primary stage name Eminem (stylized as EMINƎM), or by his alter ego Slim Shady, is an American rapper and record producer who grew up in Detroit, Michigan. He began his professional music career as a member of Soul Intent along with Proof in 1992. He also started his first record label with his group that same year called Mashin’ Duck Records.';
    return Container(
      padding: EdgeInsets.all(20),
      child: new Text(
        infoEminem,
        textAlign: TextAlign.justify,
        style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [0, 0.002, 1.0],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Colors.black12, Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _imageContainer(),
                  _textContainer(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: _infoContainer(),
              ),
            )
          ],
        ),
    );
  }
}
