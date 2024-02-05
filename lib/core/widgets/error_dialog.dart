import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';

import '../consts/color_consts/color_consts.dart';

class ErrorDialog extends StatelessWidget {
  final String? reason;
  const ErrorDialog({super.key, this.reason});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorConsts.instance.darkGrey,
      content: Center(
        child: SizedBox(
          height: 150,
          child: Text(
            reason ?? "Bir sorun oluştu, tekrar deneyiniz.",
            style: TextConsts.instance.regularWhite16Bold,
          ),
        ),
      ),
    );
  }
}
