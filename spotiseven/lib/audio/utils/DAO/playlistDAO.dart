import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:spotiseven/audio/utils/album.dart';
import 'package:spotiseven/audio/utils/artist.dart';
import 'package:spotiseven/audio/utils/playlist.dart';
import 'package:spotiseven/audio/utils/song.dart';
import 'package:spotiseven/user/tokenSingleton.dart';

class PlaylistDAO {
  static final Client _client = Client();
  static final String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';

  static Future<List<Playlist>> pagedPlaylist(int limit, int offset) async {
    print('ilimit: $limit & offset: $offset');
    Response response = await _client.get('$_url/user/playlists/?limit=$limit&offset=$offset',
        headers: TokenSingleton().authHeader);
    if (response.statusCode == 200) {
      print('RESPONSE: ${response.body}');
      Map<String, dynamic> map = (jsonDecode(utf8.decode(response.bodyBytes)) as Map);
      List<dynamic> lista = map['results'];
      print(lista);
      if (map['next'] == null && lista.isEmpty){
        //=======================================
        // DEVOLVEMOS NULL PQ SE HAN ACABADO LOS RECURSOS DE LA PAGINACIÓN
        // SOMOS UNOS GUARRROS
        //=======================================
        return [];
      }
      else return lista.map((dynamic d) => Playlist.fromJSONListed(d)).toList();
    }
    else {
      throw Exception(
          'Error al buscar playlist Código: ${response.statusCode}'
      );
    }
  }

  static Future<List<Playlist>> getAllPlaylists() async {
    Response response = await _client.get('$_url/user/playlists',
        headers: TokenSingleton().authHeader);
    if (response.statusCode == 200) {
      print('RESPONSE: ${response.body}');
      return (jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>)
          .map((d) => Playlist.fromJSONListed(d))
          .toList();
    } else {
      throw Exception(
        'Error al buscar playlist Código: ${response.statusCode}'
      );
    }
  }

  static Future<Playlist> getByURL(String url) async {
//    return Future.delayed(Duration(seconds: 3), () => _listPlaylist);
    // TODO: Revisar cual sera la URL final
//    Response response = await _client.get('$_url/playlists');
    Response response =
        await _client.get('$url', headers: TokenSingleton().authHeader);
    // Convertimos los json a playlist
    // TODO: Comprobar el campo de las playlist
    if (response.statusCode == 200) {
      print('RESPONSE: ${response.body}');
      return Playlist.fromJSONDetail(jsonDecode(utf8.decode(response.bodyBytes)) as Map);
    } else {
      throw Exception(
          "Error al buscar en la URL: $url . Codigo de error: ${response.statusCode}");
    }
  }

  static Future<Playlist> getByURLReduced(String url) async {
//    return Future.delayed(Duration(seconds: 3), () => _listPlaylist);
    // TODO: Revisar cual sera la URL final
//    Response response = await _client.get('$_url/playlists');
    Response response =
    await _client.get('$url', headers: TokenSingleton().authHeader);
    // Convertimos los json a playlist
    // TODO: Comprobar el campo de las playlist
    if (response.statusCode == 200) {
      print('RESPONSE: ${response.body}');
      return Playlist.fromJSONDetailReduced(jsonDecode(utf8.decode(response.bodyBytes)) as Map);
    } else {
      throw Exception(
          "Error al buscar en la URL: $url . Codigo de error: ${response.statusCode}");
    }


  }

  static Future<Playlist> createPlaylist(Playlist p, File image) async {

    print('${image.path}');

    var file = await dio.MultipartFile.fromFile(image.path);

    print('${file.toString()}');

    dio.FormData fd = dio.FormData.fromMap({
      'title': p.title,
      'icon': file,
    });

    print('$_url/playlists/');
    print('FormData = ${fd.fields}');

    dio.Response response = await dio.Dio().post('$_url/playlists/',
        data: fd, options: dio.Options(headers: TokenSingleton().authHeader));

    if (response.statusCode == 201) {
      // Ha ido bien
      print('La creacion de la lista ha ido bien');
      print('Respuesta ==> ${response.data}');
      print('${response.data.runtimeType}');
      // TODO: Actualizar la información de la playlist
      return Playlist.fromJSONListed(response.data);
    } else {
      print('${response.data}');
      throw Exception(
          'Error al crear una playlist. Codigo de error: ${response.statusCode}');
    }
  }

  static Future<void> addSongToPlaylist(Playlist p, Song s) async {
//    var list = s.urlApi.split('/');
//    var id = list[list.length - 2];
//    print('id: $id');
    print('url: ${p.url}add_song/?song=${s.urlApi}');
    Response response = await _client.post('${p.url}add_song/?song=${s.urlApi}',
        headers: TokenSingleton().authHeader);
    if (response.statusCode != 200) {
      throw Exception(
          'Error al añadir una cancion a la playlist. Codigo de error: ${response.statusCode}');
    }
  }

  /// Busca el parámetro en: título o nombre del usuario creador


  static Future<List<Playlist>> searchPlaylist(int limit, int offset, String query) async {
        print('searching podChaps $query');
        Response resp = await _client.get
          ('$_url/playlists/?search=$query&limit=$limit&offset=$offset'
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
          else return lista.map((dynamic d) => Playlist.fromJSONListed(d) ).toList();
        }
        else {
          throw Exception('La busqueda de Artist ha ido mal. Codigo de error ${resp.statusCode}');
        }
      }

 /* static Future<List<Playlist>> searchPlaylist(String query) async {
    print("DAO: BUSCANDO" + query);
    Response resp = await _client.get('$_url/playlists/?search=$query');
    if(resp.statusCode == 200) {
      // Ha ido bien, devolvemos las listas
      List<dynamic> lista = jsonDecode(utf8.decode(resp.bodyBytes));
      List<Playlist> platlists = lista.map((dynamic d) => Playlist.fromJSONListed(d) ).toList();
      return platlists;
    }else{
      throw Exception('La busqueda de Playlist ha ido mal. Codigo de error ${resp.statusCode}');
    }
  }*/
}
