// lib/providers/playlist_provider.dart

import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../models/song_model.dart';
import '../api/api_service.dart';

class PlaylistProvider with ChangeNotifier {
  List<Playlist> _playlists = [];
  bool _isLoading = false;

  List<Playlist> get playlists => _playlists;
  bool get isLoading => _isLoading;

  // Fetch playlists for a user from the API
  Future<void> fetchPlaylists(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedPlaylists = await ApiService.fetchUserPlaylists(userId);
      
      // Map each fetched playlist to a Playlist object, also ensuring songs are parsed as Song objects
      _playlists = fetchedPlaylists.map((playlistData) {
        // Parse songs from the API response
        var songList = playlistData['songs'] as List;
        List<Song> songs = songList.map((songData) => Song.fromJson(songData)).toList();

        return Playlist.fromJson({
          'id': playlistData['id'],
          'name': playlistData['name'],
          'description': playlistData['description'],
          'songs': songs,
        });
      }).toList();
      
    } catch (error) {
      print("Error fetching playlists: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new playlist to the API and local list
  Future<void> addPlaylist(String userId, String name, String description, List<Song> songs) async {
    final newPlaylist = Playlist(
      id: DateTime.now().toString(),
      name: name,
      description: description,
      songs: songs,
    );

    try {
      // Add the playlist to the API
      await ApiService.createPlaylist(userId, name, songs.map((song) => song.id).toList());
      
      // Add the new playlist to the local list
      _playlists.add(newPlaylist);
      notifyListeners();
    } catch (error) {
      print("Error adding playlist: $error");
    }
  }

  // Remove a playlist from the API and local list
  Future<void> removePlaylist(String playlistId) async {
    try {
      // Delete the playlist from the API
      await ApiService.deletePlaylist(playlistId);
      
      // Remove the playlist from the local list
      _playlists.removeWhere((playlist) => playlist.id == playlistId);
      notifyListeners();
    } catch (error) {
      print("Error removing playlist: $error");
    }
  }
}
