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

  PodcastChapter({
    @required this.title,
    this.podcast,
    @required this.description,
    @required this.duration,
    @required this.url,
    @required this.photoUrl,
    @required this.uri
});
/*<<<<<<< HEAD

  factory PodcastChapter.fromJSON(Map<String, Object> json) {
    return PodcastChapter(
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      date: json['date'],
      photoUrl: json['image'],
      podcast: Podcast.fromJSON(json['podcast']),
    );
  }
=======*/
  static fromJSON(Map<String, Object> json){
    PodcastChapter chap = PodcastChapter(
        title: json['title'],
        description: json['description'],
        duration: json['duration'],
        photoUrl: json['image'],
        url: json['url'],
        podcast: Podcast.fromJSONListed(json['podcast']),
        uri: json['URI']
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
        podcast: p
    );

    return chap;
  }
}