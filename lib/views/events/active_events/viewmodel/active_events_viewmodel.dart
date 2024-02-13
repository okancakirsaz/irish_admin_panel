import 'package:flutter/material.dart';
import 'package:irish_admin_panel/views/events/add_event/view/add_event_view.dart';
import 'package:irish_admin_panel/views/events/models/event_model.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'active_events_viewmodel.g.dart';

class ActiveEventsViewModel = _ActiveEventsViewModelBase
    with _$ActiveEventsViewModel;

abstract class _ActiveEventsViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() {}

  navigateToAddEventPage([EventModel? event]) {
    Navigator.push(viewModelContext,
        MaterialPageRoute(builder: (context) => AddEventView(event: event)));
  }
}
