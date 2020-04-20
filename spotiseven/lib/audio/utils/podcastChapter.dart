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
<<<<<<< HEAD
  String duration;
  //todo: quitarlo igual
  String date;
=======
  int duration;
  String url;
>>>>>>> dev_podcasts
  String photoUrl;

  PodcastChapter({
    @required this.title,
    this.podcast,
    @required this.description,
    @required this.duration,
    @required this.url,
    @required this.photoUrl,
});
<<<<<<< HEAD

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
=======
  static fromJSON(Map<String, Object> json){
    PodcastChapter chap = PodcastChapter(
        title: json['title'],
        description: json['description'],
        duration: json['duration'],
        photoUrl: json['image'],
        url: json['url'],
        podcast: Podcast.fromJSONListed(json['podcast'])
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
        podcast: p
    );
    return chap;
  }


>>>>>>> dev_podcasts
}