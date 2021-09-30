
import 'dart:io';

class GalleryState {

}

class Loading extends GalleryState {

}

class GalleryGetImageSuccess extends GalleryState {
  List<File> images;

  GalleryGetImageSuccess({required this.images});
}