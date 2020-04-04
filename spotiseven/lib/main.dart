//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:spotiseven/screens/EntryActivity.dart';
import 'package:spotiseven/screens/loginScreen/login_email3.dart';
import 'package:spotiseven/screens/main_screen.dart';
import 'package:spotiseven/screens/audio/audio_screen.dart';
import 'package:spotiseven/screens/loginScreen/login.dart';
import 'package:spotiseven/screens/podcast/newpodcast.dart';
import 'package:spotiseven/screens/splashScreen/splash_screen.dart';

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
        initialRoute: '/login',
        home: SplashScreen(),
        routes: {
          '/login': (context) => Login(),
          '/loginMail': (context) => LoginEmail3(),
          '/entry': (context) => EntryActivity(),
          '/home': (context) => MainScreenWrapper(),
          '/entry': (context) => EntryActivity(),
          '/playing': (context) => PlayingScreen(),
          '/podcast': (context) => NewPodcast(),
        }
      )
);