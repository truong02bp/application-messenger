
import 'dart:io';

import 'package:messenger_ui/bloc_event/gallery_event.dart';
import 'package:messenger_ui/bloc_state/gallery_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {

  GalleryBloc() : super(GalleryState());

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    if (event is GalleryGetImage) {
      yield Loading();
      List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(type: RequestType.image, onlyAll: true);
      AssetPathEntity path = paths[0];
      List<AssetEntity> assets = await path.getAssetListPaged(event.page, 20);
      print('Length : ${assets.length}');
      List<File> images = [];
      for (AssetEntity asset in assets) {
        File? image = await asset.file;
        if (image != null) {
          images.add(image);
        }
      }
      print(images.length);
      yield GalleryGetImageSuccess(images: images);
    }
  }
}