// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

// TODO: Cambiar esto para que coincida con los campos de la BD.
class Album {
  // Titulo
  String titulo;

  // Artista
  String artista;

  // TODO: Comprobar la eficiencia de no tener esto siempre cargado en memoria.
  // Lista de canciones
  //Map<String, Song> lista;

  // Foto del album
  String photoUrl;

  // Constructor
  Album({this.titulo, this.artista, this.photoUrl});

  // TODO: Cambiar esto para que coincida con la API REST
  factory Album.fromJSON(Map<String, Object> json) {
    return Album(
        titulo: json['titulo'],
        artista: json['artista'],
        photoUrl: json['photoUrl']);
  }
}
