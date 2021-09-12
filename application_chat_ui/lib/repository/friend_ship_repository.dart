import 'package:injectable/injectable.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/friend_ship.dart';
import 'package:messenger_ui/repository/api_model.dart';
import 'package:messenger_ui/repository/api_repository.dart';
@singleton
class FriendShipRepository {

  ApiRepository apiRepository = getIt<ApiRepository>();

  Future<FriendShip> create({required FriendShip friendShip}) async {
    ApiModel model = new ApiModel(
        url: friendShipUrl,
        body: friendShip,
        parse: (json) => FriendShip.fromJson(json)
    );
    final result = await apiRepository.post(model);
    return result;
  }
}