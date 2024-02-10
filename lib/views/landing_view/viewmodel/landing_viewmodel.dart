import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/cache/local_keys_enums.dart';
import 'package:irish_admin_panel/core/init/web_socket_manager.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'landing_viewmodel.g.dart';

class LandingViewModel = _LandingViewModelBase with _$LandingViewModel;

abstract class _LandingViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  Future<int> init() async {
    WebSocketManager.instance.initializeSocketConnection();
    await localeManager.getSharedPreferencesInstance();
    await localeManager.removeData(LocaleKeysEnums.users.name);
    return 1;
  }
}
