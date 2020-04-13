import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/user/tokenSingleton.dart';
import 'package:spotiseven/user/user.dart';

class SongDAO {
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static final Client _client = Client();

  static Future<List<Song>> getAllSongs() async {
    List<dynamic> response = jsonDecode((await _client.get('$_url/songs', headers: TokenSingleton().authHeader)).body);
    return response.map((d) => Song.fromJSON(d));
  }

  static Future<void> markAs(bool favorite, Song song) async {
    // TODO: Cambiar la URL, y el body
    // await _client.post('$url/path', body: {}, headers: TokenSingleton().authHeader);
  }

  static Future<Song> getByUrl(String url) async {
    Response response = await _client.get('$url', headers: TokenSingleton().authHeader);
    if(response.statusCode == 200){
      // Ha ido bien
      return Song.fromJsonDetail(jsonDecode(response.body));
    }else{
      // Error
      throw Exception('La busqueda de URL(SONG) ha fallado. Codigo de error: ${response.statusCode}');
    }
  }
}
