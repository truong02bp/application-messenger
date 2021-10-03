import 'dart:io';

import 'package:messenger_ui/bloc_event/gallery_event.dart';
import 'package:messenger_ui/bloc_state/gallery_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(GalleryState());

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    if (event is GalleryGetSources) {
      List<AssetPathEntity> paths =
          await PhotoManager.getAssetPathList(type: RequestType.common);
      List<String> sources = paths.map((e) => e.name).toList();
      yield GalleryGetSourcesSuccess(sources: sources);
    }
    if (event is GalleryGetFromSource) {
      yield Loading();
      List<AssetPathEntity> paths = [];
      print(event.type);
      switch (event.type) {
        case 'image':
          paths = await PhotoManager.getAssetPathList(
              type: RequestType.image);
          break;
        case 'video':
          paths = await PhotoManager.getAssetPathList(
              type: RequestType.video);
          break;
        case 'all':
          paths = await PhotoManager.getAssetPathList(
              type: RequestType.video);
          break;
      }
      print('${paths.toString()}');
      for (AssetPathEntity path in paths) {
        print('${path.name} ${event.source}');
        if (path.name == event.source) {
          List<AssetEntity> assets = await path.getAssetListPaged(event.page, event.size);
          print('Length : ${assets.length}');
          List<File> images = [];
          for (AssetEntity asset in assets) {
            File? image = await asset.file;
            if (image != null) {
              images.add(image);
            }
          }
          print(images.length);
          yield GalleryGetFromSourceSuccess(medias: images);
          break;
        }
      }
    }
  }
}
