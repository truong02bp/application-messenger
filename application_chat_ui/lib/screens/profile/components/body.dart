import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/gallery_bloc.dart';
import 'package:messenger_ui/constants/gallery_constants.dart';
import 'package:messenger_ui/widgets/gallery.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? image;
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
                      image: image != null ? FileImage(image!) : AssetImage("assets/images/background3.jpg") as ImageProvider,
                      fit: BoxFit.cover)),
            ),
            Positioned(
                top: 35,
                left: 30,
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
                  'Nguyen Huy Truong',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
            Positioned(
                bottom: 12,
                left: 10,
                child: Text(
                  'online',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
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
