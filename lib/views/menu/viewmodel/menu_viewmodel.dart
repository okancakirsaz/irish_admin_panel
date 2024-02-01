import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:irish_admin_panel/views/menu/service/menu_service.dart';
import 'package:irish_admin_panel/views/menu/view/components/menu_inputs.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/init/cache/local_keys_enums.dart';
import '../models/menu_item_model.dart';

part 'menu_viewmodel.g.dart';

final class MenuViewModel = _MenuViewModelBase with _$MenuViewModel;

abstract class _MenuViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await getAllMenuFirstInit();
  }

  @observable
  bool isLoadSuccessful = false;
  @observable
  ObservableList<MenuItemModel> allMenu = ObservableList<MenuItemModel>.of([]);

  @observable
  Uint8List? pickedImage;
  final MenuServices service = MenuServices();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController materialController = TextEditingController();

  @action
  Future<void> getMenu() async {
    try {
      final List<MenuItemModel>? response = await service.getAllMenu();
      await localeManager.setJsonData(LocaleKeysEnums.menu.name, response);
      allMenu = getCachedMenuAsModel();
    } catch (e) {
      debugPrint("$e");
      showErrorDialog();
    }
  }

  @action
  Future<void> getAllMenuFirstInit() async {
    if (localeManager.getNullableJsonData(LocaleKeysEnums.menu.name) == null) {
      await getMenu();
    } else {
      //Already in cache
      allMenu = getCachedMenuAsModel();
    }
    isLoadSuccessful = true;
  }

  ObservableList<MenuItemModel> getCachedMenuAsModel() {
    List<dynamic> cachedList =
        localeManager.getJsonData(LocaleKeysEnums.menu.name);
    ObservableList<MenuItemModel> convertedList =
        ObservableList<MenuItemModel>.of([]);
    for (var element in cachedList) {
      convertedList.add(MenuItemModel.fromJson(element));
    }
    return convertedList;
  }

  navigateToCreateOrEditElementView(MenuViewModel viewModel,
      [MenuItemModel? itemData]) {
    Navigator.push(
        viewModelContext,
        MaterialPageRoute(
            builder: (context) => MenuInputs(viewModel: viewModel)));
  }

  @action
  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    pickedImage = await image?.readAsBytes();
  }
}
