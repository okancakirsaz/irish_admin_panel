import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/network_manager.dart';
import 'package:irish_admin_panel/views/orders/models/order_response_model.dart';

import '../../../core/consts/app_consts.dart';

final class OrdersServices extends NetworkManager {
  Future<List<OrderResponseModel>?> getAllOrders() async {
    try {
      final response = await network.get(AppConst.instance.orders);
      List<OrderResponseModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(OrderResponseModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
