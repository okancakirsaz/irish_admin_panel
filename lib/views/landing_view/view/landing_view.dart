import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/web_socket_manager.dart';
import 'package:irish_admin_panel/views/main_view/view/main_view.dart';

import '../../../core/base/view/base_view.dart';
import '../viewmodel/landing_viewmodel.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LandingViewModel>(
        viewModel: LandingViewModel(),
        onPageBuilder: (context, model) {
          return FutureBuilder(
              future: model.init(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const MainView();
                } else {
                  return const Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                }
              });
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {
          WebSocketManager.instance.disconnectFromSocket();
        });
  }
}
