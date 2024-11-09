// lib/models/playlist_model.dart

import 'song_model.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final List<Song> songs;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.songs,
  });

  // Factory constructor for creating a Playlist instance from JSON data
  factory Playlist.fromJson(Map<String, dynamic> json) {
    // Parse songs as a list of Song objects
    var songList = json['songs'] as List<dynamic>;
    List<Song> songs = songList.map((song) => Song.fromJson(song as Map<String, dynamic>)).toList();

    return Playlist(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      songs: songs,
    );
  }

  // Convert a Playlist instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'songs': songs.map((song) => song.toJson()).toList(),
    };
  }
}
