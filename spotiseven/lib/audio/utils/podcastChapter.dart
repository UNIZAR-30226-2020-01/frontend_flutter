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
}