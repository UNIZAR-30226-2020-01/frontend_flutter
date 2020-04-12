// Clase Song

// TODO: Cambiar esto para que coincida con los campos de la BD.
// TODO: Falta el usuario
// TODO: Imagen de playlist
// Clase ArtistDAO
import 'package:spotiseven/audio/utils/DAO/artistDAO.dart';
import 'package:spotiseven/audio/utils/album.dart';

class Artist {
  // Url del recurso
  String url;

  // Titulo de la playlist
  String name;

  // Albumes del artista
  // TODO: Contar con los "featured_in_album"?
  List<Album> albums;
  // Numero de albumes del artista
  int numAlbums;

  // Numero de canciones del artista
  int totalTracks;

  // Url de la imagen del artista
  String photoUrl;

  // Biografía del artista
  String biography;

  // Constructor
  Artist(
      {this.url, this.name, this.numAlbums, this.totalTracks, this.photoUrl, this.biography}) {
    albums = List();
  }

  static Artist fromJSONListed(Map<String, Object> json) {
//    print('listed: ${json['url']}');
    var a = Artist(
      url: json['url'],
      name: json['name'],
      photoUrl: json['image'],
      numAlbums: json['number_albums'],
      totalTracks: json['number_songs'],
    );
    return a;
  }

  static Artist fromJSONDetail(Map<String, Object> json) {
    print('detail: ${json['url']}');
    var a = Artist(
      url: json['url'],
      name: json['name'],
      // TODO: Numero de albums?
      numAlbums: json['numAlbums'],
      // TODO: Numero total de tracks?
      totalTracks: json['totalTracks'],
      photoUrl: json['image'],
      biography: json['biography'],
    );
    if (json.containsKey('albums')) {
      // El JSON tiene una lista de las URL de los albumes
//      _setAlbums(a, json['albums']);
      a.albums = (json['albums'] as List)
          .map((d) => Album.fromJSONListedWithArtist(d, a))
          .toList();
    }
    return a;
  }

  Future<void> fetchRemote() async {
    var artist = await ArtistDAO.getByURL(url);
    // Adjuntamos los datos necesarios
    // Parseamos las URL de los albumes del artista
    this.albums = artist.albums;
    this.biography = artist.biography;
  }
}
