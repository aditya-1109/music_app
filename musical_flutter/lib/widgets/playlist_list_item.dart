// lib/widgets/playlist_item.dart

import 'package:flutter/material.dart';
import '../models/playlist_model.dart';

class PlaylistItem extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;

  const PlaylistItem({required this.playlist, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.playlist_play),
      title: Text(playlist.name),
      subtitle: Text("${playlist.songs.length} songs"),
      onTap: onTap,
    );
  }
}
