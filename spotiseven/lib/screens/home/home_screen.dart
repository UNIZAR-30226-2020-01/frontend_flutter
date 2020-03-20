// TODO: Remove this import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spotiseven/audio/playingSingleton.dart';
// Clase Playlist
import 'package:spotiseven/audio/utils/playlist.dart';
// Clase Song
import 'package:spotiseven/audio/utils/song.dart';
// Clase AlbumCardWidget
import 'package:spotiseven/screens/home/album/album_detail.dart';

class HomeScreenWrapper extends StatefulWidget {
  @override
  _HomeScreenWrapperState createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  // Control de la reproduccion
  PlayingSingleton _playingSingleton = PlayingSingleton();

  // To control index
  int _currentIndex = 0;

  // TODO: Quitar. Es para hacer pruebas
  Playlist _pruebaPlaylist = Playlist(playlist: [
    Song.fromJSON(jsonDecode(
        '{"title": "Rap chungo de Internet", "photoUrl": "https://image.shutterstock.com/image-photo/serious-computer-hacker-dark-clothing-600w-1557297230.jpg", "url": "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/no_curator/Yung_Kartz/August_2019/Yung_Kartz_-_04_-_One_Way.mp3"}')),
    Song.fromJSON(jsonDecode(
        '{"title": "Rock chungo de Internet", "photoUrl": "https://images-na.ssl-images-amazon.com/images/I/919JyJJiTtL._SL1500_.jpg", "url": "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Ziklibrenbib/The_New_Monitors/st/The_New_Monitors_-_08_-_Hematoma.mp3"}')),
    Song.fromJSON(jsonDecode(
        '{"title": "Reggae? de Internet", "photoUrl": "https://images-na.ssl-images-amazon.com/images/I/81AEst8HUtL._SL1422_.jpg", "url": "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/KBOO/collection_of_lo/Live_at_KBOO_for_Higher_Reasoning_Reggae_Time_10302016/collection_of_lo_-_05_-_CoLoSo-05Heartache-Oct_2016-LIVE.mp3"}')),
    Song.fromJSON(jsonDecode(
        '{"title": "Pop? de Internet", "photoUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQvQbsbqx_j5eyjnzdzHER7bO77o7XUedQ-Pv-JJLXkodOIrRmn", "url": "https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/Blue_Dot_Sessions/Banana_Cream/Blue_Dot_Sessions_-_Popism.mp3"}')),
  ], title: 'Prueba de playlist');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        // TODO: Change this color
        backgroundColor: Color(0xff73afc5),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              TabBar(
                // TODO: Use <indicator> property to change indicator
                isScrollable: true,
                indicatorColor: Colors.black,
                // TODO: change labelStyle -> By the moment changed in tab's text
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                onTap: (value) => setState(() => _currentIndex = value),
                tabs: <Widget>[
                  buildTextTab('Following'),
                  buildTextTab('Your playlists'),
                  buildTextTab('Genres'),
                  buildTextTab('Albums'),
                  buildTextTab('Artists'),
                ],
              ),
              // Contenido principal de la pantalla
              // TODO: Cambiar a ListView
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Item Selected: $_currentIndex'),
                  Row(
                    children: <Widget>[
                      // TODO: Quitar. Es para hacer pruebas
                      GestureDetector(
                        onTap: () {
                          print(
                              'Title ${_pruebaPlaylist.title} --- NCanciones: ${_pruebaPlaylist.playlist.length}');
                          _playingSingleton.setPlayList(_pruebaPlaylist);
                        },
                        child: AlbumCardWidget(),
                      ),
                      AlbumCardWidget(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Tab buildTextTab(String text) =>
      Tab(child: Text(text, style: TextStyle(color: Colors.black)));
}
