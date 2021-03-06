import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/authentication_request.dart';
import 'package:messenger_ui/model/dto/media_dto.dart';
import 'package:messenger_ui/model/dto/user_contact.dart';
import 'package:messenger_ui/model/dto/user_dto.dart';
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
    if (preferences.containsKey("token")) preferences.remove("token");
    AuthenticationRequest authenticationRequest =
    AuthenticationRequest(username: username, password: password);
    ApiModel model = new ApiModel(
        url: baseUrl + "/authenticate", body: authenticationRequest);
    final token = await apiRepository.post(model);
    if (token != null) {
      preferences.setString("token", token);
      User user = await getByToken();
      return user;
    }
    return null;
  }

  Future<dynamic> getByToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ApiModel model = new ApiModel(
        url: userUrl,
        parse: (json) {
          return User.fromJson(json);
        });
    try {
      User user = await apiRepository.get(model);
      preferences.setInt("userId", user.id);
      return user;
    }
    catch (exception) {
      if (preferences.containsKey("token"))
        preferences.remove("token");
    }
    return null;
  }

  Future<User> updateOnline({required int id, required bool online}) async {
    ApiModel apiModel = new ApiModel(
        url: userUrl + "/update-online",
        params: {"id": "$id", "online": "$online"},
        parse: (json) {
          return User.fromJson(json);
        });
    User user = await apiRepository.post(apiModel);
    return user;
  }

  Future<User> updateAvatar(
      {required int id, required MediaDto mediaDto}) async {
    ApiModel apiModel = new ApiModel(
        url: userUrl + "/avatar",
        params: {"userId": "$id"},
        body: mediaDto,
        parse: (json) {
          return User.fromJson(json);
        });
    User user = await apiRepository.put(apiModel);
    return user;
  }

  Future<List<String>> validate(
      {required String username, required String email}) async {
    ApiModel apiModel = new ApiModel(
        url: userUrl + "/validate",
        params: {"username": "$username", "email": "$email"},
        parse: (data) {
          return data.map<String>((json) => json as String).toList();
        });
    final rs = await apiRepository.post(apiModel);
    return rs;
  }

  Future<String> sendOtp({required String name, required String email}) async {
    ApiModel model = new ApiModel(
      url: userUrl + "/otp",
      params: {"name": "$name", "email": "$email"},
    );
    final rs = await apiRepository.post(model);
    return rs;
  }

  Future<User?> create({required UserDto userDto}) async {
    ApiModel model = new ApiModel(
        url: userUrl, body: userDto, parse: (json) => User.fromJson(json));
    final user = await apiRepository.post(model);
    if (user != null) return user;
    return null;
  }

  Future<List<UserContact>> findUserContact({required String name,
    required int userId,
    required int page,
    required int size}) async {
    ApiModel model = new ApiModel(
        url: userUrl + "/key",
        params: {
          "name": "$name",
          "page": "$page",
          "size": "$size",
          "userId": "$userId"
        },
        parse: (data) {
          return data
              .map<UserContact>((json) => UserContact.fromJson(json))
              .toList();
        });
    final userContacts = await apiRepository.get(model);
    if (userContacts != null) return userContacts;
    return [];
  }
}
