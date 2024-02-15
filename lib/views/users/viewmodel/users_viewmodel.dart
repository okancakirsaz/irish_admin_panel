import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/consts/app_consts.dart';
import 'package:irish_admin_panel/views/users/models/user_data_model.dart';
import 'package:irish_admin_panel/views/users/services/users_services.dart';
import 'package:irish_admin_panel/views/users/view/users_view.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../core/init/cache/local_keys_enums.dart';
import '../models/boolean_single_response_model.dart';
import '../models/post_id_send_request_model.dart';
import '../models/post_model.dart';
import '../models/user_id_send_request_model.dart';

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
  @observable
  String? blockUserButtonText;

  @action
  Future<void> getUsers() async {
    final List<UserDataModel>? response = await services.getAllUsers();
    await localeManager.setJsonData(LocaleKeysEnums.users.name, response);
    allUsers = getCachedUsersAsModel();
    if (response == null) {
      showErrorDialog();
      return;
    }
  }

  //Calling at user_page.dart file in FutureBuilder
  Future<List<PostModel>?> getUserPosts(UserDataModel user) async {
    final List<PostModel>? response = await services.getUserPosts(user.token!);
    if (response != null) {
      return response;
    } else {
      showErrorDialog("Gönderiler getirilirken hata oluştu.");
      return null;
    }
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

  navigateToUserPage(UserDataModel user, UsersViewModel viewModel) {
    Navigator.push(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => UserPage(
          user: user,
          viewModel: viewModel,
        ),
      ),
    );
  }

  @action
  fetchBlockUserButtonText(bool isUserBlocked) {
    switch (isUserBlocked) {
      case true:
        blockUserButtonText = "Banı Kaldır";
        break;
      case false:
        blockUserButtonText = "Kullanıcıyı Banla";
        break;
    }
  }

  @action
  Future<void> handleBlockUser(UserDataModel user) async {
    //We must fetch posts again for successful delete.
    user.posts = await getUserPosts(user);
    final UserDataModel? response = await services.blockOrUnblockUser(
        user, _fetchBlockUserOrUnblockUserPath(user.isUserBanned!));
    if (response != null) {
      switch (user.isUserBanned!) {
        case true:
          unblockUser(user, response);
          break;
        case false:
          blockUser(user, response);
          break;
      }
    } else {
      showErrorDialog();
    }
  }

  blockUser(UserDataModel user, UserDataModel response) {
    navigatorPop();
    int userIndex = allUsers.indexOf(user);
    allUsers[userIndex].isUserBanned = response.isUserBanned;
    showErrorDialog("Kullanıcı banlandı!");
  }

  unblockUser(UserDataModel user, UserDataModel response) {
    navigatorPop();
    int userIndex = allUsers.indexOf(user);
    allUsers[userIndex].isUserBanned = response.isUserBanned;
    showErrorDialog("Kullanıcının banı kaldırıldı!");
  }

  String _fetchBlockUserOrUnblockUserPath(bool isBannedAlready) {
    switch (isBannedAlready) {
      case true:
        return AppConst.instance.unblockUser;
      case false:
        return AppConst.instance.blockUser;
    }
  }

  Future<void> deleteProfileImage(UserDataModel user) async {
    final BooleanSingleResponseModel? response =
        await services.removeProfileImage(
      UserIdSendRequestModel(
        uid: user.uid,
      ),
    );
    if (response != null) {
      if (response.isSuccess == false) {
        showErrorDialog();
      } else {
        await getUsers();
        navigatorPop();
      }
    }
  }

  Future<void> deletePost(UserDataModel user, String postId) async {
    final BooleanSingleResponseModel? response = await services
        .removePost(PostIdSendRequestModel(postId: postId, token: user.token));
    if (response != null && response.isSuccess!) {
      user.posts!.removeWhere((PostModel element) => element.id == postId);
      navigatorPop();
    } else {
      showErrorDialog();
    }
  }
}
