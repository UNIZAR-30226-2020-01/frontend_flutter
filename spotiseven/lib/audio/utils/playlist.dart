// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

class Playlist {
  // Titulo de la playlist
  String title;

  // Lista de canciones en la playlist
  List<Song> playlist;

  // Constructor
  Playlist({this.title, this.playlist});

  // TODO: Cambiar esto para que coincida con la API REST
  factory Playlist.fromJSON(Map<String, Object> json) {
    return Playlist(title: json['title'], playlist: json['playlist']);
  }
}
