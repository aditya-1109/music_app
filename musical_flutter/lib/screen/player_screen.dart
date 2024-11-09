// lib/screens/player_screen.dart

import 'package:flutter/material.dart';
import "../models/song_model.dart";
import '../widgets/player_controls.dart';
import '../widgets/progress_bar.dart';

class PlayerScreen extends StatefulWidget {
  final Song song;

  const PlayerScreen({required this.song, Key? key}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool isPlaying = false;
  double progress = 0.0;
  late double totalDuration;

  @override
  void initState() {
    super.initState();
    totalDuration = widget.song.duration.toDouble();
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void nextSong() {
    // Placeholder: Logic to handle playing the next song
    print("Next song");
  }

  void previousSong() {
    // Placeholder: Logic to handle playing the previous song
    print("Previous song");
  }

  // Mock function to simulate progress for demonstration
  void updateProgress() {
    if (isPlaying && progress < totalDuration) {
      setState(() {
        progress += 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.song.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.song.title, style: TextStyle(fontSize: 24)),
          Text(widget.song.artist, style: TextStyle(fontSize: 18, color: Colors.grey)),
          SizedBox(height: 20),
          ProgressBar(progress: progress, total: totalDuration),
          PlayerControls(
            onPlayPause: () {
              togglePlayPause();
              updateProgress();
            },
            onNext: nextSong,
            onPrevious: previousSong,
            isPlaying: isPlaying,
          ),
        ],
      ),
    );
  }
}
