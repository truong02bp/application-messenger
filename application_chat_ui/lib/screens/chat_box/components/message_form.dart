import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/message_bloc.dart';
import 'package:messenger_ui/bloc_event/message_event.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/dto/message_dto.dart';
import 'package:messenger_ui/screens/chat_box/components/sticker_bar.dart';
import 'package:messenger_ui/widgets/camera_icon.dart';
import 'package:messenger_ui/widgets/gallery_icon.dart';
import 'package:messenger_ui/widgets/icon_without_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger_ui/widgets/popup_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MessageForm extends StatefulWidget {
  final ChatBox chatBox;

  MessageForm(this.chatBox);

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  TextEditingController textEditingController = TextEditingController();
  bool isTyping = false;
  late MessageBloc _messageBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messageBloc = BlocProvider.of<MessageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.withOpacity(0.15),
            ),
            child: TextFormField(
              controller: textEditingController,
              keyboardType: TextInputType.multiline,
              maxLength: null,
              maxLines: null,
              onChanged: (value) {
                setState(() {
                  if (value.isNotEmpty)
                    isTyping = true;
                  else
                    isTyping = false;
                });
              },
              decoration: InputDecoration(
                hintText: 'Type message',
                contentPadding:
                    const EdgeInsets.only(left: 20),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        StickerBar(
          chatBox: widget.chatBox,
          messageBloc: _messageBloc,
        ),
        SizedBox(
          width: 10,
        ),
        PopupMenuButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CameraIcon(
                      solvePicked: (files, type) {
                        _previewPicked(
                            title: '${files!.length} $type created',
                            files: files,
                            type: type);
                      },
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    GalleryIcon(
                      solvePicked: (files, type) {
                        _previewPicked(
                            title: '${files!.length} $type selected',
                            files: files,
                            type: type);
                      },
                    ),
                  ],
                ),
              )
            ];
          },
          child: Icon(
            Icons.attach_file,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        isTyping
            ? Row(
                children: [
                  IconWithoutBackground(
                    image: "assets/images/send.png",
                    color: Colors.white,
                    width: 25,
                    height: 25,
                    onTap: () {
                      _messageBloc.add(SendMessage(
                          messageDto: MessageDto(
                              isMedia: false,
                              content: textEditingController.text,
                              messengerId: widget.chatBox.currentUser.id,
                              chatBoxId: widget.chatBox.id)));
                      setState(() {
                        textEditingController.clear();
                      });
                    },
                  ),
                ],
              )
            : IconWithoutBackground(
                image: "assets/images/mic.png",
                color: Colors.white,
                width: 25,
                height: 25,
                onTap: () {},
              ),
      ],
    );
  }

  void _previewPicked(
      {required String title,
      required List<XFile> files,
      required String type}) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(child: Text(title)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              content: Container(
                height: 300,
                width: 350,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  key: UniqueKey(),
                  itemBuilder: (context, index) {
                    Widget body = Image.file(File(files[index].path));
                    if (type == "video") {
                      VideoPlayerController _controller =
                          VideoPlayerController.file(File(files[index].path));
                      _controller.initialize();
                      ChewieController chewieController = ChewieController(
                        videoPlayerController: _controller,
                        aspectRatio: _controller.value.aspectRatio,
                        placeholder: Image.asset("assets/images/loading.gif"),
                        autoPlay: true,
                        looping: true,
                        startAt: Duration(milliseconds: 500),
                      );
                      chewieController.setVolume(0.0);
                      body = Center(
                        child: AspectRatio(
                          aspectRatio: 1.1,
                          child: Chewie(
                            controller: chewieController,
                          ),
                        ),
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      padding: EdgeInsets.only(
                          left: 10, right: 5, bottom: 6, top: 6),
                      child: body,
                    );
                  },
                  itemCount: files.length,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      files.forEach((file) async {
                        List<int> bytes = await file.readAsBytes();
                        _messageBloc.add(SendMessage(
                            messageDto: MessageDto(
                                chatBoxId: widget.chatBox.id,
                                isMedia: true,
                                messengerId: widget.chatBox.currentUser.id,
                                bytes: base64Encode(bytes),
                                name: file.path.substring(
                                    file.path.lastIndexOf("/") + 1))));
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('Send'))
              ],
            ));
  }
}
