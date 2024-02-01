import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_admin_panel/core/base/view/base_view.dart';
import 'package:irish_admin_panel/core/widgets/custom_app_bar.dart';
import 'package:irish_admin_panel/views/menu/viewmodel/menu_viewmodel.dart';

import '../../../core/consts/color_consts/color_consts.dart';
import '../../../core/consts/padding_consts.dart';
import '../../../core/consts/radius_consts.dart';
import '../../../core/consts/text_consts.dart';
import '../models/menu_item_model.dart';

part 'components/menu_item.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuViewModel>(
        viewModel: MenuViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
            appBar: CustomAppBar(
              title: Text(
                "MENÜ",
                style: TextConsts.instance.regularWhite20Bold,
              ),
              actions: [
                IconButton(
                  onPressed: () =>
                      model.navigateToCreateOrEditElementView(model),
                  icon: const Icon(
                    Icons.add,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ).build(),
            body: Observer(builder: (context) {
              if (model.isLoadSuccessful) {
                return buildMenu(model);
              } else {
                return Center(
                  child: CircularProgressIndicator(
                      color: ColorConsts.instance.orange),
                );
              }
            }),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: () {});
  }

  Widget buildMenu(MenuViewModel viewModel) {
    return RefreshIndicator(
      backgroundColor: ColorConsts.instance.lightGray,
      color: ColorConsts.instance.orange,
      onRefresh: () async => viewModel.getMenu(),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: viewModel.allMenu.length,
          itemBuilder: (context, index) {
            return MenuItem(
              viewModel: viewModel,
              data: viewModel.allMenu[index],
            );
          }),
    );
  }
}
