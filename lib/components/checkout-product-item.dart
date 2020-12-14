import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class CheckoutProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  General.buildTxt(txt: "ساعرض مثال حي لهذا", fontSize: 12.0),
                  General.sizeBoxVerical(20.0),
                  General.buildTxt(txt: "35 ر.س", isBold: true),
                  General.sizeBoxVerical(10.0),
                  General.buildTxt(txt: "الكمية : 1")
                ],
              ),
              Image.asset(
                'assets/imgs/hjab.png',
                width: 70.0,
                height: 80.0,
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
