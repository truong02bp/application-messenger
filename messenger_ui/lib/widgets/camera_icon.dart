
import 'package:flutter/material.dart';
import 'package:messenger_ui/widgets/icon_without_background.dart';
import 'package:image_picker/image_picker.dart';
class CameraIcon extends StatefulWidget {
  final Function(List<XFile>? files, String type) solvePicked;

  CameraIcon({required this.solvePicked});

  @override
  _CameraIconState createState() => _CameraIconState();
}

class _CameraIconState extends State<CameraIcon> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return IconWithoutBackground(
      image: "assets/images/camera.png",
      width: 40,
      height: 40,
      onTap: showPickOption,
    );
  }

  void showPickOption() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
                        getFromSource(ImageSource.camera, "image");
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.image)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Take image',
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
                      getFromSource(ImageSource.camera, "video");
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.photo_camera_front),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Take video',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              Spacer(),
            ],
          ),
        ));
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
