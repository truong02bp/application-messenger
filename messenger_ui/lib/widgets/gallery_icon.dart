
import 'package:flutter/material.dart';
import 'package:messenger_ui/widgets/icon_without_background.dart';
import 'package:image_picker/image_picker.dart';

class GalleryIcon extends StatefulWidget {
  final Function(List<XFile>? files) solvePicked;

  GalleryIcon({required this.solvePicked});

  @override
  _GalleryIconState createState() => _GalleryIconState();
}

class _GalleryIconState extends State<GalleryIcon> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return IconWithoutBackground(
      image: "assets/images/gallery.png",
      width: 40,
      height: 40,
      onTap: showPickOption,
    );
  }

  void showPickOption() {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              backgroundColor: Colors.white.withOpacity(0.9),
              title: Row(
                children: [
                  Spacer(),
                  Column(
                    children: [
                      FloatingActionButton(
                          onPressed: () {
                            _getFromSource(ImageSource.gallery, "image");
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.image)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pick your image',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          _getFromSource(ImageSource.gallery, "video");
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.photo_camera_front),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pick your video',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ));
  }

  void _getFromSource(ImageSource source, String type) async {
    List<XFile>? files;
    if (type == "image") {
      files = await _picker.pickMultiImage();
    }
    else if (type == "video") {
      if (source == ImageSource.camera) {

      }
    }
    if (files != null) {
      widget.solvePicked(files);
    }
  }
}
