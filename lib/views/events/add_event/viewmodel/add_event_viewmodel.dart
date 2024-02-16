import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';
import 'package:irish_admin_panel/core/init/cache/local_keys_enums.dart';
import 'package:irish_admin_panel/views/events/add_event/service/add_event_service.dart';
import 'package:irish_admin_panel/views/events/models/event_model.dart';
import 'package:irish_admin_panel/views/main_view/view/main_view.dart';
import 'package:irish_admin_panel/views/menu/models/menu_item_model.dart';
import 'package:irish_admin_panel/views/menu/service/menu_service.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

part 'add_event_viewmodel.g.dart';

class AddEventViewModel = _AddEventViewModelBase with _$AddEventViewModel;

abstract class _AddEventViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await _fetchMenuItems();
  }

  AddEventService service = AddEventService();

  @observable
  bool isPhysicalEvent = false;

  TextEditingController eventName = TextEditingController();
  TextEditingController awardName = TextEditingController();
  List<DropdownMenuEntry> menuItemsAsDropdownEntry = [
    const DropdownMenuEntry(
        value: "Ödülsüz etkinlik", label: "Ödülsüz etkinlik")
  ];
  DateTime datePickerLastDate = DateTime(DateTime.now().year + 50);
  DateTime? selectedDate;
  Time? selectedTime;

  @action
  changeIsPhysicalEventState(bool value) {
    isPhysicalEvent = value;
    selectedDate = null;
    selectedTime = null;
    eventName.text = "";
    awardName.text = "";
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
        await _handleCreateEventRequest();
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

  Future<void> _handleCreateEventRequest() async {
    try {
      final EventModel? response = await service.createEvent(EventModel(
          isPysicalEvent: isPhysicalEvent,
          eventName: eventName.text,
          eventTime: _fetchDateForRequest(),
          eventId: const Uuid().v4(),
          isStarted: false,
          award: !isPhysicalEvent ? awardName.text : null,
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

  Future<void> _fetchMenuItems() async {
    List<dynamic>? cachedMenu =
        localeManager.getNullableJsonData(LocaleKeysEnums.menu.name);
    switch (cachedMenu) {
      case null:
        break;
      default:
        for (int i = 0; i <= cachedMenu.length - 1; i++) {
          menuItemsAsDropdownEntry.add(
            DropdownMenuEntry(
              value: cachedMenu[i]['name'],
              label: cachedMenu[i]['name'],
            ),
          );
        }
        break;
    }
  }

  Future<void> getAndFetchMenuFromDatabase() async {
    //Dependency Injection
    List<MenuItemModel>? response = await MenuServices().getAllMenu();
    if (response != null) {
      for (int i = 0; i <= response.length - 1; i++) {
        menuItemsAsDropdownEntry.add(
          DropdownMenuEntry(value: response[i].name, label: response[i].name!),
        );
      }
    } else {
      showErrorDialog();
    }
  }
}
