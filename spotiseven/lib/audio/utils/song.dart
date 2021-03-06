// Clase Album
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/audio/utils/DAO/songDAO.dart';
import 'package:spotiseven/audio/utils/artist.dart';

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
      favorite: json['is_fav'] ?? false,
      // TODO: Cambiar esto para que coincida con la API REST
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
      favorite: json['is_fav'] ?? false,
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
      favorite: json['is_fav'] ?? false,
      urlApi: json['url'].toString().replaceAll('http://', 'https://'),
      lyrics: json['lyrics'] ?? '',
    );
  }

  static Song fromJSONReduced(Map<String, Object> json) {
    return Song(
      title: json['title'],
      // El servidor es https, no http
      url: json['file'].toString().replaceAll('http://', 'https://'),
      album: Album(
        photoUrl: (json['album'] as Map)['icon'],
        titulo: (json['album'] as Map)['title'],
        artista: Artist(
          name: ((json['album'] as Map)['artist'] as Map)['name'],
        )
      ),
      // TODO: Cambiar esto para que coincida con la API REST
      favorite: json['is_fav'] ?? false,
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

  // TODO: Integrar con el backend
  dynamic toJSON() {
    return {
      'title': this.title,
      'album': this.album.toJSON(),
    };
  }

}
