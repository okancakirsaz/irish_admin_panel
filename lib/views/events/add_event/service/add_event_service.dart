import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/network_manager.dart';
import 'package:irish_admin_panel/views/events/models/event_model.dart';

import '../../../../core/consts/app_consts.dart';

final class AddEventService extends NetworkManager {
  Future<EventModel?> createEvent(EventModel data) async {
    try {
      final response = await network.post(AppConst.instance.createEvent,
          data: data.toJson());
      return EventModel.fromJson(response.data);
    } catch (_) {
      debugPrint(_.toString());
      return null;
    }
  }
}
