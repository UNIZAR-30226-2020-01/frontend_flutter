
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

// TODO: Cambiar esto para que coincida con los campos de la BD.
class Album {

  // Titulo
  String titulo;

  // TODO: Cambiar para que coincida con la base de datos
  // Artista
  String artista;

  // Lista de canciones
  Map<String, Song> lista;

  // Constructor
  Album({this.titulo, this.lista, this.artista});

  // TODO: Cambiar esto para que coincida con la API REST
  factory Album.fromJSON(Map<String, Object> json){
    return Album(titulo: json['titulo'], lista: json['lista'], artista: json['artista']);
  }
}