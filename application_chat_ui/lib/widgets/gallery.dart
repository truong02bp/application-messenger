import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/gallery_bloc.dart';
import 'package:messenger_ui/bloc_event/gallery_event.dart';
import 'package:messenger_ui/bloc_state/gallery_state.dart';
import 'package:messenger_ui/constants/color_constants.dart';
import 'package:messenger_ui/constants/gallery_constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'icon_without_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gallery extends StatefulWidget {
  final String type;
  final String option;
  final Color color;
  final Function(List<File> files) callBack;

  Gallery(
      {this.type = GalleryConstants.all,
      this.option = GalleryConstants.single,
      this.callBack = _defaultCallBack,
      this.color = Colors.white});

  @override
  _GalleryState createState() => _GalleryState();

  static void _defaultCallBack(List<File> files) {}
}

class _GalleryState extends State<Gallery> {
  late GalleryBloc _galleryBloc;
  List<File> medias = [];
  List<File> mediasSelected = [];
  Set<String> sources = Set();
  String sourceSelected = 'Recent';
  ScrollController _scrollController = ScrollController();
  int page = 0;
  int size = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _galleryBloc = BlocProvider.of<GalleryBloc>(context);
    _galleryBloc.add(GalleryGetSources());
    _galleryBloc.add(GalleryGetFromSource(
        page: 0, size: size, type: widget.type, source: sourceSelected));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _galleryBloc.add(GalleryGetFromSource(
            page: page + 1,
            size: size,
            type: widget.type,
            source: sourceSelected));
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
        if (state is GalleryGetSourcesSuccess) {
          sources.addAll(state.sources);
        }
        if (state is GalleryGetFromSourceSuccess) {
          medias.addAll(state.medias);
        }
      },
      child: IconWithoutBackground(
        image: "assets/images/gallery.png",
        width: 50,
        height: 50,
        color: widget.color,
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
                    bool isLoading = state is Loading;
                    return SafeArea(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(Icons.arrow_back)),
                              SizedBox(
                                width: 20,
                              ),
                              sources.isNotEmpty
                                  ? DropdownButton(
                                      value: sourceSelected,
                                      onChanged: (value) {
                                        sourceSelected = value as String;
                                        page = 0;
                                        medias.clear();
                                        _galleryBloc.add(GalleryGetFromSource(
                                            page: 0,
                                            size: size,
                                            type: widget.type,
                                            source: sourceSelected));
                                      },
                                      items: sources
                                          .map((source) => DropdownMenuItem(
                                              value: source,
                                              child: Text('$source')))
                                          .toList(),
                                    )
                                  : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: GridView.builder(
                                  controller: _scrollController,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  shrinkWrap: true,
                                  itemCount: medias.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        process(medias[index]);
                                      },
                                      child: Container(
                                        key: ValueKey(medias[index].path),
                                        margin:
                                            EdgeInsets.only(left: 3, bottom: 3),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: FileImage(medias[index]),
                                                fit: BoxFit.cover)),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          isLoading ? CircularProgressIndicator() : Container(),
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

  void process(File file) {
    if (widget.option == 'single') {
      mediasSelected = [file];
      widget.callBack(mediasSelected);
    } else if (widget.option == 'multi') {}
  }
}
