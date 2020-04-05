import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotiseven/audio/utils/canalPodcast.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/podcastProgram.dart';

class UsefulMethods {
  static Widget text(id, size, letterspace, r,g,b,op) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        id.toUpperCase(),
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
}

class Items {
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
  static List<PodcastChapter> devoLists(Podcast p){
    List<PodcastChapter> a = [];
    a.add(ch1(p));
    a.add(ch1(p));
    a.add(ch1(p));
    a.add(ch1(p));
    a.add(ch1(p));
    a.add(ch1(p));
    a.add(ch2(p));
    a.add(ch2(p));
    a.add(ch2(p));
    a.add(ch2(p));
    a.add(ch2(p));
    a.add(ch2(p));
    return a;
  }
}