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
  String id ;

  int numChapters;

  List<PodcastChapter> chapters;

  Podcast({
    @required this.title,
    @required this.canal,
    @required this.photoUrl,
    @required this.numChapters,
    this.id,
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
      numChapters: json['number_episodes'],
      url: json['url'],
      id: json['id_listenotes']
    );
  }

  static Podcast fromGenre(Map<String, Object> json) {
    return Podcast(
        title: json['title'],
        photoUrl: json['image'],
        canal: CanalPodcast(title: (json['channel'] as Map )['name']),
        numChapters: json['number_episodes'],
        url: json['url'],
        id: json['id_listenotes']
    );
  }


  static Podcast popularJSON(Map<String, Object> json) {
    Podcast p = Podcast(
        id: json['id'],
        title: json['title'],
        photoUrl: json['image'],
        numChapters: json['total_episodes'],
    );
    return p;
  }


  static Podcast fromJSONListed(Map<String, Object> json) {
    Podcast p = Podcast(
        title: json['title'],
        id: json['id_listenotes'],
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
        id: json['id_listenotes'],
        canal: CanalPodcast.fromJSON(json['channel']),
        photoUrl: json['image'],
        numChapters: json['number_episodes'],
        url: json['url'],
    );
    p.chapters = (json['episodes'] as List).map((j) => (PodcastChapter.fromJSONwithPodcast(j, p) as PodcastChapter)).toList();
    return p;
  }

  static Podcast fromTrending(Map<String, Object> json) {
    Podcast p = Podcast(
      title: json['title'],
      canal: CanalPodcast(title: json['publisher']),
      photoUrl: json['image'],
      numChapters: json['total_episodes'],
      id: json['id'],
      url: "https://s7-rest.francecentral.cloudapp.azure.com/podcast/${json['id']}"
    );
    p.chapters = (json['episodes'] as List).map((j) => (PodcastChapter.trendingWithPodcast(j, p) as PodcastChapter)
    ).toList();
    print('AJJASDJADSJADS ${p.chapters.first.title}');
    return p;
  }

}
