import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/cache/local_manager.dart';

import '../../widgets/error_dialog.dart';

abstract mixin class BaseViewModel {
  late BuildContext viewModelContext;
  void setContext(BuildContext context);
  LocaleManager localeManager = LocaleManager.instance;
  void init() {}
  final ScrollController defaultScrollController = ScrollController();

  showErrorDialog() {
    showDialog(context: viewModelContext, builder: (context) => ErrorDialog());
  }
}
