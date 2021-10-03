import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/gallery_bloc.dart';
import 'package:messenger_ui/bloc_event/gallery_event.dart';
import 'package:messenger_ui/bloc_state/gallery_state.dart';
import 'package:messenger_ui/contants/color_constants.dart';
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
  List<String> sources = [];
  ScrollController _scrollController = ScrollController();
  int page = 0;
  int size = 20;
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
    return BlocListener(
      bloc: _galleryBloc,
      listener: (context, state) {
        if (state is GalleryGetImageSuccess) {
          images.addAll(state.images);
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              expand: false,
              builder: (context) {
                return BlocBuilder(
                  bloc: _galleryBloc,
                  builder: (context, state) {
                    return SafeArea(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20,),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                  child: Icon(Icons.arrow_back)
                              ),
                              SizedBox(width: 20,),
                              Text('Gallery', style: TextStyle(fontSize: 18, color: Colors.white),),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: GridView.builder(
                                  controller: _scrollController,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3
                                  ),
                                  shrinkWrap: true,
                                  itemCount: images.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(left: 3, bottom: 3),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(images[index]),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    );
                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              backgroundColor: primaryColor);
        },
      ),
    );
  }
}