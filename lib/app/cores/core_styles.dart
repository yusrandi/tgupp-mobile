import 'package:flutter/material.dart';

import 'core_colors.dart';

class CoreStyles {
  static TextStyle uTitle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black);
  static TextStyle uSubTitle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: CoreColor.kTextColor);
  static TextStyle uHeading3 =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black);

  static InputDecoration buildInputDecoration(String hinttext) {
    return InputDecoration(
        border: InputBorder.none,
        hintText: hinttext,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 20));
  }
}
