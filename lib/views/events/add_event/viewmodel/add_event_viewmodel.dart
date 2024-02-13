import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';
import 'package:irish_admin_panel/views/events/add_event/service/add_event_service.dart';
import 'package:irish_admin_panel/views/events/models/event_model.dart';
import 'package:irish_admin_panel/views/main_view/view/main_view.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'add_event_viewmodel.g.dart';

class AddEventViewModel = _AddEventViewModelBase with _$AddEventViewModel;

abstract class _AddEventViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() {}

  AddEventService service = AddEventService();

  @observable
  bool isPhysicalEvent = false;

  TextEditingController eventName = TextEditingController();
  DateTime datePickerLastDate = DateTime(DateTime.now().year + 50);
  DateTime? selectedDate;
  Time? selectedTime;

  @action
  changeIsPhysicalEventState(bool value) {
    isPhysicalEvent = value;
    selectedDate = null;
    selectedTime = null;
    eventName.text = "";
  }

  selectDate(DateTime date) {
    selectedDate = date;
  }

  showTimeSelector() {
    Navigator.of(viewModelContext).push(
      showPicker(
        okText: "Onayla",
        cancelText: "İptal",
        cancelStyle: TextConsts.instance.regularRed14Bold,
        okStyle: TextConsts.instance.regularGreen14Bold,
        width: 400,
        context: viewModelContext,
        value: Time(hour: 8, minute: 0, second: 0),
        onChange: (time) {
          selectedTime = time;
        },
      ),
    );
  }

  Future<void> createEvent() async {
    switch (_validation()) {
      case true:
        await _handleCreateOrderRequest();
        break;

      case false:
        showErrorDialog("Lütfen eksik bilgi girmeyiniz.");
        break;
    }
  }

  bool _validation() {
    if (eventName.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> _handleCreateOrderRequest() async {
    try {
      final EventModel? response = await service.createEvent(EventModel(
          isPysicalEvent: isPhysicalEvent,
          eventName: eventName.text,
          eventTime: _fetchDateForRequest(),
          eventId: const Uuid().v4(),
          gameType: !isPhysicalEvent ? eventName.text : null));
      if (response == null) {
        showErrorDialog();
      } else {
        _returnToMainView();
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  _returnToMainView() {
    Navigator.pushAndRemoveUntil(
        viewModelContext,
        MaterialPageRoute(builder: (context) => const MainView()),
        (route) => false);
  }

  String _fetchDateForRequest() {
    int day = selectedDate!.day;
    int month = selectedDate!.month;
    int year = selectedDate!.year;
    return "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year ${selectedTime!.toTimeOfDay().format(viewModelContext)}";
  }
}
