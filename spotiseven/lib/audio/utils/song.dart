// Clase Album
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/audio/utils/DAO/songDAO.dart';

// TODO: Cambiar esto para que coincida con los campos de la BD.
class Song {
  // Url en la API
  String urlApi;
  // Titulo de la cancion
  String title;
  // Url del recurso
  String url;
  // Album al que pertenece
  Album album;
  // Es favorita para el usuario
  bool favorite;
  // Letra de la cancion
  String lyrics;

  Song({this.urlApi, this.title, this.url, this.album, this.favorite, this.lyrics});

  String get photoUrl => album.photoUrl;

  static Song fromJSONWithAlbum(Map<String, Object> json, Album album) {
    return Song(
      title: json['title'],
      // El servidor es https, no http
      url: json['file'].toString().replaceAll('http://', 'https://'),
      album: album,
      // TODO: Cambiar esto para que coincida con la API REST
      favorite: json['favorite'] ?? false,
      urlApi: json['url'].toString().replaceAll('http://', 'https://'),
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
      urlApi: json['url'].toString().replaceAll('http://', 'https://'),
    );
  }

  static Song fromJsonDetail(Map<String, Object> json) {
    return Song(
      title: json['title'],
      // El servidor es https, no http
      url: json['file'].toString().replaceAll('http://', 'https://'),
      album: Album.fromJSONListed(json['album']),
      // TODO: Cambiar esto para que coincida con la API REST
      favorite: json['favorite'] ?? false,
      urlApi: json['url'].toString().replaceAll('http://', 'https://'),
      lyrics: json['lyrics'] ?? '',
    );
  }

  Future<void> fetchRemote() async {
    Song aux = await SongDAO.getByUrl(this.urlApi);
    // Aplicamos los cambios
    this.lyrics = aux.lyrics;
  }

  Future<void> setFavorite(bool fav) {
    this.favorite = fav;
    SongDAO.markAs(fav, this);
  }

}
