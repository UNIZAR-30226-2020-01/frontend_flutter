import 'package:flutter/material.dart';
import 'package:spotiseven/generic_components/GenericHorizontalWidget.dart';
import 'package:spotiseven/screens/user/user_screen.dart';
import 'package:spotiseven/user/user.dart';
import 'package:spotiseven/screens/user/userScreenFounded.dart';
import 'package:spotiseven/user/userDAO.dart';

class UserCardWidget extends StatefulWidget {

  final User user;

  UserCardWidget({this.user}){
    print("user: ${this.user.username} &  ${this.user.imageUrl}");
  }

  @override
  _UserCardWidgetState createState() => _UserCardWidgetState();
}

class _UserCardWidgetState extends State<UserCardWidget> {
  User get user => widget.user;
  @override
  void initState() {
    UserDAO.userImg(user.url).then((String x) {
      setState(() {
        user.imageUrl = x;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //List<Widget> lista_widget = getStrings().map((String s) => Text(s)).toList();
    return GenericHorizontalWidget(
      // TODO: Imagen del album
      imageUrl: widget.user.imageUrl,
      args: getStrings(),
      // TODO: Integrar con la pantalla de album
      onPressedFunction: () {
        print('User card touched');
//        user.addImage(user.imageUrl);
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreenFound(user:
        widget.user,)));
      },
    );
  }

  List<String> getStrings() {
    // TODO: Obtener el numero de canciones de un album
    return [
      "USER",
      widget.user.username.toString(),
      " ",
//      " ",
    ];
  }
}
