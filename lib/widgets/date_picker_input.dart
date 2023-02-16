import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/theme_util.dart';

class DatePickerInput extends StatelessWidget {
  TextEditingController controller;
  String label;
  String hint;
  Function? onDatePickerClick;
  bool isEnabled;
  DatePickerInput(
      {super.key,
      required this.controller,
      required this.hint,
      required this.label,
      this.onDatePickerClick,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeUtil().inputDateBoxDecorationShaddow(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              decoration: ThemeUtil().dateInputDecoration(label, hint),
              readOnly: true,
              controller: controller,
              validator: (val){
                if ((val!.isEmpty)) {
                  return hint;
                }
                return null;
              },
              keyboardAppearance: Brightness.light,
              enabled: isEnabled,
            ),
          ),
          IconButton(
              onPressed: () {
                onDatePickerClick!();
              },
              icon: Icon(
                Icons.date_range,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
    );
  }
}
