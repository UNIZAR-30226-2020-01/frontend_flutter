// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

// TODO: Cambiar esto para que coincida con los campos de la BD.
// TODO: Falta el usuario
// TODO: Imagen de playlist
class Playlist {
  // URL del recurso
  String url;

  // Titulo de la playlist
  String title;

  // Lista de canciones en la playlist
  List<Song> playlist;

  // TODO: Cambiar la informacion de un usuario
  // Username
  String user;

  // Imagen de playlist
  String photoUrl;

  // Constructor
  Playlist({this.url, this.title, this.playlist, this.photoUrl, this.user});

  // TODO: Cambiar esto para que coincida con la API REST
  factory Playlist.fromJSON(Map<String, Object> json) {
    return Playlist(
      url: (json['url'] as String).replaceAll('http://', 'https://'),
      title: json['title'],
      playlist: (json['songs'] as List).map((d) => Song.fromJSON(d)).toList(),
      photoUrl: json['icon'],
      // TODO: Comprobar esto cuando existan los usuarios
      user: (json['user'] as Map)['username'],
    );
  }

  factory Playlist.copy(Playlist p) {
    List<Song> songs = List();
    for (Song s in p.playlist) {
      songs.add(s);
    }
    return Playlist(
      url: p.url,
      title: p.title,
      playlist: songs,
      photoUrl: p.photoUrl,
      user: p.user,
    );
  }

  // TODO: Integrar con el endpoint
  Map<String, dynamic> toJSON() {
    var m = Map<String,dynamic>();
    m['title'] = this.title;
    m['playlist'] = this.playlist.map((s) => s.toJSON()).toList();
    m['photoUrl'] = this.photoUrl;
    return m;
  }
}
