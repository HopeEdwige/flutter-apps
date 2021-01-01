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
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.center,
              child: _videoPlayerController.value.isPlaying
                  ? null
                  : Container(
                      padding: const EdgeInsets.all(20),
                      child: Icon(
                        Icons.play_arrow,
                        size: 35,
                        color: theme.textTheme.bodyText1.color,
                      ),
                      decoration: BoxDecoration(
                        color: theme.backgroundColor.withOpacity(.5),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
            ),
          )
        ],
      ),
      onTap: () {
        setState(() {
          VideoPlayerValue value = _videoPlayerController.value;
          if (value.isPlaying) {
            _videoPlayerController.pause();
          } else {
            if (value.position == value.duration) {
              _videoPlayerController.seekTo(Duration.zero);
            }
            _videoPlayerController.play();
          }
        });
      },
    );
  }
}
