import 'package:flutter/material.dart';
import 'package:spotiseven/screens/EntryActivity.dart';
import 'package:spotiseven/screens/home/main_screen.dart';
import 'package:spotiseven/audio/audio_screen.dart';

void main() => runApp(MaterialApp(
        title: 'Proyecto SW',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          '/entry': (context) => EntryActivity(),
          '/home': (context) => MainScreenWrapper(),
          '/entry': (context) => EntryActivity(),
          '/playing': (context) => PlayingScreen(),
        }
      )
);