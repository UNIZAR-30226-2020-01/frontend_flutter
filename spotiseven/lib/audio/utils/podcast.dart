//Clase podcast

import 'package:flutter/cupertino.dart';
import 'package:spotiseven/audio/utils/canalPodcast.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';

class Podcast {
  //Nombre del capitulo
  String title;
  //Podcast al que pertenece
  CanalPodcast canal;
  //Descripción
  String photoUrl;
  String url;

  int numChapters;

  List<PodcastChapter> chapters;

  Podcast({
    @required this.title,
    @required this.canal,
    @required this.photoUrl,
    @required this.numChapters,

    @required this.chapters,
    @required this.url,
    }) {
    chapters = List();
    }

  factory Podcast.fromJSON(Map<String, Object> json) {
    return Podcast(
      title: json['title'],
      canal: json['canal'],
      photoUrl: json['image'],
      numChapters: null,
      //podcast: (json['podcast']as Map)['title']
    );
  }


  static Podcast popularJSON(Map<String, Object> json) {
    Podcast p = Podcast(
        title: json['title'],
        photoUrl: json['image'],
        numChapters: json['total_episodes'],
    );
    if (p.title.length > 25){
      var str = p.title;
      p.title = str.substring(0,25) + '...';
    }
    return p;
  }


  static Podcast fromJSONListed(Map<String, Object> json) {
    Podcast p = Podcast(
        title: json['title'],
        canal: CanalPodcast.fromJSON(json['channel']),
        photoUrl: json['image'],
        numChapters: json['number_episodes'],
        url: json['url']
    );
    return p;
  }

  static Podcast fromJSONDetailed(Map<String, Object> json) {
    Podcast p = Podcast(
        title: json['title'],
        canal: CanalPodcast.fromJSON(json['channel']),
        photoUrl: json['image'],
        numChapters: json['number_episodes'],
        url: json['url'],
    );
    p.chapters = (json['episodes'] as List).map((j) => (PodcastChapter.fromJSONwithPodcast(j, p) as PodcastChapter)).toList();
    return p;
  }
}
