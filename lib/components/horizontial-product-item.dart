import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/models/product.dart';
import 'package:baraka/screens/product-details/product-details.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class HorizontialProductItem extends StatefulWidget {
  final Product product;

  HorizontialProductItem({this.product});

  @override
  _HorizontialProductItemState createState() => _HorizontialProductItemState();
}

class _HorizontialProductItemState extends State<HorizontialProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            ScaleTransationRoute(
                page: ProductDetailsScreen(
              product: widget.product,
            )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: Image.network(
                "${widget.product.images[0].url}",
                width: 90.0,
                height: 90.0,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    General.buildTxt(
                        txt: widget.product.name.toString(), fontSize: 13.0),
                    Icon(
                      Icons.favorite_border,
                      size: 30.0,
                    )
                  ],
                ),
                General.sizeBoxVerical(10.0),
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/imgs/star.png",
                      width: 20.0,
                    ),
                    General.sizeBoxHorizontial(5.0),
                    General.buildTxt(
                        txt: widget.product.reviews.averageRating.toString(),
                        color: Color(General.getColorHexFromStr('#EFCE4A'))),
                    General.sizeBoxHorizontial(10.0),
                    General.buildTxt(
                        txt:
                            " تقيمات${widget.product.reviews.total.toString()}",
                        color: Colors.black38)
                  ],
                ),
                General.sizeBoxVerical(5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    General.buildTxt(
                        txt: widget.product.priceAfterDiscountFormatted,
                        fontSize: 13.0,
                        isBold: true),
                    General.sizeBoxHorizontial(10.0),
                    widget.product.discountPercent > 0
                        ? General.buildTxt(
                            txt: widget.product.priceBeforeDiscountFormatted,
                            fontSize: 12.0,
                            isHaveLineThrough: true,
                            color: Colors.black38,
                          )
                        : Container()
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
