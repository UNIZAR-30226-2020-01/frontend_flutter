import 'package:flutter/material.dart';
import 'package:spotiseven/audio/utils/DAO/podcastDAO.dart';
import 'package:spotiseven/audio/utils/podcast.dart';
import 'package:spotiseven/generic_components/GenericPodcast.dart';
import 'package:spotiseven/usefullMethods.dart';
import 'package:spotiseven/user/user.dart';

class GenericSmallUser extends StatelessWidget {
  User user;
  String url = "https://pngimage.net/wp-content/uploads/2018/05/default-user-profile-image-png-7"
      ".png";
  GenericSmallUser({
    @required this.user
  }){
    print('Entro generic small user');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            UsefulMethods.imageContainer(context, url, 0.2, 0.2),
            SizedBox(height: 10,),
            UsefulMethods.text(user.username, 10.0, 0.0, 0, 0, 0, 1.0)
          ],
        )
    );
  }
}
