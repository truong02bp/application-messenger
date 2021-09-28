
import 'package:flutter/material.dart';
import 'package:messenger_ui/widgets/icon_without_background.dart';
import 'package:image_picker/image_picker.dart';

class GalleryIcon extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? color;
  final Function(List<XFile>? files, String type) solvePicked;

  GalleryIcon({required this.solvePicked, this.height, this.width, this.color});

  @override
  _GalleryIconState createState() => _GalleryIconState();

}

class _GalleryIconState extends State<GalleryIcon> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return IconWithoutBackground(
      image: "assets/images/gallery.png",
      width: widget.height != null ? widget.height! : 40,
      height: widget.width != null ? widget.width! : 40,
      color: widget.color != null ? widget.color! : Colors.black,
      onTap: showPickOption,
    );
  }

  void showPickOption() {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
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
                          getFromSource(ImageSource.gallery, "image");
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.image, color: Colors.white)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Pick your image',
                      style: TextStyle(fontSize: 12, color: Colors.black),
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
                        getFromSource(ImageSource.gallery, "video");
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.camera_alt_sharp, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Pick your video',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    )
                  ],
                ),
                Spacer(),
              ],
            ),
          );
        }
    );
  }

  void getFromSource(ImageSource source, String type) async {
    List<XFile>? files;
    XFile? file;
    if (type == "image") {
      if (source == ImageSource.gallery){
        files = await _picker.pickMultiImage();
      }
      if (source == ImageSource.camera) {
        file = await _picker.pickImage(source: source);
        if (file != null) {
          files = [file];
        }
      }
    }
    else
    if (type == "video") {
      file = await _picker.pickVideo(source: source);
    }
    if (files != null) {
      widget.solvePicked(files, "image");
    }
    else {
      if (file != null) {
        files = [file];
        widget.solvePicked(files, "video");
      }
    }
  }
}
