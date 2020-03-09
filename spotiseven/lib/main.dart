import 'package:flutter/material.dart';
import 'package:spotiseven/screens/EntryActivity.dart';
import 'package:spotiseven/screens/home/main_screen.dart';


void main() => runApp(MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          '/entry': (context) => EntryActivity(),
          '/home': (context) => MainScreenWrapper(),
        }
      )
);