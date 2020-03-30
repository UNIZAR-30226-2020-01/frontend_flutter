// Clase Song

// TODO: Cambiar esto para que coincida con los campos de la BD.
// TODO: Falta el usuario
// TODO: Imagen de playlist
class Artist {
  // Titulo de la playlist
  String name;

  // Lista de canciones en la playlist
  int numAlbums;

  int totalTracks;

  String photoUrl;

  // Constructor
  Artist({this.name, this.numAlbums, this.totalTracks, this.photoUrl});

  // TODO: Cambiar esto para que coincida con la API REST
  factory Artist.fromJSON(Map<String, Object> json) {
    return Artist(
      name: json['name'],
      // TODO: Comprobar si esto devuelve un List
      numAlbums: json['numAlbums'],
      totalTracks: json['totalTracks'],
      photoUrl: json['user'],
    );
  }
}
