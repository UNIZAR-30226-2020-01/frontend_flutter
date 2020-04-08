

import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenSingleton {

  // Para las conexiones a la API REST
  static Client _client = Client();
  static String _url = 'https://s7-rest.francecentral.cloudapp.azure.com';
  // Para guardar los datos de manera segura
  static FlutterSecureStorage _storage = FlutterSecureStorage();

  // Instancia Singleton
  static TokenSingleton _instance = TokenSingleton._internal();

  // Constructor Singleton
  factory TokenSingleton() => _instance;

  // Atributos
  String _token;

  // Constructor interno
  TokenSingleton._internal() {
    print('Recuperando del almacenamiento seguro...');
    _getTokenFromSecure().then((String sec_token) {
      _token = sec_token;
      print('EL TOKEN VALE: $_token');
    });
  }

  // Getter del token de conexion
  get token => _token;

  // Getter de la cabecera de autentificacion
  get authHeader {
    return {'Authorization': 'Token $_token'};
  }

  // Guardar Token en el almacenamiento seguro
  Future<void> _saveTokenToSecure() async {
    if(_token != null){
      print('GUARDANDO: $_token');
      await _storage.write(key: 'token', value: '$_token');
      print('${await _storage.read(key: 'token')}');
    }else{
      throw Exception('SAVETOKEN: El token es NULL');
    }
  }

  // Leer el Token del almacenamiento seguro
  Future<String> _getTokenFromSecure() async {
    String auth_token = await _storage.read(key: 'token');
    return auth_token;
//    if(auth_token != null){
//      return auth_token;
//    }else{
//      // El token no existía en la BD
//      throw Exception('No hay token almacenado');
//    }
  }

  ///
  /// Get token from remote using user and password.
  /// Returns true iff petition returns code 200 and token != null.
  /// Returns false if other code (400).
  ///
  Future<bool> getTokenFromRemote(String username, String password) async {
    Response response = await _client.post('$_url/api-token-auth/', body: {
      'username': username,
      'password': password,
    });
    if(response.statusCode == 200){
      _token = (jsonDecode(response.body) as Map)['token'];
      // Comprobamos que el token no es null
      if(_token != null){
        // Guardamos el codigo en el almacenamiento seguro
        _saveTokenToSecure();
        return true;
      }else{
        return false;
      }
    } else {
      print('RESPONSE GETFROMREMOTE: ${response.body}');
      return false;
    }
  }

  ///
  /// Removes the current token from Secure. Log out
  ///
  Future<void> deleteFromSecure() async {
    if(_token != null){
      await _storage.delete(key: 'token');
      _token = null;
    }
  }

}