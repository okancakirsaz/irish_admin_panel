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

  //We are getting url parameter because this function using for update or set new menu element
  Future<MenuItemModel?> setMenuElement(MenuItemModel data, String url) async {
    try {
      final response = await network.post(url, data: data.toJson());
      return MenuItemModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<MenuItemModel?> deleteMenuElement(MenuItemModel data) async {
    try {
      final response = await network.post(AppConst.instance.deleteMenuElement,
          data: data.toJson());
      return MenuItemModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
