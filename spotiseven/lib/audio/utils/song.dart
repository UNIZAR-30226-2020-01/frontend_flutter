
// Clase Album
import 'package:spotiseven/audio/utils/album.dart';

class Song {
  // nºpista(almbum),letra,titulo,archivo(URL)
  String title;
  String photoUrl;
  String url;
  // TODO: AlbumID?
  Album album;

  Song({this.title, this.url, this.photoUrl, this.album});

  // TODO: Cambiar esto para que coincida con la API REST
  factory Song.fromJSON(Map<String, Object> json){
    return Song(title: json['title'], url: json['url'], photoUrl: json['photoUrl'], album: json['album']);
  }

}