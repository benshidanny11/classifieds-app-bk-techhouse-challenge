import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeUtil {
  InputDecoration textInputDecoration(
      [String lableText = "", String hintText = "", Icon? sufixIcon]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  InputDecoration customInputDecoration(
      [String lableText = "", String hintText = "", Icon? sufixIcon]) {
    return InputDecoration(
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.transparent,
      filled: true,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    );
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration inputCustomBoxDecorationShaddow() {
    return BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey));
  }

  BoxDecoration buttonBoxDecoration(BuildContext context,
      [String color1 = "", String color2 = ""]) {
    Color c1 = Theme.of(context).primaryColor;
    Color c2 = Theme.of(context).accentColor;
    if (color1.isEmpty == false) {
      c1 = HexColor(color1);
    }
    if (color2.isEmpty == false) {
      c2 = HexColor(color2);
    }

    return BoxDecoration(
      boxShadow: const [
        BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
      ],
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 1.0],
        colors: [
          c1,
          c2,
        ],
      ),
      color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(30),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(const Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(const Color(0xFFEB612A)),
      shadowColor:
          MaterialStateProperty.all(const Color.fromARGB(255, 189, 60, 9)),
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black38)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  TextStyle bodyTextStyle() =>
      const TextStyle(color: Color.fromARGB(136, 105, 105, 105));

  TextStyle appBarTitleStyle() => const TextStyle(color: Colors.white);

  TextStyle customTextStyle(
      Color color, double fontSize, FontWeight fontWeight) {
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }
}
