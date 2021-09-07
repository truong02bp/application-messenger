import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_ui/bloc/message_bloc.dart';
import 'package:messenger_ui/bloc_event/message_event.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/model/dto/message_dto.dart';

class StickerBar extends StatefulWidget {
  final ChatBox chatBox;
  final MessageBloc messageBloc;

  StickerBar({required this.chatBox, required this.messageBloc});

  @override
  _StickerBarState createState() => _StickerBarState();
}

class _StickerBarState extends State<StickerBar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                              "assets/stickers/a284160f-97bf-4064-929e-a9a77db90bf3.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                              "assets/stickers/4b13e688-c423-41b4-81b9-edc0da34bbda.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                              "assets/stickers/3deed353-4c5e-4278-954e-9351574c0e73.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                              "assets/stickers/0b527d30-a4ef-48fc-b6f6-87a6daf42b65.webp"),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/90b72dd5-1b07-41b1-8b94-ba4e2ee405fb.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/38a758bd-8294-4469-92fa-c9308789e517.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/95e4f75e-8571-4ba5-838b-e6c0f6388d17.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/539b012a-f2e3-48bb-9ba7-f1850ecf9147.webp"),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/867a845f-c849-46a0-9038-59f528145cbf.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/3136b6ce-7a64-4c0d-ab2c-8cf0cf9a9903.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/9045f02d-bd0d-4c11-873a-aa16a88e5adb.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/270462e5-37d1-44da-b2d2-7c2ccb93851b.webp"),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/a284160f-97bf-4064-929e-a9a77db90bf3.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/f8de81c9-bb50-4d4a-892e-ef13c58336c8.webp"),
                      Spacer(
                        flex: 1,
                      ),
                      buildItem(
                          image:
                          "assets/stickers/fe1d59a5-0a21-4a1f-bb25-5d3896b9a6da.webp"),
                      Spacer(
                        flex: 1,
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox(height: 20,)),
                ],
              );
            });
      },
      child: Container(
          height: 20, width: 20, child: Image.asset("assets/images/face.png")),
    );
    // );
  }

  Widget buildItem({required String image}) {
    return Flexible(
      flex: 3,
      child: InkWell(
        onTap: (){
          widget.messageBloc.add(SendMessage(
              messageDto: MessageDto(
                  isMedia: true,
                  name: "sticker",
                  content: image,
                  messengerId: widget.chatBox.currentUser.id,
                  chatBoxId: widget.chatBox.id)));
            Navigator.pop(context);
        },
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          child: Image.asset("$image", height: 100, width: 100,),
        ),
      ),
    );
  }
}