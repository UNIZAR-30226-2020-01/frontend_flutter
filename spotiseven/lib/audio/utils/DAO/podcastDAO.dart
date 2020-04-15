import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class PodcastDAO{
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  
  
  static Future<List<Podcast>> getAllPodcasts() async {
    Response rsp = await _client.get('$_url/podcasts/', headers: TokenSingleton().authHeader);

    if(rsp.statusCode == 200){
      print('Responde: ${rsp.body}');
      return( jsonDecode(rsp.body) as List<dynamic>).map((d) => Podcast.fromJSON(d)).toList();
      }
    else{
      return [];
    }
  }

}