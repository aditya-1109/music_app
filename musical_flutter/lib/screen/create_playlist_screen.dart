// lib/screens/playlist_screen.dart

import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../widgets/song_list_item.dart';

class PlaylistScreen extends StatelessWidget {
  final Playlist playlist;

  PlaylistScreen({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(playlist.name)),
      body: ListView.builder(
        itemCount: playlist.songs.length,
        itemBuilder: (context, index) {
          final song = playlist.songs[index];
          return SongListItem(
            song: song,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/player',
                arguments: song,
              );
            },
          );
        },
      ),
    );
  }
}
