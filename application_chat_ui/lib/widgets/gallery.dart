import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/gallery_bloc.dart';
import 'package:messenger_ui/bloc_event/gallery_event.dart';
import 'package:messenger_ui/bloc_state/gallery_state.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'icon_without_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late GalleryBloc _galleryBloc;
  List<File> images = [];
  ScrollController _scrollController = ScrollController();
  int page = 0;
  int size = 21;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _galleryBloc = BlocProvider.of<GalleryBloc>(context);
    _galleryBloc.add(GalleryGetImage(page: 0, size: size));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _galleryBloc.add(GalleryGetImage(page: page+1, size: size));
        page += 1;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _galleryBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocListener(
      bloc: _galleryBloc,
      listener: (context, state) {
        print(state.runtimeType);
        if (state is GalleryGetImageSuccess) {
          images.addAll(state.images);
          print(images.length);
        }
      },
      child: IconWithoutBackground(
        image: "assets/images/gallery.png",
        width: 50,
        height: 50,
        color: Colors.white,
        onTap: () {
          showMaterialModalBottomSheet(
              context: context,
              expand: true,
              builder: (context) {
                return BlocBuilder(
                  bloc: _galleryBloc,
                  builder: (context, state) {
                    return SafeArea(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Wrap(
                          children: List.generate(images.length, (index) => Container(
                            height: width/3,
                            width: width/3,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(images[index]),
                                fit: BoxFit.cover
                              )
                            ),
                          )),
                        ),
                      ),
                    );
                  },
                );
              },
              backgroundColor: Colors.white);
        },
      ),
    );
  }
}
