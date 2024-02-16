import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/consts/app_consts.dart';
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

  bool isPageOpenedForEdit = false;
  @observable
  ObservableList<MenuItemModel> allMenu = ObservableList<MenuItemModel>.of([]);

  @observable
  ObservableList<String> materials = ObservableList<String>.of([]);

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
    isPageOpenedForEdit = itemData != null ? true : false;
    Navigator.push(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => MenuInputs(
          viewModel: viewModel,
          item: itemData,
        ),
      ),
    );
  }

  @action
  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    pickedImage = await image?.readAsBytes();
  }

  @action
  addMaterial() {
    materials.add(materialController.text);
    materialController.text = "";
  }

  @action
  deleteMaterial(int index) {
    materials.removeAt(index);
  }

  Future<void> setMenuElement() async {
    if (validation()) {
      final MenuItemModel? response = await service.setMenuElement(
          MenuItemModel(
            name: nameController.text,
            price: priceController.text,
            materials: materials,
            image: pickedImage == null ? "" : base64Encode(pickedImage!),
          ),
          isPageOpenedForEdit
              ? AppConst.instance.updateMenuElement
              : AppConst.instance.createMenuElement);
      if (response == null) {
        showErrorDialog();
        return;
      }
      resetInputs();
      navigatorPop();
      await getMenu();
    }
  }

  resetInputs() {
    nameController.text = "";
    priceController.text = "";
    materialController.text = "";
    pickedImage = null;
    materials = ObservableList.of([]);
  }

  bool validation() {
    if (isPageOpenedForEdit) {
      return editModeValidation();
    } else {
      return createModeValidation();
    }
  }

  bool editModeValidation() {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        materials.isEmpty) {
      showErrorDialog("Eksik bilgi girdiniz, tekrar deneyiniz.");
      return false;
    } else {
      return true;
    }
  }

  bool createModeValidation() {
    if (pickedImage == null ||
        nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        materials.isEmpty) {
      showErrorDialog("Eksik bilgi girdiniz, tekrar deneyiniz.");
      return false;
    } else {
      return true;
    }
  }

  Future<void> deleteMenuElement(MenuItemModel data) async {
    final MenuItemModel? response = await service.deleteMenuElement(data);
    if (response == null) {
      showErrorDialog();
      return;
    }
    await getMenu();
  }

  checkPageOpenedForEdit(MenuItemModel? item) {
    if (item != null) {
      nameController.text = item.name!;
      priceController.text = item.price!;
      materials = ObservableList.of(item.materials!);
      //Must be not null for showing came image
      pickedImage = null;
    } else {
      nameController.text = "";
      priceController.text = "";
      materials = ObservableList.of([]);
      pickedImage = null;
    }
  }
}
