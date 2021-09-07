
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/authentication_request.dart';
import 'package:messenger_ui/model/user.dart';
import 'package:messenger_ui/repository/api_model.dart';
import 'package:messenger_ui/repository/api_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import '../host_api.dart';

@singleton
class UserRepository {
  ApiRepository apiRepository = getIt<ApiRepository>();

  Future<dynamic> login(String username, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("token"))
      preferences.remove("token");
    AuthenticationRequest authenticationRequest = AuthenticationRequest(username: username, password: password);
    ApiModel model = new ApiModel(
        url: baseUrl + "/authenticate", body: authenticationRequest);
    final token = await apiRepository.post(model);
    if (token != null) {
      preferences.setString("token", token);
      model = new ApiModel(url: userUrl, parse: (json){
        return User.fromJson(json);
      });
      User user = await apiRepository.get(model);
      preferences.setInt("userId", user.id);
      return user;
    }
    return null;
  }

  Future<User> updateOnline({required int id, required bool online}) async {
    ApiModel apiModel = new ApiModel(
        url: userUrl + "/update-online",
        params: {"id" : "$id", "online" : "$online"},
        parse: (json) {
          return User.fromJson(json);
        }
    );
    User user = await apiRepository.post(apiModel);
    return user;
  }


}