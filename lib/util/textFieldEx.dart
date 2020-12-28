import 'package:flutter/material.dart';
import 'colorConverter.dart';

extension TextBorder on InputDecoration {
  static InputDecoration myDecoration(var hint, {String color = "#F5F5F5"}) {
    return InputDecoration(
        labelText: hint,
        border: shape(),
        filled: true,
        focusedBorder: shape(),
        enabledBorder: shape(),
        errorBorder: shape(),
        disabledBorder: shape(),
        fillColor: HexColor.fromHex(color));
  }
}

OutlineInputBorder shape() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(30.0),
    ),
    borderSide: BorderSide(color: HexColor.fromHex("#F5F5F5"), width: 0.0),
  );
}
