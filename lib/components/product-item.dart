import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/blocs/product_bloc.dart';
import 'package:baraka/screens/product-details/product-details.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:baraka/blocs/localization_bloc.dart';
import 'package:baraka/models/product.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  ProductItem({this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    ProductBloc _productBloc = Provider.of<ProductBloc>(context);

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
        margin: EdgeInsets.symmetric(horizontal: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.black26)),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: FadeInImage.assetNetwork(
                      image: widget.product.images[0].url ?? "",
                      fit: BoxFit.cover,
                      placeholder: "assets/imgs/placeholder.png",
                      width: 120.0,
                    )),
                General.sizeBoxVerical(15.0),
                General.buildTxt(
                    txt: widget.product.name.toString(), fontSize: 13.0),
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
                            " تقيمات ${widget.product.reviews.total.toString()}",
                        color: Colors.black38)
                  ],
                ),
                General.sizeBoxVerical(10.0),
                Row(
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
                ),
              ],
            ),

            ////- Icon Favourite
            Positioned(
                left: 0.0,
                top: 4.0,
                child: GestureDetector(
                  onTap: () {
                    _productBloc.addProductToWishlist(product: widget.product);
                  },
                  child: !widget.product.isWaiting
                      ? Icon(
                          !widget.product.isFavourite
                              ? Icons.favorite_border
                              : Icons.favorite,
                          size: 30.0,
                        )
                      : General.customThreeBounce(context, color: Colors.black),
                )),

            /////- Discount Icon
            Positioned(
                right: 2.0,
                top: 4.0,
                child: widget.product.discountPercent > 0
                    ? Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: General.buildTxt(
                            txt: "خصم ${widget.product.discountPercent}%",
                            fontSize: 13.0,
                            color: Colors.white),
                      )
                    : Container())
          ],
        ),
      ),
    );
  }
}
