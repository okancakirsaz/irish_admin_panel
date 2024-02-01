import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';

import '../consts/color_consts/color_consts.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConsts.instance.darkGrey,
      content: SizedBox(
        height: 150,
        child: Text(
          "Bir sorun oluştu, tekrar deneyiniz.",
          style: TextConsts.instance.regularWhite16Bold,
        ),
      ),
    );
  }
}
