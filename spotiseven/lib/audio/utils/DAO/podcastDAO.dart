import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
<<<<<<< HEAD
import 'package:spotiseven/audio/utils/artist.dart';
=======
>>>>>>> dev_podcasts
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class PodcastDAO{
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  
  
  static Future<List<Podcast>> getAllPodcasts() async {
    Response rsp = await _client.get('$_url/podcasts/', headers: TokenSingleton().authHeader);

<<<<<<< HEAD
    if(rsp.statusCode == 200){
      print('Responde: ${rsp.body}');
      return( jsonDecode(rsp.body) as List<dynamic>).map((d) => Podcast.fromJSON(d)).toList();
      }
    else{
      return [];
    }
  }

=======
  static Future<List<Podcast>> getAllPodcasts() async {
    List<dynamic> response =
    await _client.get('$_url/podcasts', headers: TokenSingleton().authHeader).then((Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        throw Exception('No tienes permisos para acceder a este recurso');
      }
    });
//    print(response);
    return response.map((d) => Podcast.fromJSONListed(d)).toList();
  }

  static Future<Podcast> getFromUrl(String Url) async {
    dynamic response =
    await _client.get(Url, headers: TokenSingleton().authHeader).then((Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        throw Exception('No tienes permisos para acceder a este recurso');
      }
    });
    print(response);
    return Podcast.fromJSONDetailed(response);
  }
>>>>>>> dev_podcasts
}