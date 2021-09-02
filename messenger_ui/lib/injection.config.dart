// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'repository/api_repository.dart' as _i3;
import 'repository/chat_box_repository.dart' as _i4;
import 'repository/message_repository.dart' as _i5;
import 'repository/user_repository.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.ApiRepository>(_i3.ApiRepository());
  gh.singleton<_i4.ChatBoxRepository>(_i4.ChatBoxRepository());
  gh.singleton<_i5.MessageRepository>(_i5.MessageRepository());
  gh.singleton<_i6.UserRepository>(_i6.UserRepository());
  return get;
}
