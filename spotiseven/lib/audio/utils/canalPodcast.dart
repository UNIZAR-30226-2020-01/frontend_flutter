//Clase podcast

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotiseven/audio/utils/podcastChapter.dart';
import 'package:spotiseven/audio/utils/podcastProgram.dart';

class CanalPodcast{
  //Nombre del capitulo
  String title;
  //Podcast al que pertenece
  String author;
  //Descripción
  String photoUrl;

  List<Podcast> programs;


  CanalPodcast(
  {
    @required this.title,
    @required this.author,
    @required this.photoUrl,
    this.programs,
  });
  /*factory Podcast.fromJSON(Map<String, Object> json) {
    return Podcast(
      //TODO: completar cuando este claro el backend
    );
  }*/

}