import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItemWidget> {
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
                  General.buildTxt(txt: "ساعرض مثال حي لهذا"),
                  General.sizeBoxVerical(30.0),
                  General.buildTxt(txt: "35 ر.س", isBold: true)
                ],
              ),
              Image.asset(
                'assets/imgs/hjab.png',
                width: 60.0,
              )
            ],
          ),
          General.sizeBoxVerical(15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Constants.PrimaryColor)),
                child:
                    General.buildTxt(txt: "4", color: Constants.PrimaryColor),
              ),
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        color: Constants.GreyColor,
                        size: 30.0,
                      ),
                      General.sizeBoxHorizontial(5.0),
                      General.buildTxt(
                          txt: "نقل الي قائمة الامنيات", fontSize: 12.0)
                    ],
                  ),
                  General.sizeBoxHorizontial(10.0),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30.0,
                      ),
                      General.sizeBoxHorizontial(5.0),
                      General.buildTxt(
                          txt: "حذف", fontSize: 12.0, color: Colors.red)
                    ],
                  )
                ],
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
