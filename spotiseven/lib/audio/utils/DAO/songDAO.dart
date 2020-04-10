import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class SongDAO {
  static final String url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static final Client _client = Client();

  static Future<List<Song>> getAllSongs() async {
    List<dynamic> response = jsonDecode((await _client.get('$url/songs', headers: TokenSingleton().authHeader)).body);
    return response.map((d) => Song.fromJSON(d));
  }
}
