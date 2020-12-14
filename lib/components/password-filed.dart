import 'package:baraka/utils/constants.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String textLabel;
  final bool validation;
  final FocusNode node, nextFocusNode;
  final bool showAstrek;
  PasswordField(
      {@required this.controller,
      @required this.node,
      this.nextFocusNode,
      this.validation = false,
      this.showAstrek = true,
      @required this.textLabel});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        obscureText: true,
        focusNode: node,
        keyboardAppearance: Brightness.light,
        validator: validation
            ? (String val) {
                if (val.isEmpty) {
                  return "كلمة المرور مطلوبة";
                } else if (val.length < 8) {
                  return "يجب الا يقل رقم المرور عن ٨ احرف";
                } else {
                  return null;
                }
              }
            : null,
        onFieldSubmitted: (val) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
        textInputAction:
            nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
        decoration: Constants.textFieldDecoration.copyWith(
            contentPadding: EdgeInsets.all(10.0),
            labelText: textLabel,
            labelStyle: TextStyle(fontSize: 14.0)),
      ),
    );
  }
}
