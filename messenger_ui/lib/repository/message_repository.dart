import 'package:injectable/injectable.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/message.dart';
import 'package:messenger_ui/repository/api_model.dart';
import 'package:messenger_ui/repository/api_repository.dart';

@singleton
class MessageRepository {
  ApiRepository apiRepository = getIt<ApiRepository>();

  Future<List<Message>> getMessageByChatBoxId(
      {required int chatBoxId, required int size, required int page}) async {
    ApiModel model = new ApiModel(
        url: messageUrl,
        params: {"chatBoxId": "$chatBoxId", "page": "$page", "size": "$size"},
        parse: (data) {
          return data.map<Message>((json) => Message.fromJson(json)).toList();
        });
    final messages = await apiRepository.get(model);
    return messages;
  }
}
