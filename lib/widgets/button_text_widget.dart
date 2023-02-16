import 'package:flutter/material.dart';

class ButtonTextWidget extends StatelessWidget {
  bool loading;
  String label;
 ButtonTextWidget({super.key,required this.label, this.loading=false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: loading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              label.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    );
  }
}
