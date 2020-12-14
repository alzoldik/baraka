import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class TackIndicator extends StatelessWidget {
  final bool isActive;
  final String status;
  TackIndicator({this.isActive = false, this.status = ""});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: <Widget>[
        Container(
          height: 6.0,
          decoration: BoxDecoration(
              color: isActive
                  ? Theme.of(context).accentColor
                  : Theme.of(context).accentColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0)),
        ),
        General.sizeBoxVerical(5.0),
        General.buildTxt(txt: status)
      ],
    ));
  }
}
