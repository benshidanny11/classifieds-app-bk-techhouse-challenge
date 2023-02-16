import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/theme_util.dart';
import 'button_text_widget.dart';

class GoogleButton extends StatelessWidget {
  Function onTap;
  GoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ThemeUtil().buttonStyle(),
      child: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const FaIcon(FontAwesomeIcons.google),
            ButtonTextWidget(
              label: "Sign in",
            )
          ],
        ),
      ),
    );
  }
}
