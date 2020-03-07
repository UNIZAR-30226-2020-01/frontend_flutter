import 'package:flutter/material.dart';

import 'EntryActivity.dart';
import 'audio/audio_screen.dart';

void main() => runApp(MaterialApp(
        title: 'Proyecto SW',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/playing',
        routes: {
          '/entry': (context) => EntryActivity(),
          '/playing': (context) => PlayingScreen(),
        }
      )
);