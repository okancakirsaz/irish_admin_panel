import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/network_manager.dart';

import '../../../../core/consts/app_consts.dart';
import '../../models/event_model.dart';

final class ActiveEventsService extends NetworkManager {
  Future<List<EventModel>?> getEvents() async {
    try {
      final response = await network.get(AppConst.instance.getActiveEvents);
      List<EventModel> responseAsData = [];
      (response.data as List<dynamic>).forEach((element) {
        responseAsData.add(EventModel.fromJson(element));
      });
      return responseAsData;
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }

  Future<EventModel?> deleteEvent(EventModel data) async {
    try {
      final response = await network.post(AppConst.instance.deleteEvent,
          data: data.toJson());
      return EventModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
