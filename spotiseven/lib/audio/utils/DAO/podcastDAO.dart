import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class PodcastDAO{
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<List<Podcast>> getUserPods() async {
    List<dynamic> response =
    await _client.get('$_url/user/podcasts/', headers: TokenSingleton().authHeader).then((Response
    resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso ${resp.statusCode}');
      }
    });
    return response.map((d) => Podcast.fromJSONListed(d)).toList();
  }


  static Future<List<Podcast>> getForU() async {
    Response response = await _client.get('$_url/user/recomendedPodcast',
        headers: TokenSingleton().authHeader);
    List<dynamic> d = jsonDecode(utf8.decode(response.bodyBytes));
    print('getFor u $response.b');
    if (response.statusCode != 200) {
      throw Exception(
          'Error al buscar for u. Codigo de error: ${response.statusCode}');
    }
    else {
      List<dynamic> dyna = jsonDecode(utf8.decode(response.bodyBytes));
      print('dynaL: $dyna');
      return dyna.map((d) => Podcast.fromTrending(d)).toList();
    }
  }

  static Future<List<Podcast>> getAllPodcasts() async {
    List<dynamic> response =
    await _client.get('$_url/podcasts/', headers: TokenSingleton().authHeader).then((Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso');
      }
    });
    return response.map((d) => Podcast.fromJSONListed(d)).toList();
  }

  static Future<List<Podcast>> getPopular() async {
    List<dynamic> response =
    await _client.get('$_url/trending-podcast/', headers: TokenSingleton().authHeader).then(
            (Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso' + resp.statusCode.toString());
      }
    });
    return response.map((d) => Podcast.popularJSON(d)).toList();
  }

  static Future<Podcast> getFromUrl(String Url) async {
    print(Url);
    dynamic response =
    await _client.get(Url, headers: TokenSingleton().authHeader).then((Response resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso ${resp.statusCode}');
      }
    });
    return Podcast.fromJSONDetailed(response);
  }

  static Future<Podcast> getTrending(String id) async {
/*    print('getting trending podcast info');
    dynamic response =
    await _client.get('$_url/podcast/$id', headers: TokenSingleton().authHeader).then((Response
    resp) {
      if (resp.statusCode == 200) {
        return jsonDecode(utf8.decode(resp.bodyBytes));
      } else {
        throw Exception('No tienes permisos para acceder a este recurso ${resp.statusCode}');
      }
    });*/
    Response response = await _client.get('$_url/podcast/$id',
        headers: TokenSingleton().authHeader);
    print(response.body);
    if (response.statusCode != 200) {
      throw Exception(
          'Error al buscar trending. Codigo de error: ${response.statusCode}');
    }
    else {
      dynamic dyna = jsonDecode(utf8.decode(response.bodyBytes));
      print('dynaL: $dyna');
      return Podcast.fromTrending(dyna);
    }
  }

  static Future<bool> amISusbscribed(Podcast p) async {
    Response response = await _client.get('$_url/user/podcasts/',
        headers: TokenSingleton().authHeader);
    if (response.statusCode != 200) {
      throw Exception(
          'Error al buscar suscripcion. Codigo de error: ${response.statusCode}');
    }
    else {
      List<dynamic> dyna = jsonDecode(utf8.decode(response.bodyBytes));
      List<Podcast> lista = dyna.map((d) => Podcast.fromJSONListed(d)).toList();
      if (lista.contains(p)){
        print('Está suscrito');
        return true;
      }
      else{
        print('No está suscrito');
        return false;
      }
    }
  }

  static Future<bool> subscribePod(Podcast p, bool sigue) async {
    String followOrNo = 'followPodcast';
    if (sigue){
      followOrNo = 'unfollowPodcast';
    }
    print('url: $_url/user/podcasts/$followOrNo/?id=${p.id}');
    Response response = await _client.post('$_url/user/podcasts/$followOrNo/?id=${p.id}',
        headers: TokenSingleton().authHeader);
    if (response.statusCode != 200) {
      throw Exception(
          'Error al suscribirse al pod. Codigo de error: ${response.statusCode}');
    }
    else {
      print('Exito suscribiendote');
      return true;
    }
  }



  static Future<List<Podcast>> searchPod(int limit, int offset, String query) async {
    print('searching podChaps $query');
    Response resp = await _client.get('$_url/podcasts/?search=$query&limit=$limit&offset=offset'
        '=$offset', headers: TokenSingleton().authHeader);

    if(resp.statusCode == 200) {
      Map<String, dynamic> map = (jsonDecode(utf8.decode(resp.bodyBytes)) as Map);
      List<dynamic> lista = map['results'];
      if (map['next'] == null && lista.isEmpty){
        //=======================================
        // DEVOLVEMOS NULL PQ SE HAN ACABADO LOS RECURSOS DE LA PAGINACIÓN
        // SOMOS UNOS GUARRROS
        //=======================================
        return [];
      }
      else return lista.map((dynamic d) => Podcast.fromJSON(d)).toList();
    }
    else {
      throw Exception('La busqueda de Artist ha ido mal. Codigo de error ${resp.statusCode}');
    }
  }



}