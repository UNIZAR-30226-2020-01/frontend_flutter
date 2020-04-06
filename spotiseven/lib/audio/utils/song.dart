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
  static Song fromJSONWithAlbum(Map<String, Object> json, Album album) {
    return Song(
      title: json['title'],
      // El servidor es https, no http
      url: json['file'].toString().replaceAll('http://', 'https://'),
      album: album,
    );
  }

  static Song fromJSON(Map<String, Object> json) {
    return Song(
      title: json['title'],
      // El servidor es https, no http
      url: json['file'].toString().replaceAll('http://', 'https://'),
      // TODO: Comprobar si lo que devuelve esto es un Map -> Ahora es una URL MAL
      album: Album.fromJSONListed(json['album']),
    );
  }
}
