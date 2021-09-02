import 'package:injectable/injectable.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/dto/media_dto.dart';
import 'package:messenger_ui/model/media.dart';
import 'package:messenger_ui/repository/api_model.dart';
import 'package:messenger_ui/repository/api_repository.dart';
@singleton
class MediaRepository {
  ApiRepository apiRepository = getIt<ApiRepository>();

  Future<Media> upload({required MediaDto mediaDto}) async {
    ApiModel apiModel = ApiModel(
        url: mediaUrl,
        body: mediaDto,
        parse: (json){
          return Media.fromJson(json);
        }
    );
    Media media = await apiRepository.post(apiModel);
    return media;
  }

}