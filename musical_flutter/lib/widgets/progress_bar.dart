// lib/widgets/progress_bar.dart

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  final double total;

  const ProgressBar({required this.progress, required this.total, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress / total,
      backgroundColor: Colors.grey[300],
      color: Colors.blue,
    );
  }
}
