import 'package:flutter/material.dart';
import 'package:messenger_ui/widgets/gallery_icon.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
                      image: AssetImage("assets/images/background5.jpg"),
                      fit: BoxFit.cover)),
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
              child: GalleryIcon(
                solvePicked: (files, type) {},
                height: 50,
                width: 50,
                color: Colors.white,
              ),
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
}
