import 'package:flutter/material.dart';
import 'package:irish_admin_panel/views/menu/view/menu_view.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../../../core/init/cache/local_keys_enums.dart';

part 'main_viewmodel.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await deleteCachedValues();
  }

  Future<void> deleteCachedValues() async {
    await localeManager.removeData(LocaleKeysEnums.menu.name);
  }

  @observable
  ObservableList<Widget> pages = ObservableList.of(<Widget>[
    const Scaffold(
      backgroundColor: Colors.blue,
    ),
    const MenuView(),
    const Scaffold(
      backgroundColor: Colors.pink,
    ),
  ]);

  @action
  Widget changePage(int index) {
    return pages[index];
  }
}
