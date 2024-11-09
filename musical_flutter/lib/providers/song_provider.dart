// lib/providers/song_provider.dart

import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../models/playlist_model.dart';
import '../api/api_service.dart';

class SongProvider with ChangeNotifier {
  List<Song> _songs = [];
  List<Playlist> _playlists = []; // New field for playlists
  bool _isLoading = false;

  List<Song> get songs => _songs;
  List<Playlist> get playlists => _playlists; // Getter for playlists
  bool get isLoading => _isLoading;

  // Method to fetch songs from the API
  Future<void> fetchSongs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedSongs = await ApiService.fetchSongs();
      _songs = fetchedSongs.map((songData) => Song.fromJson(songData as Map<String, dynamic>)).toList();
    } catch (error) {
      print("Error fetching songs: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sample method to add playlists (you can modify this based on how you handle playlists)
  void addPlaylist(Playlist playlist) {
    _playlists.add(playlist);
    notifyListeners();
  }
}
