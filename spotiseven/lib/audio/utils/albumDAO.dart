import 'dart:convert';
import 'package:http/http.dart';
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
    List<dynamic> response = await _client.get('$_url/albums').then((Response resp) => jsonDecode(resp.body));
//    print(response);
    return response.map((d) => Album.fromJSON(d)).toList();
  }

  static Future<Album> getByURL(String url) async {
    return await _client.get('$url').then((Response response) => Album.fromJSON(jsonDecode(response.body)));
  }
}