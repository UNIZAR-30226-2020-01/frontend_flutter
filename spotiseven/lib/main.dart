import 'package:flutter/material.dart';

import 'EntryActivity.dart';

void main() => runApp(MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/entry',
        routes: {
          '/entry': (context) => EntryActivity(),
        }
      )
);