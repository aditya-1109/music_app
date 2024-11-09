// lib/widgets/playlist_dialog.dart

import 'package:flutter/material.dart';

class PlaylistDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onConfirm;

  const PlaylistDialog({
    required this.controller,
    required this.onConfirm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create Playlist"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: "Playlist name"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text("Create"),
        ),
      ],
    );
  }
}
