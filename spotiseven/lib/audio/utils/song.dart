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
  // Es favorita para el usuario
  bool favorite;

  Song({this.title, this.url, this.album, this.favorite});

  String get photoUrl => album.photoUrl;

  static Song fromJSONWithAlbum(Map<String, Object> json, Album album) {
    return Song(
      title: json['title'],
      // El servidor es https, no http
      url: json['file'].toString().replaceAll('http://', 'https://'),
      album: album,
      // TODO: Cambiar esto para que coincida con la API REST
      favorite: json['favorite'] ?? false,
    );
  }

  static Song fromJSON(Map<String, Object> json) {
    return Song(
      title: json['title'],
      // El servidor es https, no http
      url: json['file'].toString().replaceAll('http://', 'https://'),
      album: Album.fromJSONListed(json['album']),
      // TODO: Cambiar esto para que coincida con la API REST
      favorite: json['favorite'] ?? false,
    );
  }
}
