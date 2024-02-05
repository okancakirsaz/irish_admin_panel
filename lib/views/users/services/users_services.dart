import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/network_manager.dart';
import 'package:irish_admin_panel/views/users/models/user_data_model.dart';

import '../../../core/consts/app_consts.dart';

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
}
