import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/theme_util.dart';

class InputWidget extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hint;
  Function? onDatePickerClick;
  bool isEnabled;
  bool isNumber;
  bool isDescription;
  InputWidget(
      {super.key,
      required this.controller,
      required this.hint,
      required this.label,
      this.onDatePickerClick,
      this.isEnabled = true,
      this.isNumber = false,
      this.isDescription = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeUtil().inputBoxDecorationShaddow(),
      child: TextFormField(
          decoration: ThemeUtil().textInputDecoration(label, hint),
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: [
            if (isNumber) FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: isNumber
              ? TextInputType.number
              : isDescription
                  ? TextInputType.multiline
                  : TextInputType.text,
          controller: controller,
          validator: (val) {
            if ((val!.isEmpty)) {
              return hint;
            }
          },
          maxLines:isDescription? 5: 2,
          keyboardAppearance: Brightness.light),
    );
  }
}
