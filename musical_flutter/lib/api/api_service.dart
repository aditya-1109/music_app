import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  // Get all songs
  static Future<List<dynamic>> fetchSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/songs'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load songs');
    }
  }

  // Get playlists for a user
  static Future<List<dynamic>> fetchUserPlaylists(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/playlists?userId=$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load playlists');
    }
  }

  // Create a new playlist
  static Future<void> createPlaylist(String userId, String name, List<String> songs) async {
    final response = await http.post(
      Uri.parse('$baseUrl/user/playlists'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'userId': userId,
        'name': name,
        'songs': songs,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create playlist');
    }
  }

  // Delete a playlist
  static Future<void> deletePlaylist(String playlistId) async {
    final response = await http.delete(Uri.parse('$baseUrl/user/playlists/$playlistId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete playlist');
    }
  }
}
