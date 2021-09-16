import 'package:injectable/injectable.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/friend_ship.dart';
import 'package:messenger_ui/repository/api_model.dart';
import 'package:messenger_ui/repository/api_repository.dart';
@singleton
class FriendShipRepository {

  ApiRepository apiRepository = getIt<ApiRepository>();

  Future<List<FriendShip>> findByUserIdAndName({required int userId, required String name, required int page, required int size}) async {
    ApiModel model = new ApiModel(
        url: friendShipUrl,
        params: {"userId" : "$userId", "page" : "$page", "size" : "$size" , "name" : "$name"},
        parse: (data){
          return data.map<FriendShip>((json) => FriendShip.fromJson(json));
        }
    );
    final friendShips = await apiRepository.get(model);
    if (friendShips != null)
      return friendShips;
    return [];
  }

  Future<FriendShip> create({required int userId, required int friendId}) async {
    ApiModel model = new ApiModel(
        url: friendShipUrl,
        params: {"userId" : "$userId", "friendId" : "$friendId"},
        parse: (json) => FriendShip.fromJson(json)
    );
    final result = await apiRepository.post(model);
    return result;
  }
  
  Future<FriendShip> confirmFriendShip({required int id}) async {
    ApiModel model = new ApiModel(
        url: friendShipUrl + "/confirm",
        params: {"id" : "$id"},
        parse: (json) => FriendShip.fromJson(json)
    );
    final friendShip = await apiRepository.put(model);
    return friendShip;
  }

  void delete({required int id}) async {
    ApiModel model = new ApiModel(
        url: friendShipUrl,
        params: {"id" : "$id"},
    );
    await apiRepository.delete(model);
  }
}