//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:spotiseven/screens/EntryActivity.dart';
import 'package:spotiseven/screens/home/loginScreen/login_email.dart';
import 'package:spotiseven/screens/home/main_screen.dart';
import 'package:spotiseven/screens/home/audio/audio_screen.dart';
import 'package:spotiseven/screens/home/loginScreen/login.dart';


void main() => runApp(MaterialApp(
        title: 'Proyecto SW',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/loginMail',
        routes: {
          '/login': (context) => Login(),
          '/loginMail': (context) => LoginEmail(),
          '/entry': (context) => EntryActivity(),
          '/home': (context) => MainScreenWrapper(),
          '/entry': (context) => EntryActivity(),
          '/playing': (context) => PlayingScreen(),
        }
      )
);