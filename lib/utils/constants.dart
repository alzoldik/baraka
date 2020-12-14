import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class Constants {
  static const String baseUrl = "http://parakah.com/api/";
  static const Color OrangeColor = Color(0XFFD2BA7C);
  static const Color GreyColor = Color(0XFF646D82);
  static const Color PrimaryColor = Color(0XFF14a77e);
  static var textFieldDecoration = InputDecoration(
    labelText: "",
    labelStyle: TextStyle(color: Colors.black54),
    focusedBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Color(General.getColorHexFromStr('#757474')))),
    enabledBorder: UnderlineInputBorder(
        borderSide:
            BorderSide(color: Color(General.getColorHexFromStr('#B3B3B3')))),
  );
}
