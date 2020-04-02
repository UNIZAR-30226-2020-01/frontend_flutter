// Clase Album
import 'package:spotiseven/audio/utils/album.dart';

// TODO: Cambiar esto para que coincida con los campos de la BD.
class Song {
  // Titulo de la cancion
  String title;
  // Url del recurso
  String url;
  // Album al que pertenece
  Album album;

  Song({this.title, this.url, this.album});

  String get photoUrl => album.photoUrl;

  // TODO: Cambiar esto para que coincida con la API REST
  factory Song.fromJSON(Map<String, Object> json) {
    return Song(
        title: json['title'],
        url: json['file'].toString().replaceAll('http://', 'https://'),
        // TODO: Comprobar si lo que devuelve esto es un Map
//        album: json['album'] != null ? Album.fromJSON(json['album']) : null,
    );
  }
}
