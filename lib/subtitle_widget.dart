import 'package:video_player/video_player.dart';

import 'subtitle.dart';
import 'package:flutter/material.dart';

class SubtitleWidget extends StatefulWidget {
  final List<Subtitle> subtitles;
  final int currentSubtitleIndex;
  final Function(int) onSubtitleIndexChanged;

  SubtitleWidget({
    required this.subtitles,
    required this.currentSubtitleIndex,
    required this.onSubtitleIndexChanged,
  });

  @override
  _SubtitleWidgetState createState() => _SubtitleWidgetState();
}

class _SubtitleWidgetState extends State<SubtitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < widget.subtitles.length; i++)
            GestureDetector(
              onTap: () => widget.onSubtitleIndexChanged(i),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300] ?? Colors.grey,
                    ),
                  ),
                ),
                child: Text(
                  widget.subtitles[i].text,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: i == widget.currentSubtitleIndex
                        ? Colors.blue
                        : Colors.black,
                    fontWeight: i == widget.currentSubtitleIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class Subtitle {
  final String text;
  final Duration startTime;
  final Duration endTime;

  Subtitle({
    required this.text,
    required this.startTime,
    required this.endTime,
  });
}

class VideoPlayerWithSubtitle extends StatefulWidget {
  final String videoUrl;
  final List<Subtitle> subtitles;

  VideoPlayerWithSubtitle({
    required this.videoUrl,
    required this.subtitles,
  });

  @override
  _VideoPlayerWithSubtitleState createState() => _VideoPlayerWithSubtitleState();
}

class _VideoPlayerWithSubtitleState extends State<VideoPlayerWithSubtitle> {
  late VideoPlayerController _controller;
  int _currentSubtitleIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player with Subtitle'),
      ),
      body: _controller.value.isInitialized
          ? Stack(
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SubtitleWidget(
              subtitles: widget.subtitles,
              currentSubtitleIndex: _currentSubtitleIndex,
              onSubtitleIndexChanged: (index) {
                setState(() {
                  _currentSubtitleIndex = index;
                  _controller.seekTo(widget.subtitles[index].startTime);
                });
              },
            ),
          ),
        ],
      )
          : Container(),
    );
  }
}
