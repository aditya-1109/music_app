// lib/main.dart

import 'package:flutter/material.dart';
import 'screen/home_screen.dart';
import 'screen/player_screen.dart';
import 'screen/library_screen.dart';
import 'models/song_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/player': (context) {
          final song = ModalRoute.of(context)!.settings.arguments as Song;
          return PlayerScreen(song: song);
        },
        '/library': (context) => LibraryScreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
