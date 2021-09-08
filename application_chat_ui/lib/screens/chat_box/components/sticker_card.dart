import 'package:flutter/material.dart';

class StickerCard extends StatelessWidget {

  final String url;

  StickerCard(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: new BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 1 / 3),
      padding: EdgeInsets.only(top: 10,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(url),
      ),
    );
  }
}
