//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:spotiseven/screens/loginScreen/login_email.dart';
import 'package:spotiseven/screens/main_screen.dart';
import 'package:spotiseven/screens/audio/audio_screen.dart';
import 'package:spotiseven/screens/loginScreen/login.dart';
import 'package:spotiseven/screens/podcast/newpodcast.dart';
import 'package:spotiseven/screens/register/register.dart';
import 'package:spotiseven/screens/search/recomendations.dart';
import 'package:spotiseven/screens/search/searchWrapper.dart';
import 'package:spotiseven/screens/splashScreen/splash_screen.dart';
import 'package:spotiseven/screens/search/searchBar.dart';
import 'package:spotiseven/screens/search/searchResult/albumsFound.dart';
import 'package:spotiseven/screens/search/searchResult/artistFound.dart';
import 'package:spotiseven/screens/search/searchResult/podcastChapters.dart';
import 'package:spotiseven/screens/search/searchResult/podcastFound.dart';
import 'package:spotiseven/screens/search/searchResult/songFound.dart';
import 'package:spotiseven/screens/search/searchResult/playlistFound.dart';



const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

const MaterialColor black = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0x00000000),
    100: const Color(0x00000000),
    200: const Color(0x00000000),
    300: const Color(0x00000000),
    400: const Color(0x00000000),
    500: const Color(0x00000000),
    600: const Color(0x00000000),
    700: const Color(0x00000000),
    800: const Color(0x00000000),
    900: const Color(0x00000000),
  },
);

void main() => runApp(MaterialApp(
        title: 'Proyecto SW',
        theme: ThemeData(
          primarySwatch: white,
          accentColor: Colors.yellow[300],
        ),
        debugShowCheckedModeBanner: false,
        //initialRoute: '/login',
        home: SplashScreen(),
        routes: {
          '/recomendations': (context) => Recomendations(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => Login(),
          '/loginMail': (context) => LoginEmail(),
          '/home': (context) => MainScreenWrapper(),
          '/playing': (context) => PlayingScreen(),
          '/podcast': (context) => NewPodcast(),
          '/searchWrapper': (context) => SearchWrapper(),
          '/podfound': (context) => PodcastFound(),
          '/podchfound': (context) => ChaptersFound(),
          '/artistfound': (context) => ArtistFound(),
          '/songfound': (context) => SongFound(),
          '/playlistfound': (context) => PlaylistFound(),
          '/artistifound': (context) => ArtistFound(),
        }
      )
);