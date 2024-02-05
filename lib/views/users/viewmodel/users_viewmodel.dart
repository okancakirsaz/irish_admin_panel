import 'package:flutter/material.dart';
import 'package:irish_admin_panel/views/users/models/user_data_model.dart';
import 'package:irish_admin_panel/views/users/services/users_services.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../core/init/cache/local_keys_enums.dart';

part 'users_viewmodel.g.dart';

class UsersViewModel = _UsersViewModelBase with _$UsersViewModel;

abstract class _UsersViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await getAllUsersFirstInit();
  }

  final UserServices services = UserServices();
  @observable
  ObservableList<UserDataModel> allUsers = ObservableList<UserDataModel>.of([]);
  @observable
  bool isLoadSuccessful = false;

  Future<void> getUsers() async {
    final List<UserDataModel>? response = await services.getAllUsers();
    await localeManager.setJsonData(LocaleKeysEnums.users.name, response);
    allUsers = getCachedUsersAsModel();
    if (response == null) {
      showErrorDialog();
      return;
    } else {}
  }

  @action
  Future<void> getAllUsersFirstInit() async {
    if (localeManager.getNullableJsonData(LocaleKeysEnums.users.name) == null) {
      await getUsers();
    } else {
      //Already in cache
      allUsers = getCachedUsersAsModel();
    }
    isLoadSuccessful = true;
  }

  ObservableList<UserDataModel> getCachedUsersAsModel() {
    List<dynamic> cachedList =
        localeManager.getJsonData(LocaleKeysEnums.users.name);
    ObservableList<UserDataModel> convertedList =
        ObservableList<UserDataModel>.of([]);
    for (var element in cachedList) {
      convertedList.add(UserDataModel.fromJson(element));
    }
    return convertedList;
  }
}
