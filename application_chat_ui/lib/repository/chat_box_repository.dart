import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:messenger_ui/host_api.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/model/chat_box.dart';
import 'package:messenger_ui/repository/api_model.dart';
import 'package:messenger_ui/repository/api_repository.dart';

@singleton
class ChatBoxRepository {
  ApiRepository apiRepository = getIt<ApiRepository>();

  Future<List<ChatBox>> getAllChatBoxByUserId({required int userId, required int page, required int size}) async {
    ApiModel model = ApiModel(
        url: chatBoxUrl,
        params: {"userId": "$userId", "page" : "$page", "size" : "$size"},
        parse: (data) {
          return data.map<ChatBox>((json) => ChatBox.fromJson(json)).toList();
        });
    final res = await apiRepository.get(model);
    if (res != null) return res;
    return [];
  }

  Future<List<ChatBox>> getChatBoxMostMessage({required int userId, required int page, required int size}) async {
    ApiModel model = ApiModel(
        url: chatBoxUrl + "/most-message",
        params: {"userId": "$userId", "page" : "$page", "size" : "$size"},
        parse: (data) {
          return data.map<ChatBox>((json) => ChatBox.fromJson(json)).toList();
        });
    final res = await apiRepository.get(model);
    if (res != null) return res;
    return [];
  }

  Future<ChatBox> getChatBoxById({required int id, @required userId}) async {
    ApiModel model = ApiModel(
      url: chatBoxUrl + "/$id",
      params: {"userId" : "$userId"},
      parse: (json) => ChatBox.fromJson(json),
    );
    final res = await apiRepository.get(model);
    return res;
  }

  Future<void> createGroup({required Set<int> userIds}) async {
    String ids = "";
    userIds.forEach((element) {
      ids = ids + "$element,";
    });
    ids = ids.substring(0, ids.length - 1);
    ApiModel model = new ApiModel(
      url: chatBoxUrl,
      params: {"userIds": "${userIds.join(",")}"},
    );
    await apiRepository.post(model);
  }
}
