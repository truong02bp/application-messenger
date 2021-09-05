import 'package:flutter/material.dart';
import 'package:messenger_ui/widgets/custom_icon.dart';

class ReactionBar extends StatelessWidget {

  final Function callBack;
  ReactionBar({required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 240,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIcon(image: "assets/images/heart.png", onTap: (){
                callBack("heart");
              }),
              CustomIcon(image: "assets/images/haha.png", onTap: (){
                callBack("haha");
              }),
              CustomIcon(image: "assets/images/wow.png", onTap: (){
                callBack("wow");
              }),
              CustomIcon(image: "assets/images/sad.png", onTap: (){
                callBack("sad");
              }),
              CustomIcon(image: "assets/images/angry.png", onTap: (){
                callBack("angry");
              }),
            ],
          ),
        ),
      ),
    );
  }

}
