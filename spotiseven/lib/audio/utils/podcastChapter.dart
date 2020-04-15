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
  String duration;
  //todo: quitarlo igual
  String date;
  String photoUrl;

  PodcastChapter({
    @required this.title,
    this.podcast,
    @required this.description,
    @required this.duration,
    @required this.date,
    @required this.photoUrl,
});

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
}