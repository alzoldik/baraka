import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class OrderSummation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(General.getColorHexFromStr('#FAFAFA')),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                General.buildTxt(txt: "المجموع الفرعي 2 عنصر", fontSize: 11.0),
                General.buildTxt(txt: "80 ر.س", fontSize: 11.0)
              ],
            ),
            General.sizeBoxVerical(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                General.buildTxt(txt: "رسوم الشحن", fontSize: 11.0),
                General.buildTxt(txt: "40 ر.س", fontSize: 11.0)
              ],
            ),
            Divider(
              thickness: 0.3,
              color: Constants.GreyColor.withOpacity(0.6),
            ),
            General.sizeBoxVerical(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    General.buildTxt(
                        txt: "المجموع", isBold: true, fontSize: 11.0),
                    General.buildTxt(
                        color: Colors.grey.withOpacity(0.9),
                        txt: "(شامل ضريبة القيمة المضافة)",
                        fontSize: 10.0)
                  ],
                ),
                General.buildTxt(txt: "100 ر.س", fontSize: 11.0)
              ],
            ),
            General.sizeBoxVerical(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                General.buildTxt(
                    txt: "ضريبة القيمة المضافة المقدرة", fontSize: 11.0),
                General.buildTxt(txt: "5 ر.س", fontSize: 11.0)
              ],
            )
          ],
        ),
      ),
    );
  }
}
