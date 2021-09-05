import 'package:flutter/material.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:photo_view/photo_view.dart';
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
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, FullScreenImage.routeName, arguments: {"url" : "${widget.url}"});
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FadeInImage(
              placeholder: AssetImage("assets/images/loading.gif"),
              image: NetworkImage(minioUrl + widget.url),
            ),
          ),
        ),
    );
  }
}

class FullScreenImage extends StatelessWidget {

  static final String routeName = "/full-screen/image";

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String url = arguments["url"];
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen'),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(minioUrl + url),
      ),
    );
  }
}

