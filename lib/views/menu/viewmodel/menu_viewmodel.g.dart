// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MenuViewModel on _MenuViewModelBase, Store {
  late final _$isLoadSuccessfulAtom =
      Atom(name: '_MenuViewModelBase.isLoadSuccessful', context: context);

  @override
  bool get isLoadSuccessful {
    _$isLoadSuccessfulAtom.reportRead();
    return super.isLoadSuccessful;
  }

  @override
  set isLoadSuccessful(bool value) {
    _$isLoadSuccessfulAtom.reportWrite(value, super.isLoadSuccessful, () {
      super.isLoadSuccessful = value;
    });
  }

  late final _$allMenuAtom =
      Atom(name: '_MenuViewModelBase.allMenu', context: context);

  @override
  ObservableList<MenuItemModel> get allMenu {
    _$allMenuAtom.reportRead();
    return super.allMenu;
  }

  @override
  set allMenu(ObservableList<MenuItemModel> value) {
    _$allMenuAtom.reportWrite(value, super.allMenu, () {
      super.allMenu = value;
    });
  }

  late final _$pickedImageAtom =
      Atom(name: '_MenuViewModelBase.pickedImage', context: context);

  @override
  Uint8List? get pickedImage {
    _$pickedImageAtom.reportRead();
    return super.pickedImage;
  }

  @override
  set pickedImage(Uint8List? value) {
    _$pickedImageAtom.reportWrite(value, super.pickedImage, () {
      super.pickedImage = value;
    });
  }

  late final _$getMenuAsyncAction =
      AsyncAction('_MenuViewModelBase.getMenu', context: context);

  @override
  Future<void> getMenu() {
    return _$getMenuAsyncAction.run(() => super.getMenu());
  }

  late final _$getAllMenuFirstInitAsyncAction =
      AsyncAction('_MenuViewModelBase.getAllMenuFirstInit', context: context);

  @override
  Future<void> getAllMenuFirstInit() {
    return _$getAllMenuFirstInitAsyncAction
        .run(() => super.getAllMenuFirstInit());
  }

  late final _$pickImageFromGalleryAsyncAction =
      AsyncAction('_MenuViewModelBase.pickImageFromGallery', context: context);

  @override
  Future<void> pickImageFromGallery() {
    return _$pickImageFromGalleryAsyncAction
        .run(() => super.pickImageFromGallery());
  }

  @override
  String toString() {
    return '''
isLoadSuccessful: ${isLoadSuccessful},
allMenu: ${allMenu},
pickedImage: ${pickedImage}
    ''';
  }
}
