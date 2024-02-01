import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_admin_panel/core/consts/color_consts/color_consts.dart';
import 'package:irish_admin_panel/core/consts/padding_consts.dart';
import 'package:irish_admin_panel/core/consts/radius_consts.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';
import 'package:irish_admin_panel/core/widgets/custom_button.dart';
import 'package:irish_admin_panel/core/widgets/custom_text_field.dart';
import 'package:irish_admin_panel/views/menu/models/menu_item_model.dart';
import 'package:irish_admin_panel/views/menu/viewmodel/menu_viewmodel.dart';

//TODO:Contuniue with materials logic

class MenuInputs extends StatelessWidget {
  final MenuViewModel viewModel;
  final MenuItemModel? item;
  const MenuInputs({super.key, required this.viewModel, this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: PaddingConsts.instance.all20,
        padding: PaddingConsts.instance.all20,
        decoration: BoxDecoration(
            color: ColorConsts.instance.orange,
            borderRadius: RadiusConsts.instance.circularAll10),
        child: Row(
          children: <Widget>[
            Expanded(child: buildLeftColumn()),
            Expanded(child: buildRightColumn())
          ],
        ),
      ),
    );
  }

  Widget buildLeftColumn() {
    return Padding(
      padding: PaddingConsts.instance.horizontal30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.bottom10,
            child:
                buildCustomTextField(viewModel.nameController, "Element Adı"),
          ),
          Padding(
            padding: PaddingConsts.instance.bottom15,
            child: buildCustomTextField(viewModel.priceController, "Ücret"),
          ),
          Row(
            children: <Widget>[
              CustomButton(
                  onPressed: () async => await viewModel.pickImageFromGallery(),
                  style: TextConsts.instance.regularBlack18,
                  text: "Fotoğraf Yükle",
                  width: 200,
                  height: 50),
              const SizedBox(width: 10),
              Observer(builder: (context) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: RadiusConsts.instance.circularAll10,
                      image: viewModel.pickedImage != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(viewModel.pickedImage!))
                          : null),
                );
              })
            ],
          )
        ],
      ),
    );
  }

  Widget buildRightColumn() {
    return Padding(
      padding: PaddingConsts.instance.horizontal30,
      child: Column(
        children: <Widget>[
          buildCustomTextField(viewModel.materialController, "Materyal Adı"),
          const SizedBox(height: 20),
          CustomButton(
              onPressed: () {},
              style: TextConsts.instance.regularBlack20,
              text: "Ekle",
              width: 150,
              height: 50)
        ],
      ),
    );
  }

  Widget buildCustomTextField(TextEditingController controller, String title) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextConsts.instance.regularBlack20Bold,
          ),
          const SizedBox(height: 5),
          CustomTextField(
              controller: controller,
              height: 50,
              style: TextConsts.instance.regularBlack18),
        ],
      ),
    );
  }
}
