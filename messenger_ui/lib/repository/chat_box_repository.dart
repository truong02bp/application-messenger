import 'package:injectable/injectable.dart';
import 'package:messenger_ui/injection.dart';
import 'package:messenger_ui/repository/api_repository.dart';

@singleton
class ChatBoxRepository {
  ApiRepository apiRepository = getIt<ApiRepository>();

}