import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final String url;

  VideoCard({required this.url});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late ChewieController chewieController;
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVideo();
  }

  Future<void> initVideo() async {
    _controller = VideoPlayerController.network(minioUrl + widget.url)
      ..setLooping(true);
    await _controller.initialize();
    chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: _controller.value.aspectRatio,
      placeholder: Center(
          child: Image.asset(
        "assets/images/loading.gif",
        height: 100,
        width: 100,
      )),
      showControls: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: false,
      looping: true,
      startAt: Duration(milliseconds: 500),
    );
    chewieController.setVolume(5.0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chewieController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initVideo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
              child: Image.asset(
            "assets/images/loading.gif",
            height: 100,
            width: 100,
          ));
        }
        return Container(
          constraints: new BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 2 / 3),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Chewie(
                controller: chewieController,
              ),
            ),
          ),
        );
      },
    );
  }
}
