import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/theme_util.dart';

class InputWidget extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hint;
  bool isDatePicker;
  Function? onDatePickerClick;
  bool isEnabled;
  InputWidget(
      {super.key,
      required this.controller,
      required this.hint,
      required this.label,
      this.isDatePicker = false,
      this.onDatePickerClick,
      this.isEnabled=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeUtil().inputBoxDecorationShaddow(),
      child: isDatePicker
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                      decoration: ThemeUtil().textInputDecoration(label, hint),
                      controller: controller,
                      validator: (val) {
                        if ((val!.isEmpty)) {
                          return hint;
                        }
                      },
                      keyboardAppearance: Brightness.light,
                      enabled: isEnabled,
                      ),
                ),
                IconButton(
                    onPressed: () {
                      onDatePickerClick!();
                    },
                    icon:  Icon(Icons.date_range, color: Theme.of(context).primaryColor,))
              ],
            )
          : TextFormField(
              decoration: ThemeUtil().textInputDecoration(label, hint),
              controller: controller,
              validator: (val) {
                if ((val!.isEmpty)) {
                  return hint;
                }
              },
              keyboardAppearance: Brightness.light),
    );
  }
}
