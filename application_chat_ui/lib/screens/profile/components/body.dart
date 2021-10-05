import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/gallery_bloc.dart';
import 'package:messenger_ui/bloc/user_bloc.dart';
import 'package:messenger_ui/bloc_event/user_event.dart';
import 'package:messenger_ui/bloc_state/user_state.dart';
import 'package:messenger_ui/constants/gallery_constants.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/model/dto/media_dto.dart';
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
  late UserBloc _userBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user;
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _userBloc,
      listener: (context, state) {
        if (state is UpdateUserSuccess) {
          setState(() {
            user = state.user;
          });
        }
      },
      child: Column(
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
      ),
    );
  }

  void onSelectImage(List<File> files) {
    setState(() {
      image = files[0];
    });
    Navigator.of(context).pop();
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        height: 40,
        width: 40,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: [
            Text('Are you sure for this update ?'),
            SizedBox(width: 20,),
            TextButton(onPressed: () async {
              List<int> bytes = await image!.readAsBytes();
              _userBloc.add(UpdateAvatar(userId: user.id, mediaDto: MediaDto(bytes: base64Encode(bytes),
                  name: files[0].path.substring(
                      files[0].path.lastIndexOf("/") + 1)
              )));
              Navigator.pop(context);
            }, child: Text('Yes')),
            TextButton(onPressed: (){
              setState(() {
                image = null;
              });
              Navigator.pop(context);
            }, child: Text('No', style: TextStyle(color: Colors.red),)),
          ],
        ),
      );
    });
  }
}
