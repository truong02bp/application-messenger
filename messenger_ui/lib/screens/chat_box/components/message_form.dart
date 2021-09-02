import 'package:flutter/material.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/ultils/ultil.dart';
import 'package:messenger_ui/widgets/icon_without_background.dart';

class MessageForm extends StatefulWidget {
  final ChatBox chatBox;

  MessageForm(this.chatBox);

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  TextEditingController textEditingController = TextEditingController();
  bool isTyping = false;

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
                  contentPadding: EdgeInsets.only(left: 15, bottom: 5, top: 15),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                          height: 20,
                          width: 20,
                          child: Image.asset("assets/images/face.png")),
                    ),
                  )),
            ),
          ),
        ),
        isTyping == false
            ? Row(
                children: [
                  IconWithoutBackground(
                    image: "assets/images/camera.png",
                    width: 40,
                    height: 40,
                    onTap: () {},
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconWithoutBackground(
                    image: "assets/images/camera.png",
                    width: 40,
                    height: 40,
                    onTap: () {},
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconWithoutBackground(
                    image: "assets/images/mic.png",
                    width: 25,
                    height: 25,
                    onTap: () {},
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              )
            : Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  IconWithoutBackground(
                    image: "assets/images/like.png",
                    width: 30,
                    height: 30,
                    onTap: () {},
                  ),
                ],
              ),
      ],
    );
  }

}
