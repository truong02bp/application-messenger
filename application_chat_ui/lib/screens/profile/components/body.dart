import 'package:flutter/material.dart';
import 'package:messenger_ui/widgets/gallery_icon.dart';
import 'package:messenger_ui/widgets/icon_without_background.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
                      image: AssetImage("assets/images/background3.jpg"),
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
                        return Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'aaa',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'aaa',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'aaa',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'aaa',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'aaa',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        );
                      },
                      backgroundColor: Colors.white);
                },
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
