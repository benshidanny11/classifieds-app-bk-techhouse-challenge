import 'package:classfiedapp/utils/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DropdownWidget extends StatelessWidget {
  final List<String> items;
  Function(String value) onDropDownChange;
  String  selectedValue;
  DropdownWidget(
      {super.key, required this.items, required this.onDropDownChange, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: ThemeUtil().textInputDecoration(),
      items: items.map((value) {
        return DropdownMenuItem<String>(
          value:  value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        onDropDownChange(value.toString() );
      },
    );
  }
}
