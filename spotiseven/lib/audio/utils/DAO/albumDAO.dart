import 'dart:convert';
import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/artist.dart';
// Clase Playlist
import 'package:spotiseven/audio/utils/playlist.dart';
// Clase Album
import 'package:spotiseven/audio/utils/album.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';

class AlbumDAO {
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<List<Album>> getAllAlbums() async {
    List<dynamic> response = await _client.get('$_url/albums').then((Response resp) {
      if(resp.statusCode == 200){
        return jsonDecode(resp.body);
      }else{
        throw Exception('No tienes permisos para acceder a este recurso');
      }
    });
//    print(response);
    return response.map((d) => Album.fromJSONListed(d)).toList();
  }

  static Future<Album> getByURL(String url, Artist artist) async {
    return await _client.get('$url').then((Response response) {
      if(response.statusCode == 200){
        return Album.fromJSONDetailWithArtist(jsonDecode(response.body), artist);
      }else{
        throw Exception('No tienes permisos para acceder a este recurso');
      }
    });
  }
}