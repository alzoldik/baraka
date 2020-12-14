import 'package:baraka/utils/constants.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode node;
  final String textLabel, validation;
  final bool showAstrek;
  final FocusNode nextFocusNode;
  final num lines;
  InputField(
      {@required this.controller,
      @required this.node,
      this.nextFocusNode,
      this.lines,
      this.validation,
      this.showAstrek = true,
      @required this.textLabel});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        focusNode: node,
        style: TextStyle(fontSize: 20.0),
        keyboardAppearance: Brightness.light,
        textInputAction:
            nextFocusNode == null ? TextInputAction.done : TextInputAction.next,
        validator: validation != null
            ? (String val) {
                if (val.isEmpty) {
                  return validation;
                } else {
                  return null;
                }
              }
            : null,
        onFieldSubmitted: (val) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
        maxLines: lines ?? null,
        keyboardType: TextInputType.multiline,
        decoration: Constants.textFieldDecoration.copyWith(
            contentPadding: EdgeInsets.all(10.0),
            labelText: textLabel,
            labelStyle: TextStyle(fontSize: 14.0)),
      ),
    );
  }
}
