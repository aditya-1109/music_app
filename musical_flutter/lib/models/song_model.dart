// lib/models/song_model.dart

class Song {
  final String id;
  final String title;
  final String artist;
  final int duration;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
  });

  // Factory constructor for creating a Song instance from JSON data
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      title: json['title'] as String,
      artist: json['artist'] as String,
      duration: json['duration'] as int,
    );
  }

  // Convert a Song instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'duration': duration,
    };
  }
}
