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
    _controller = VideoPlayerController.network(minioUrl + widget.url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();
    chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: _controller.value.aspectRatio,
      placeholder: Center(child: Image.asset("assets/images/loading.gif", height: 100, width: 100,)),
      autoPlay: true,
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
    return Container(
      constraints: new BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 4/7),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Chewie(
            controller: chewieController,
          ),
        ),
      ),
    );
  }
}
