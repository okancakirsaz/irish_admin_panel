import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/network_manager.dart';
import 'package:irish_admin_panel/views/orders/models/order_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../core/consts/app_consts.dart';

final class OrdersServices extends NetworkManager {
  Future<List<OrderModel>?> getAllOrders() async {
    try {
      await handleWebSocket();
      final response = await network.get(AppConst.instance.orders);
      List<OrderModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(OrderModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<OrderModel?> deleteOrder(OrderModel data) async {
    try {
      final response = await network.post(AppConst.instance.deleteOrder,
          data: data.toJson());
      return OrderModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<OrderModel?> submitOrder(OrderModel data) async {
    try {
      final response = await network.post(AppConst.instance.changeOrderState,
          data: data.toJson());
      return OrderModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  //TODO: After backend fix handle here
  //For try
  handleWebSocket() async {
    final channel = WebSocketChannel.connect(Uri.parse("ws://localhost:3000"));
    await channel.ready;
    channel.sink.add("bir");
    channel.stream.listen((message) {
      print('Sunucudan gelen mesaj: $message');
    });
  }
}
