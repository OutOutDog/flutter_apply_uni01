import 'package:flutter/material.dart';
import 'package:untitled/subtitle_widget.dart';
import 'video_player_with_subtitle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: VideoPlayerWithSubtitle(
          videoUrl: 'assets/video/wordflows.json',
          subtitles: [
            Subtitle(
              text: 'Hello, world!',
              startTime: Duration(seconds: 0),
              endTime: Duration(seconds: 5),
            ),
            Subtitle(
              text: 'Welcome to Flutter!',
              startTime: Duration(seconds: 5),
              endTime: Duration(seconds: 10),
            ),
          ],
        ),
      ),
    );
  }
}
