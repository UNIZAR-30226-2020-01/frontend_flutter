import 'package:flutter/material.dart';
import 'package:spotiseven/generic_components/GenericHorizontalWidget.dart';
import 'package:spotiseven/user/user.dart';

class UserCardWidget extends StatelessWidget {

  final User user;

  UserCardWidget({this.user}){
    print("user: ${this.user.username}");
  }

  @override
  Widget build(BuildContext context) {
    //List<Widget> lista_widget = getStrings().map((String s) => Text(s)).toList();
    return GenericHorizontalWidget(
      // TODO: Imagen del album
      imageUrl: 'https://pngimage.net/wp-content/uploads/2018/05/default-user-profile-image-png-7.png',
      args: getStrings(),
      // TODO: Integrar con la pantalla de album
      onPressedFunction: () {
        print('User card touched');
      },
    );
  }
  List<String> getStrings() {
    // TODO: Obtener el numero de canciones de un album
    return [
      user.username.toString(),
      '',
      '',
    ];
  }
}
