import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/canalPodcast.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/podcast.dart';

class UsefulMethods {

  static gradient(){
    return LinearGradient(
        stops: [ 0.05, 0.2, 0.35,0.55,0.8, 0.9],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color.fromRGBO(0, 0, 0, 1),
          Color.fromRGBO(0, 0, 0, 0.8),
          Color.fromRGBO(0, 0, 0, 0.6),
          Color.fromRGBO(0, 0, 0, 0.3),
          Color.fromRGBO(0, 0, 0, 0.1),
          Color.fromRGBO(0, 0, 0, 0)]
    );
  }
  static Widget text(String id, size, letterspace, r,g,b,op) {
    if (id.length > 25){
      id = id.substring(0,25)+'...';
    }
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        id.toUpperCase(),
        overflow: TextOverflow.fade,
        maxLines: 2,
        softWrap: false,
        textAlign: TextAlign.end,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: size,
          letterSpacing: letterspace,
          color: Color.fromRGBO(r, g, b, op),
        ),
      ),
    );
  }

  static Widget snack(context){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        'LOADING MORE ITEMS...',
        style: GoogleFonts.roboto(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      duration: Duration(milliseconds: 200),
      backgroundColor: Colors.black,
    ));
  }
  static Widget noItems(context){
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

  static Widget imageContainer(context, url, fw, fh){
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: MediaQuery.of(context).size.width * fw,
      height: MediaQuery.of(context).size.width * fh,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          image: NetworkImage(url),
        ),
      ),
    );
  }
  static Widget suggestionImage(context, url, fw, fh){
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      width: MediaQuery.of(context).size.width * fw,
      height: MediaQuery.of(context).size.width * fh,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          image: NetworkImage(url),
        ),
      ),
    );
  }
  static Widget comingSoon(context){
    return Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.black,
    child: UsefulMethods.text('COOMING SOON', 30.0, 5.0, 251, 225, 33, 1.0),
    );
  }
}

/*class Items {
  static c1() {
    return CanalPodcast(title: 'RTVE',
        author: 'ESPAÑITA',
        photoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Logo_RTVE.svg/1200px-Logo_RTVE.svg.png');
  }

  static pod1(CanalPodcast cp, String title, int chapters, String url) {
    return Podcast(
        title: title,
        canal: cp,
        photoUrl: url,
        numChapters: chapters,
        chapters: []
    );
  }

  static Podcast addChapters(Podcast p, List<PodcastChapter> l){
    p.chapters = l;
    return p;
  }
  static ch2(Podcast p) {
    return PodcastChapter(
        title: 'New code Flutter ',
        podcast: p,
        description: 'como desarrollar en flutter como desarrollar en flutter'
            'como desarrollar en flutter como desarrollar en flutter como desarrollar en flutter'
            'como desarrollar en flutter como desarrollar en flutter como desarrollar en flutter'
            'como desarrollar en flutter como desarrollar en flutter como desarrollar en flutter',
        duration: '3h',
        date: '29 de marzo de 2020',
        photoUrl: 'https://flutter-es.io/assets/homepage/news-2-599aefd56e8aa903ded69500ef4102cdd8f988dab8d9e4d570de18bdb702ffd4.png'
    );
  }

  static ch(Podcast p){
    return PodcastChapter(title: 'chap1', podcast: p, description: 'no hay descriopcion',
        duration: '1h', date: '4/4/2020', photoUrl: 'https://tarasparlingwrites.files.wordpress.com/2015/03/chapter-one-graphic.png');}

    static ch1(Podcast p) {
      return PodcastChapter(
          title: 'Noticias covid',
          podcast: p,
          description: 'noticias de covid y demás noticias de covid y demás'
              'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
              'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
              'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
              'noticias de covid y demás noticias de covid y demás noticias de covid y demás 1000000'
              'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
              'noticias de covid y demás noticias de covid y demás noticias de covid y demás'
              'noticias de covid y demás noticias de covid y demás noticias de covid y demás',
          duration: '1h:30',
          date: '19 de marzo de 2020',
          photoUrl: 'https://ewscripps.brightspotcdn.com/dims4/default/7671677/2147483647/strip/true/crop/1303x733+15+0/resize/1280x720!/quality/90/?url=https%3A%2F%2Fewscripps.brightspotcdn.com%2F0a%2Ff2%2F72b1b4d94794992a0772cb593ce5%2Fscreen-shot-2020-02-25-at-10.49.27%20AM.png'
      );
    }

    static List<Podcast> addPodcastToList(Podcast p, List<Podcast> l){
      l.add(p);
      return l;
    }

    static List<Podcast> devoListsPodcasts(){
      List<Podcast> a = [];
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      a.add(pod1(null, 'discover', 12, 'https://i.ytimg.com/vi/3tNrCV9aNVM/maxresdefault.jpg'));
      return a;
    }

    static List<PodcastChapter> devoLists(Podcast p){
      List<PodcastChapter> a = [];
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));
      a.add(ch(p));

      return a;
    }
  }*/