import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_admin_panel/core/consts/color_consts/color_consts.dart';
import 'package:irish_admin_panel/core/consts/padding_consts.dart';
import 'package:irish_admin_panel/core/consts/radius_consts.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';
import 'package:irish_admin_panel/core/widgets/custom_button.dart';
import 'package:irish_admin_panel/core/widgets/custom_statefull_button.dart';
import 'package:irish_admin_panel/core/widgets/custom_text_field.dart';
import 'package:irish_admin_panel/views/menu/models/menu_item_model.dart';
import 'package:irish_admin_panel/views/menu/viewmodel/menu_viewmodel.dart';

class MenuInputs extends StatefulWidget {
  final MenuViewModel viewModel;
  final MenuItemModel? item;
  const MenuInputs({super.key, required this.viewModel, this.item});

  @override
  State<MenuInputs> createState() => _MenuInputsState();
}

class _MenuInputsState extends State<MenuInputs> {
  @override
  void initState() {
    widget.viewModel.checkPageOpenedForEdit(widget.item);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: 700,
          margin: PaddingConsts.instance.all20,
          padding: PaddingConsts.instance.all20,
          decoration: BoxDecoration(
              color: ColorConsts.instance.orange,
              borderRadius: RadiusConsts.instance.circularAll10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: buildLeftColumn()),
                  Expanded(child: buildRightColumn())
                ],
              ),
              CustomStateFullButton(
                  onPressed: () async =>
                      await widget.viewModel.setMenuElement(),
                  style: TextConsts.instance.regularBlack25Bold,
                  text: "Onayla",
                  width: 250,
                  height: 70),
            ],
          ),
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
            child: buildCustomTextField(
                widget.viewModel.nameController,
                "Element Adı",
                //Fetching read only parameter
                widget.viewModel.isPageOpenedForEdit ? true : null),
          ),
          Padding(
            padding: PaddingConsts.instance.bottom15,
            child:
                buildCustomTextField(widget.viewModel.priceController, "Ücret"),
          ),
          Row(
            children: <Widget>[
              CustomButton(
                  onPressed: () async =>
                      await widget.viewModel.pickImageFromGallery(),
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
                      image: widget.viewModel.pickedImage != null ||
                              widget.viewModel.isPageOpenedForEdit
                          ? DecorationImage(
                              fit: BoxFit.cover, image: provideSelectedImage())
                          : null),
                );
              }),
              Observer(builder: (context) {
                return makeUpdateImageInEditMode() ?? const SizedBox();
              })
            ],
          ),
          const SizedBox(height: 300)
        ],
      ),
    );
  }

  Widget buildRightColumn() {
    return Padding(
      padding: PaddingConsts.instance.horizontal30,
      child: Column(
        children: <Widget>[
          buildCustomTextField(
              widget.viewModel.materialController, "Materyal Adı"),
          const SizedBox(height: 20),
          CustomButton(
              onPressed: () => widget.viewModel.addMaterial(),
              style: TextConsts.instance.regularBlack20,
              text: "Ekle",
              width: 150,
              height: 50),
          SizedBox(
            height: 300,
            width: 400,
            child: buildAddedMaterials(),
          )
        ],
      ),
    );
  }

  Widget buildCustomTextField(TextEditingController controller, String title,
      [bool? isReadOnly]) {
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
              isReadOnly: isReadOnly,
              controller: controller,
              height: 50,
              style: TextConsts.instance.regularBlack18),
        ],
      ),
    );
  }

  Widget buildAddedMaterials() {
    return Observer(builder: (context) {
      return ListView.builder(
          itemCount: widget.viewModel.materials.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                  widget.viewModel.materials[index],
                  style: TextConsts.instance.regularBlack18,
                ),
                trailing: IconButton(
                  splashColor: ColorConsts.instance.black,
                  icon: Icon(
                    Icons.delete,
                    color: ColorConsts.instance.red,
                    size: 30,
                  ),
                  onPressed: () => widget.viewModel.deleteMaterial(index),
                ),
              ),
            );
          });
    });
  }

  ImageProvider provideSelectedImage() {
    if (widget.viewModel.isPageOpenedForEdit) {
      return NetworkImage(widget.item!.image!);
    } else {
      return MemoryImage(widget.viewModel.pickedImage!);
    }
  }

  Widget? makeUpdateImageInEditMode() {
    if (widget.viewModel.isPageOpenedForEdit) {
      return widget.viewModel.pickedImage != null
          ? Row(
              children: <Widget>[
                const Icon(Icons.arrow_right),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: RadiusConsts.instance.circularAll10,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(widget.viewModel.pickedImage!),
                    ),
                  ),
                )
              ],
            )
          : null;
    } else {
      return null;
    }
  }
}
