import 'package:flutter/material.dart';
import 'package:irish_admin_panel/views/events/active_events/service/active_events_service.dart';
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
  init() async {
    await getActiveEvents();
  }

  final ActiveEventsService service = ActiveEventsService();

  @observable
  bool isPageLoaded = false;

  @observable
  ObservableList<EventModel> events = ObservableList<EventModel>.of([]);

  navigateToAddEventPage([EventModel? event]) {
    Navigator.push(viewModelContext,
        MaterialPageRoute(builder: (context) => AddEventView(event: event)));
  }

  @action
  Future<void> getActiveEvents() async {
    final List<EventModel>? response = await service.getEvents();
    if (response != null) {
      events = ObservableList<EventModel>.of(response);
      isPageLoaded = true;
    } else {
      showErrorDialog();
    }
  }

  @action
  Future<void> cancelEvent(String id) async {
    final EventModel? response =
        await service.deleteEvent(EventModel(eventId: id));
    if (response != null) {
      events.remove(response);
      await getActiveEvents();
    } else {
      showErrorDialog();
    }
  }

  Future<void> startEvent(EventModel event) async {
    final EventModel? response = await service.startEvent(event);
    if (response != null) {
      showErrorDialog("Etkinlik başlatıldı");
    } else {
      showErrorDialog();
    }
  }
}
