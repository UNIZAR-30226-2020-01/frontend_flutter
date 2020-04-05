// Clase Song

// TODO: Cambiar esto para que coincida con los campos de la BD.
// TODO: Falta el usuario
// TODO: Imagen de playlist
// Clase ArtistDAO
import 'package:spotiseven/audio/utils/artistDAO.dart';
// Clase Album
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

  // Constructor
  Artist({this.url, this.name, this.numAlbums, this.totalTracks, this.photoUrl}){
    albums = List();
  }

  factory Artist.fromJSON(Map<String, Object> json) {
    var a = Artist(
      url: json['url'],
      name: json['name'],
      // TODO: Numero de albums?
      numAlbums: json['numAlbums'],
      // TODO: Numero total de tracks?
      totalTracks: json['totalTracks'],
      photoUrl: json['image'],
    );
    if(json['albums'] != null){
      // El JSON tiene los albumes
      a.albums =  (json['albums'] as List).map((d) => Album.fromJSON(d)).toList();
    }
    return a;
  }

  void fetchRemote() async {
    var artist = await ArtistDAO.getByURL(url);
    // Adjuntamos los datos necesarios
    this.albums = artist.albums;
  }
}
