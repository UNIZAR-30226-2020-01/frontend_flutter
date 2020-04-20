//Clase podcast

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/podcast.dart';

class CanalPodcast{
  //Nombre del capitulo
  String title;
<<<<<<< HEAD
  //Podcast al que pertenece
  //TODO: QUITAR
  String author;
=======
>>>>>>> dev_podcasts
  //Descripción
  //
  String photoUrl;


  CanalPodcast(
  {
    @required this.title,
  });
  /*factory Podcast.fromJSON(Map<String, Object> json) {
    return Podcast(
      //TODO: completar cuando este claro el backend
    );
  }*/

  static CanalPodcast fromJSON(Map<String, Object> json) {
    CanalPodcast c = CanalPodcast(
        title: json['name']
    );
    return c;
  }

}