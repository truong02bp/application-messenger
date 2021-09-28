import 'package:flutter/material.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageCard extends StatefulWidget {
  final String url;

  ImageCard({required this.url});

  @override
  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: new BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 4 / 7),
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, FullScreenImage.routeName,
              arguments: {"url": "${widget.url}"});
        },
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: 'image-card',
              child: CachedNetworkImage(
                imageUrl: minioUrl + widget.url,
                placeholder: (context, url) {
                  return Image.asset('assets/images/loading.gif');
                },
              ),
            )),
      ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  static final String routeName = "/full-screen/image";

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool showRollBack = true;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String url = arguments["url"];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  showRollBack = !showRollBack;
                });
              },
              child: Hero(
                tag: 'image-card',
                child: PhotoView(
                  imageProvider: NetworkImage(minioUrl + url),
                ),
              ),
            ),
            showRollBack ? Positioned(
                top: 15,
                left: 30,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 25,
                      height: 25,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Icon(Icons.arrow_back_ios)
                      )
                  ),
                )
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
