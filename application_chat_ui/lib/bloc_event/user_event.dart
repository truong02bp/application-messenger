import 'package:messenger_ui/model/dto/media_dto.dart';
import 'package:messenger_ui/model/user.dart';

class UserEvent {}

class SubmitLogin extends UserEvent {
  String username;
  String password;

  SubmitLogin({required this.username, required this.password});
}

class UpdateOnlineEvent extends UserEvent {}

class UpdateOfflineEvent extends UserEvent {
    bool isLogout;

    UpdateOfflineEvent({required this.isLogout});
}

class GetUserContact extends UserEvent {
  String name;
  int page;
  int size;

  GetUserContact({required this.name, required this.page, required this.size});
}

class GetUserEvent extends UserEvent {

}

class UpdateAvatar extends UserEvent {
  int userId;
  MediaDto mediaDto;

  UpdateAvatar({required this.userId, required this.mediaDto});
}
