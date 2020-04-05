// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

// TODO: Cambiar esto para que coincida con los campos de la BD.
// TODO: Falta el usuario
// TODO: Imagen de playlist
class Playlist {
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
  Playlist({this.title, this.playlist, this.photoUrl, this.user});

  // TODO: Cambiar esto para que coincida con la API REST
  factory Playlist.fromJSON(Map<String, Object> json) {
    return Playlist(
      title: json['title'],
      // TODO: Comprobar si esto devuelve un List
      playlist: (json['songs'] as List).map((d) => Song.fromJSON(d)).toList(),
      photoUrl: json['photoUrl'],
      user: json['user'],
    );
  }

  factory Playlist.copy(Playlist p) {
    List<Song> songs = List();
    for (Song s in p.playlist) {
      songs.add(s);
    }
    return Playlist(
      title: p.title,
      playlist: songs,
      photoUrl: p.photoUrl,
      user: p.user,
    );
  }
}
