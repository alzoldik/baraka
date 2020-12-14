import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class WishItem extends StatefulWidget {
  final wishlistItem;

  WishItem({this.wishlistItem});

  @override
  _WishItemState createState() => _WishItemState();
}

class _WishItemState extends State<WishItem> {
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
                  General.buildTxt(
                      txt: widget.wishlistItem.product.priceBeforeDiscount
                          .toString(),
                      isBold: true)
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
              Row(
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    color: Constants.GreyColor,
                    size: 30.0,
                  ),
                  General.sizeBoxHorizontial(5.0),
                  General.buildTxt(txt: "نقل الي السلة", fontSize: 12.0)
                ],
              ),
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
          ),
          Divider()
        ],
      ),
    );
  }
}
