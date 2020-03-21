// Clase Album
import 'package:spotiseven/audio/utils/album.dart';

// TODO: Cambiar esto para que coincida con los campos de la BD.
class Song {
  String title;
  String photoUrl;
  String url;
  Album album;

  Song({this.title, this.url, this.photoUrl, this.album});

  // TODO: Cambiar esto para que coincida con la API REST
  factory Song.fromJSON(Map<String, Object> json) {
    return Song(
        title: json['title'],
        url: json['url'],
        photoUrl: json['photoUrl'],
        album: json['album']);
  }
}
