import 'package:flutter/material.dart';

import '../../../core/consts/app_consts.dart';
import '../../../core/init/network_manager.dart';

import '../models/menu_item_model.dart';

final class MenuServices extends NetworkManager {
  Future<List<MenuItemModel>?> getAllMenu() async {
    try {
      final response = await network.get(AppConst.instance.getMenu);
      List<MenuItemModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(MenuItemModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
