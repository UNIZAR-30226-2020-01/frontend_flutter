//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:spotiseven/screens/EntryActivity.dart';
import 'package:spotiseven/screens/loginScreen/login_email3.dart';
import 'package:spotiseven/screens/main_screen.dart';
import 'package:spotiseven/screens/audio/audio_screen.dart';
import 'package:spotiseven/screens/loginScreen/login.dart';
import 'package:spotiseven/screens/splashScreen/splash_screen.dart';

void main() => runApp(MaterialApp(
        title: 'Proyecto SW',
        theme: ThemeData(
          primarySwatch: Colors.blue,
         // accentColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        //initialRoute: '/login',
        home: SplashScreen(),
        routes: {
          '/login': (context) => Login(),
          '/loginMail': (context) => LoginEmail3(),
          '/entry': (context) => EntryActivity(),
          '/home': (context) => MainScreenWrapper(),
          '/entry': (context) => EntryActivity(),
          '/playing': (context) => PlayingScreen(),
        }
      )
);