// lib/screens/library_screen.dart

import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../widgets/playlist_list_item.dart';
import '../widgets/playlist_dialog.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<Playlist> playlists = [];
  final TextEditingController _playlistController = TextEditingController();

  // Function to create a new playlist
  void createPlaylist() {
    if (_playlistController.text.isNotEmpty) {
      setState(() {
        playlists.add(
          Playlist(
            id: DateTime.now().toString(),
            name: _playlistController.text,
            songs: [],
            description: "",
          ),
        );
      });
      _playlistController.clear();
    }
  }

  // Function to display the dialog for creating a new playlist
  void showCreatePlaylistDialog() {
    showDialog(
      context: context,
      builder: (context) => PlaylistDialog(
        controller: _playlistController,
        onConfirm: createPlaylist,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Library')),
      body: playlists.isEmpty
          ? Center(
              child: Text(
                'No playlists yet. Tap + to create one!',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return PlaylistItem(
                  playlist: playlist,
                  onTap: () {
                    // Navigate to playlist details or manage songs in playlist
                    Navigator.pushNamed(
                      context,
                      '/playlist',
                      arguments: playlist,
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreatePlaylistDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _playlistController.dispose();
    super.dispose();
  }
}
