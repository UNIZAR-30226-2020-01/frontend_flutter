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

  int numChapters;

  List<PodcastChapter> chapters;

  Podcast({
    @required this.title,
    @required this.canal,
    @required this.photoUrl,
    @required this.numChapters,
    @required this.chapters,
  });
}
