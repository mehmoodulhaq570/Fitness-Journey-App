import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BicepsExercise extends StatefulWidget {
  @override
  _AbsExerciseState createState() => _AbsExerciseState();
}

class _AbsExerciseState extends State<BicepsExercise> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/B2.mp4")
      ..initialize().then((_) {
        setState(() {}); // Update UI after initialization
        _controller.setLooping(true); // Enable loop mode
        _controller.setVolume(0.0); // Mute the video
        _controller.play(); // Auto-play video
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        )
            : CircularProgressIndicator(), // Show loading spinner until video loads
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
