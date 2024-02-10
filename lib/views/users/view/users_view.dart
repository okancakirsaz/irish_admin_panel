import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_admin_panel/core/base/view/base_view.dart';
import 'package:irish_admin_panel/core/consts/padding_consts.dart';
import 'package:irish_admin_panel/core/consts/radius_consts.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';
import 'package:irish_admin_panel/core/widgets/custom_statefull_button.dart';
import 'package:irish_admin_panel/views/users/models/user_data_model.dart';
import 'package:irish_admin_panel/views/users/viewmodel/users_viewmodel.dart';

import '../../../core/consts/color_consts/color_consts.dart';

part 'components/user_page.dart';
part 'components/user_profile_image.dart';
part 'components/user_posts.dart';
part 'components/user_scores.dart';
part 'components/user_favorite_foods.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<UsersViewModel>(
        viewModel: UsersViewModel(),
        onPageBuilder: (context, model) {
          return Observer(builder: (context) {
            if (model.isLoadSuccessful) {
              return buildUsers(model);
            } else {
              return Center(
                child: CircularProgressIndicator(
                    color: ColorConsts.instance.orange),
              );
            }
          });
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }

  Widget buildUsers(UsersViewModel viewModel) {
    return RefreshIndicator(
      backgroundColor: ColorConsts.instance.lightGray,
      color: ColorConsts.instance.orange,
      onRefresh: () async => viewModel.getUsers(),
      child: ListView.builder(
          itemCount: viewModel.allUsers.length,
          itemBuilder: (context, index) {
            final UserDataModel user = viewModel.allUsers[index];
            return Observer(builder: (context) {
              return Card(
                child: ListTile(
                  onTap: () => viewModel.navigateToUserPage(user, viewModel),
                  leading: UserProfileImage(profileImage: user.profileImage),
                  title: Text(
                    user.name!,
                    style: TextConsts.instance.regularBlack18Bold,
                  ),
                  subtitle: Text(
                    "Cinsiyet: ${user.gender!}, Tel: ${user.phoneNumber!}, E-Posta: ${viewModel.allUsers[index].email!}",
                    style: TextConsts.instance.regularBlack14,
                  ),
                  trailing: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 50,
                    color: ColorConsts.instance.black,
                  ),
                ),
              );
            });
          }),
    );
  }
}
