
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/screens/podcast/podcast_chapter_info.dart';
import 'package:spotiseven/usefullMethods.dart';
import 'package:spotiseven/screens/podcast/newpodcast.dart';
import 'package:spotiseven/audio/PodcastChapterWrapper.dart';

//esto solo aparece en NEW PODCAST
class GenericNewPodChapter extends StatelessWidget {
  final PodcastChapter podcastChapter;

  GenericNewPodChapter({this.podcastChapter});


  _description(context){
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
      margin: EdgeInsets.fromLTRB(20, 10, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: UsefulMethods.text(podcastChapter.podcast.title, 20.0, 0.0, 255,255,255,1.0),
          ),
//          SizedBox(height: 5,),
          Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: UsefulMethods.text(podcastChapter.title, 15.0, 0.0, 255,255,255,1.0)
          )
        ],
      ),
    );
  }

  _elementoPodcastChapter(context){
    var time = Duration(seconds: podcastChapter.duration).toString();
    var hora = time.substring(0,1).toString();
    var min  = time.substring(2,4);
    var mostrar = '';
    if (hora != '0')
      mostrar = hora + ' horas y '+ min + ' minutos';
    else
      mostrar = min + ' minutos';
    print(mostrar);
    return Container(
        height: MediaQuery.of(context).size.height * 0.20,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(0, 0, 0, 0.86),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 9,
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
              flex: 2,
              child: Container(
                margin: EdgeInsets.fromLTRB(30, 5, 0, 0),
                child: Text(
                  'DESCRIPCIÓN',
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: Colors.white,
                  )
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Divider(thickness: 1, color: Colors.white, endIndent: 300, indent: 30,),
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    UsefulMethods.text('Duration: $mostrar'
                        , 10.0, 0.0,  255,255,255,1.0),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }

  _alert(context){
    return  showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(milliseconds: 500), () {
            Navigator.of(context).pop(true);
          });
          return Container(
            height: MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width*0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: AlertDialog(

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              title: Center(
                child: Text('Playing...',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w800
                ),),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print('capitulo del podcast');
    return GestureDetector(
          onTap: ()  {
            _alert(context);
            print('=====URI:'+podcastChapter.uri);
            var playingSingleton = PlayingSingleton();
            playingSingleton.setPlayList(PodcastChapterWrapper(podcastChapter));
            print('Reproduciendo ${playingSingleton.song.title}');
            print('Pulsado en un new chapter');
//            Navigator.push(context, MaterialPageRoute(builder: (context) => PodcastChapterInfo(podcastChapter: podcastChapter,)));
          },
          child: _elementoPodcastChapter(context),
    );
  }
}
