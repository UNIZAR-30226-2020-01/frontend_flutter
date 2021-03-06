//Clase capitulo de un programa de x podcast

import 'package:flutter/cupertino.dart';
import 'package:spotiseven/audio/utils/canalPodcast.dart';
import 'package:spotiseven/audio/utils/podcast.dart';

class PodcastChapter {
  //Nombre del capitulo
  String title;
  //Podcast al que pertenece
  Podcast podcast;
  //Descripción
  String description;
  //todo: quitarlo igual
  String date;
  int duration;
  String url;
  String photoUrl;
  //url de listennotes
  String uri;
  String id;

  PodcastChapter({
    @required this.title,
    this.podcast,
    @required this.description,
    @required this.duration,
    @required this.url,
    @required this.photoUrl,
    @required this.uri,
    this.id
});

  static fromJSON(Map<String, Object> json){
    PodcastChapter chap = PodcastChapter(
        title: json['title'],
        description: json['description'],
        duration: json['duration'],
        photoUrl: json['image'],
        url: json['url'],
        podcast: Podcast.fromJSONListed(json['podcast']),
        uri: json['URI'],
        id: json['id_listenotes']
    );
    return chap;
  }

  static fromJSONwithPodcast(Map<String, Object> json, Podcast p){
    PodcastChapter chap = PodcastChapter(
        title: json['title'],
        description: json['description'],
        duration: json['duration'],
        photoUrl: json['image'],
        url: json['url'],
        uri: json['URI'],
        podcast: p
    );

    return chap;
  }

  static trendingWithPodcast(Map<String, Object> json, Podcast p){
    PodcastChapter chap = PodcastChapter(
        title: json['title'],
        description: json['description'],
        duration: json['audio_length_sec'],
        photoUrl: json['image'],
        id: json['id'],
        uri: json['audio'],
        podcast: p
    );

    return chap;
  }

  static String realUrl(Map<String, Object> json) {
    print('real Url ${json['URI']}');
    return json['URI'];
  }


}