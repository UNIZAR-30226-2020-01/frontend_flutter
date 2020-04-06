import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';

//info cuando cliques en cuando clicas en un capitulo

class PodcastChapterInfo extends StatefulWidget {
  final PodcastChapter podcastChapter;

  PodcastChapterInfo({ this.podcastChapter});
  @override
  _PodcastChapterInfoState createState() => _PodcastChapterInfoState();
}

class _PodcastChapterInfoState extends State<PodcastChapterInfo> {


  _image(context, url) {
    return Image(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      image: NetworkImage(url),
    );
  }

  _imageContainer(){
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.35,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: _image(context, widget.podcastChapter.photoUrl),
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
      padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.2,
      //color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width *0.3,
            child: _text(context, '${widget.podcastChapter.title}', 25.0, 0, 0, 0, 1.0),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width *0.1,
            child: _text(context, '${widget.podcastChapter.podcast.title}', 10.0, 0, 0, 0, 1.0),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width *0.2,
            child: _text(context, ' Duration: ${widget.podcastChapter.duration}', 30.0, 0, 0, 0, 1.0),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width *0.2,
            child: _text(context, ' Date: ${widget.podcastChapter.date}', 30.0, 0, 0, 0, 1.0),
          ),

        ],
      ),
    );
  }

  _infoContainer(){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: new AutoSizeText(
        widget.podcastChapter.description,
        minFontSize: 15,
        maxFontSize: 40,
        wrapWords: true,
        maxLines: 20,
        textAlign: TextAlign.justify,
        style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [ 0.05, 0.2, 0.35,0.55,0.8, 0.9],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color.fromRGBO(0, 0, 0, 1),
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.6),
                    Color.fromRGBO(0, 0, 0, 0.3),
                    Color.fromRGBO(0, 0, 0, 0.1),
                    Color.fromRGBO(0, 0, 0, 0)]
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _imageContainer(),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.width *0.6,
                      child: _textContainer(),
                    )
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
      ),
    );
  }
}
