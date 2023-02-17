import 'package:classfiedapp/utils/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DropdownWidget extends StatelessWidget {
  final List<String> items;
  Function(String value) onDropDownChange;
  String selectedValue;
  DropdownWidget(
      {super.key,
      required this.items,
      required this.onDropDownChange,
      required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeUtil().inputCustomBoxDecorationShaddow(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product category',
              style: ThemeUtil().customTextStyle(
                  Color.fromARGB(116, 0, 0, 0), 13, FontWeight.w400),
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            DropdownButtonFormField<String>(
              value: selectedValue,
              decoration: const InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
              ),
              items: items.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                onDropDownChange(value.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
