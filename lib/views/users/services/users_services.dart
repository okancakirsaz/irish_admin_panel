import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/network_manager.dart';
import 'package:irish_admin_panel/views/users/models/user_data_model.dart';

import '../../../core/consts/app_consts.dart';
import '../models/boolean_single_response_model.dart';
import '../models/post_id_send_request_model.dart';
import '../models/user_id_send_request_model.dart';

final class UserServices extends NetworkManager {
  Future<List<UserDataModel>?> getAllUsers() async {
    try {
      final response = await network.get(AppConst.instance.users);
      List<UserDataModel> responseAsData = [];
      for (Map<String, dynamic> element in response.data) {
        responseAsData.add(UserDataModel.fromJson(element));
      }
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<UserDataModel?> blockOrUnblockUser(
      UserDataModel data, String path) async {
    try {
      final response = await network.post(path, data: data.toJson());
      return UserDataModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<BooleanSingleResponseModel?> removePost(
      PostIdSendRequestModel data) async {
    try {
      final response =
          await network.post(AppConst.instance.deletePost, data: data.toJson());
      return BooleanSingleResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<BooleanSingleResponseModel?> removeProfileImage(
      UserIdSendRequestModel data) async {
    try {
      final response = await network.post(AppConst.instance.deleteProfileImage,
          data: data.toJson());
      return BooleanSingleResponseModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
