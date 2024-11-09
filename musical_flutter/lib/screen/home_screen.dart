// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../widgets/song_list_item.dart';
import '../models/song_model.dart';
import '../models/playlist_model.dart';
import 'create_playlist_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Song> songs = [
    Song(id: '1', title: 'Song One', artist: 'Artist A', duration: 210),
    Song(id: '2', title: 'Song Two', artist: 'Artist B', duration: 180),
    // Add more Song objects as needed
  ];

  final List<Playlist> playlists = [
    Playlist(
      id: '1',
      name: 'Favorites',
      description: 'My favorite songs',
      songs: [
        Song(id: '1', title: 'Song One', artist: 'Artist A', duration: 210),
        Song(id: '3', title: 'Song Three', artist: 'Artist C', duration: 150),
      ],
    ),
    Playlist(
      id: '2',
      name: 'Chill Vibes',
      description: 'Relaxing and chill music',
      songs: [
        Song(id: '2', title: 'Song Two', artist: 'Artist B', duration: 180),
        Song(id: '4', title: 'Song Four', artist: 'Artist D', duration: 200),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Playlists',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return ListTile(
                  title: Text(playlist.name),
                  subtitle: Text(playlist.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaylistScreen(playlist: playlist),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'All Songs',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
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
          ),
        ],
      ),
    );
  }
}
