
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:spotiseven/screens/podcast/podcast_info.dart';

class GenericNewPodcast extends StatelessWidget {
  PodcastChapter podcastChapter;

  GenericNewPodcast({@required this.podcastChapter});


  _text(id, size, letterspace) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        id.toUpperCase(),
        textAlign: TextAlign.end,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: size,
          letterSpacing: letterspace,
          color: Colors.white,
        ),
      ),
    );
  }

  _durationDate(){

  }

  _description(context){
    return Container(
      padding: EdgeInsets.fromLTRB(30, 1, 30, 0),
        child: AutoSizeText(
          podcastChapter.description,
          textAlign: TextAlign.justify,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontSize: 10,
            ),
            fontWeight: FontWeight.w400,
            fontSize: 2,
            color: Colors.white,
          ),
          maxLines: 10,
        )
    );
  }

  _image(context){
    return Container(
      margin: EdgeInsets.fromLTRB(30, 2, 0, 0),
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          image: NetworkImage(podcastChapter.photoUrl),
        ),
      ),
    );
  }
  _chapterInfo(){
    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _text(podcastChapter.parentPod, 20.0, 3.0),
          SizedBox(height: 5,),
          _text(podcastChapter.title, 14.0, 0.0)
        ],
      ),
    );
  }

  _elementoPodcastChapter(context){
    return Container(
        height: MediaQuery.of(context).size.height * 0.20,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(
                child: Row(
                  children: <Widget>[
                    _image(context),
                    _chapterInfo(),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: _description(context),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _text('Duration: ${podcastChapter.duration}', 10.0, 0.0),
                    _text(podcastChapter.date, 10.0, 0.0),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('Pulsado en un new chapter');
        Navigator.push(context, MaterialPageRoute(builder: (context) => PodcastChapterInfo(podcastChapter: this.podcastChapter,)));
      },
      child: _elementoPodcastChapter(context),
    );
  }
}
