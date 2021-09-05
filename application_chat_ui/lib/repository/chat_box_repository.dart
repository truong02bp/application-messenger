import 'package:injectable/injectable.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/repository/api_model.dart';
import 'package:messenger_ui/repository/api_repository.dart';

@singleton
class ChatBoxRepository {
  ApiRepository apiRepository = getIt<ApiRepository>();
  
  Future<List<ChatBox>> getAllChatBoxByUserId({required int userId}) async {
    ApiModel model = ApiModel(
      url: chatBoxUrl,
      params: {"userId" : "$userId"},
      parse: (data) {
        return data.map<ChatBox>((json) => ChatBox.fromJson(json)).toList();
      }
    );
    final res = await apiRepository.get(model);
    if (res != null)
      return res;
    return [];
  }
  
}