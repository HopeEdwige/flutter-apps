import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_status_saver/models/status_item.dart';

class PreviewScreen extends StatefulWidget {
  final StatusItem item;

  const PreviewScreen({this.item, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PreviewScreenState();
}

class PreviewScreenState extends State<PreviewScreen> {
  VideoPlayerController _videoPlayerController;

  void initState() {
    super.initState();

    if (widget.item.type == StatusType.video) {
      _videoPlayerController = VideoPlayerController.file(File(widget.item.path))
        ..initialize().then((_) => Future.delayed(Duration.zero, () => _videoPlayerController.play())).then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
      _videoPlayerController.addListener(() {
        if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
          // refresh state to toggle the play and pause button. :)
          setState(() {});
        }
      });
    }
  }

  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.item.title),
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
                tag: widget.item.path,
                child: _buildPreview(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    if (widget.item.type == StatusType.video) {
      return _videoPlayerController.value.initialized ? _buildVideoPlayer() : CircularProgressIndicator();
    }

    return Image.file(
      File(widget.item.path),
      fit: BoxFit.cover,
    );
  }

  Widget _buildVideoPlayer() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.center,
            child: MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: const EdgeInsets.all(20),
              shape: CircleBorder(),
              child: Icon(
                _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 35,
              ),
              onPressed: () {
                setState(() {
                  if (_videoPlayerController.value.isPlaying) {
                    _videoPlayerController.pause();
                  } else {
                    print('Value => ${_videoPlayerController.value.position}');
                    print('Duration => ${_videoPlayerController.value.duration}');
                    if (_videoPlayerController.value.position == _videoPlayerController.value.duration) {
                      _videoPlayerController.seekTo(Duration.zero);
                    }
                    _videoPlayerController.play();
                  }
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
