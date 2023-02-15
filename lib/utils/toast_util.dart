import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ToastUtil {
  static void showSuccessToast(String message) {
    Toast.show(
      message,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: Colors.green,
    );
  }
   static void showErrorToast(String message){
     Toast.show(
      message,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: Colors.red,
    );
  }
}
