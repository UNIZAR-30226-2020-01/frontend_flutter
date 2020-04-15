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
    @required this.url,
  }) {
    chapters = List();
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
