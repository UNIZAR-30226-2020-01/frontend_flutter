import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/user/userDAO.dart';


void main() {
  // Nos aseguramos la inicializacion de los widgets
//  TestWidgetsFlutterBinding.ensureInitialized();
  // registerUserWithPassword
  group('registerUserWithPassword', () {
    test('register new user with bad user', () async {
      try {
        bool res = await UserDAO.registerUserWithPassword(
            User(username: ''), 'password');
        if (res) {
          expect(true, false,
              reason:
              'El usuario no se ha podido registrar correctamente. El nombre era muy corto');
        }
      } on Exception catch (e) {
        // 400 si ha habido error de formateo
        expect(e.toString(),
            'Exception: Problema en el registro. Codigo de error 400');
      } catch (e) {
        expect(false, true, reason: 'La excepcion no es del tipo excepcion');
      }
    });
    test('register new user with bad password', () async {
      try {
        bool res = await UserDAO.registerUserWithPassword(
            User(username: 'password'), '');
        if (res) {
          expect(true, false,
              reason:
              'El usuario no se ha podido registrar correctamente. La contraseña era muy corta');
        }
      } on Exception catch (e) {
        // 400 si ha habido error de formateo
        expect(e.toString(),
            'Exception: Problema en el registro. Codigo de error 400');
      } catch (e) {
        expect(false, true, reason: 'La excepcion no es del tipo excepcion');
      }
    });
    test('register new user without problems', () async {
      try {
        bool res = await UserDAO.registerUserWithPassword(
            User(username: 'flutter_usuario_aleatorio_${Random().nextInt(128)}'), '12hola_que_tal34');
        expect(res, true,
            reason:
            'El usuario no se ha podido registrar correctamente.');
      } on Exception catch (e){
        // 400 si ha habido error de formateo
        print('$e');
        expect(false, true,
            reason:
            'Esta excepcion no debería haber ocurrido. El usuario deberia haberse registrado');
      } catch (e) {
        expect(false, true, reason: 'La excepcion no es del tipo excepcion');
      }
    });
  });

  // authUserWithPassword
//  test('login with bad user', () async {
//    bool ok =
//        await UserDAO.authUserWithPassword(User(username: ''), 'password');
//    expect(ok, false,
//        reason:
//            'El usuario no debería haber iniciado sesión. Usuario no valido');
//  });
//  test('login with bad password', () async {
//    bool ok =
//        await UserDAO.authUserWithPassword(User(username: 'password'), '');
//    expect(ok, false,
//        reason:
//            'El usuario no debería haber iniciado sesión. Contraseña no valida');
//  });
//  test('login', () async {
//    bool ok = await UserDAO.authUserWithPassword(
//        User(username: 'password'), 'password');
//    expect(ok, true, reason: 'El debería haber iniciado sesión.');
//  });
}
