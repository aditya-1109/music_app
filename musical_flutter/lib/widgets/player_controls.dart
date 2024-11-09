// lib/widgets/player_controls.dart

import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isPlaying;

  const PlayerControls({
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
    required this.isPlaying,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(Icons.skip_previous), onPressed: onPrevious),
        IconButton(
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: onPlayPause,
        ),
        IconButton(icon: Icon(Icons.skip_next), onPressed: onNext),
      ],
    );
  }
}
