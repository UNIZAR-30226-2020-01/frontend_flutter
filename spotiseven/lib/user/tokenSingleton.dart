

import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
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
  String _type;
  // Token de intercambio
  String _refreshToken;

  // Constructor interno
  TokenSingleton._internal() {
    print('Recuperando del almacenamiento seguro...');
    _getTokenFromSecure().then((String sec_token) {
      _token = sec_token;
      print('EL TOKEN VALE: $_token');
      print('EL TIPO DEL TOKEN ES: $_type');
      print('EL REFRESH TOKEN VALE: $_refreshToken');
    });
  }

  // Getter del token de conexion
  get token => _token;

  // Getter de la cabecera de autentificacion
  get authHeader {
    String type = _type ?? 'Token';
    return {'Authorization': '$type $_token'};
  }

  // Guardar Token en el almacenamiento seguro
  Future<void> _saveTokenToSecure() async {
    if(_token != null){
      print('GUARDANDO: $_token');
      await _storage.write(key: 'token', value: '$_token');
      await _storage.write(key: 'type', value: '$_type');
      await _storage.write(key: 'refresh', value: '$_refreshToken');
//      print('${await _storage.read(key: 'token')}');
    }else{
      throw Exception('SAVETOKEN: El token es NULL');
    }
  }

  // Leer el Token del almacenamiento seguro
  Future<String> _getTokenFromSecure() async {
    String auth_token = await _storage.read(key: 'token');
    _type = await _storage.read(key: 'type');
    _refreshToken = await _storage.read(key: 'refresh');
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
      _type = 'Token';
      _refreshToken = null;
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

  Future<bool> getTokenFromGoogle() async {
    print('Inicio auth con google');
    GoogleSignIn googleSignIn = GoogleSignIn(clientId: "315592854144-qkon632rpkgfm32ekigqemklvb5h1ojk.apps.googleusercontent.com");
    try {
      GoogleSignInAccount gsa = await googleSignIn.signIn();
      if(gsa != null){
        // Ha habido auth
        print('Ha habido auth con google');
        Map<String, String> auth = await gsa.authHeaders;
        _token = auth['Authorization'].split(' ').last;
        _type = 'Bearer';
        return await _refreshAccessToken('convert-token');
      }else{
        // No se ha autentificado
        print('No se ha autentificado');
      }
    } catch (error){
      print('$error');
    }
  }

  /// [endpoint] puede ser 'convert-token' o 'token'. Para registro por
  /// primera vez usar 'convert-token'. Para refrescar 'token'.
  Future<bool> _refreshAccessToken(String endpoint) async {
    print('TOKEN: $_token');
    // Peticion de conversion del token
    String token_type = endpoint == 'token' ? "refresh_token" : "token";
    String token_value = endpoint == 'token' ? _refreshToken.trim() : _token.trim();
    Response response = await _client.post('$_url/auth/$endpoint/', body: {
      "grant_type": endpoint == 'token' ? 'refresh_token' : 'convert_token',
      "client_id": 'rPllY8pG9tdFdROaiX7ZwIsCdQ4xzwhskdW1oCaH',
      "client_secret": 'GSBMVcRbAjz6C3l2QbfNhXs0jIF3uvBXGqNTdJ27d0fhuGeAJg4YoTMaqOeMS9HqDJtk9Kd8yar8ZVMZOOG5PZJKaRPQwvMnhnp7R1H3TixGA1ZYWPigRUUx2uOv9FkW',
      "backend": 'google-oauth2',
      token_type: token_value
    });
    if(response.statusCode == 200){
      // Ha ido bien la conversion
      print('Ha ido bien con el backend');
      _token = (jsonDecode(utf8.decode(response.bodyBytes)) as Map)['access_token'];
      _refreshToken = (jsonDecode(utf8.decode(response.bodyBytes)) as Map)['refresh_token'];
      _saveTokenToSecure();
      return true;
    }else{
      print('${response.body}');
      throw Exception('Error en la comunicacion con el backend para la conversion del token. Codigo de error ${response.statusCode}');
    }
  }

  ///
  /// Removes the current token from Secure. Log out
  ///
  Future<void> deleteFromSecure() async {
    if(_token != null){
      await _storage.delete(key: 'token');
      await _storage.delete(key: 'type');
      await _storage.delete(key: 'refresh');
      _token = null;
    }
  }

  Future<bool> accessRefresh() async {
    print('$_refreshToken');
    if(_refreshToken != null){
      // Nueva peticion a /auth/token
      print('Peticion de refresco del token');
      try {
        return await _refreshAccessToken('token');
      } on Exception catch (e) {
        print('${e.toString()}');
        return false;
      }
    }else{
      // No es aplicable
      print('Access Token no aplicable');
      return true;
    }
  }

}