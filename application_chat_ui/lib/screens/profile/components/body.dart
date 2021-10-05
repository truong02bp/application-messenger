import 'dart:io';

import 'package:flutter/cupertino.dart';
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
            image == null
                ? CachedNetworkImage(
                    imageUrl: minioUrl + user.avatar.url,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                : Container(
                    constraints: BoxConstraints.expand(),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(image!), fit: BoxFit.cover)),
                  ),
            Positioned(
                top: 45,
                left: 25,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back))),
            Positioned(
                bottom: 35,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    '${user.name}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white),
                  ),
                )),
            Positioned(
                bottom: 12,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text(
                    'online',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white),
                  ),
                )),
            Positioned(
              bottom: -10,
              right: 5,
              child: BlocProvider(
                  create: (context) => GalleryBloc(),
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Gallery(
                      type: GalleryConstants.image,
                      option: GalleryConstants.single,
                      color: Colors.white,
                      callBack: (files) {
                        onSelectImage(files);
                      },
                    ),
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
