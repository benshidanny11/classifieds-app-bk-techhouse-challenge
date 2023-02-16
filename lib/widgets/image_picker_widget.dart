import 'dart:io';

import 'package:classfiedapp/utils/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  XFile? image;
  void Function() onTap;
  ImagePickerWidget({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: ThemeUtil().inputDateBoxDecorationShaddow(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          image == null
              ? Image.asset(
                  'assets/images/iconproduct.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.fitWidth,
                )
              : Image.file(
                  File(
                    image!.path,
                  ),
                  width: 60,
                  height: 60,
                  fit: BoxFit.fitWidth,
                ),
          IconButton(
              onPressed:onTap,
              icon:
                  Icon(Icons.add_a_photo, color: Theme.of(context).primaryColor))
        ],
      ),
    );
  }
}
