import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/gallery_bloc.dart';
import 'package:messenger_ui/constants/gallery_constants.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/widgets/gallery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Body extends StatefulWidget {

  final User user;

  Body({required this.user});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  late User user;
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 5,
          child: Stack(children: [
            Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: image != null ? FileImage(image!) : NetworkImage(minioUrl + user.avatar.url) as ImageProvider,
                      fit: BoxFit.cover)),
            ),
            Positioned(
                top: 45,
                left: 25,
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back)
                )
            ),
            Positioned(
                bottom: 35,
                left: 10,
                child: Text(
                  '${user.name}',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                )),
            Positioned(
                bottom: 12,
                left: 10,
                child: Text(
                  'online',
                  style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
                )),
            Positioned(
              bottom: 0,
              right: 10,
              child: BlocProvider(
                  create: (context) => GalleryBloc(),
                  child: Gallery(
                    type: GalleryConstants.image,
                    option: GalleryConstants.single,
                    color: Colors.white,
                    callBack: (files) {
                      onSelectImage(files);
                    },
                  )),
            ),
          ]),
        ),
        Flexible(
          flex: 6,
          child: Container(),
        )
      ],
    );
  }

  void onSelectImage(List<File> files) {
    setState(() {
      image = files[0];
    });
    Navigator.of(context).pop();
  }
}
