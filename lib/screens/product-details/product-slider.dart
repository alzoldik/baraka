import 'package:baraka/blocs/single-product-bloc.dart';
import 'package:baraka/models/product.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class ProductSlider extends StatelessWidget {
  final Product product;
  ProductSlider({@required this.product});

  _saveToWishList({SingleProductBloc state, BuildContext context}) {
    print("added to wishlist");
    state.addToWishList(productId: state.product.id);
  }

  @override
  Widget build(BuildContext context) {
    SingleProductBloc singleProductBloc =
        Provider.of<SingleProductBloc>(context);
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          height: 250.0,
          child: Swiper(
            autoplay: false,
            loop: false,
            pagination: SwiperPagination(),
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                "assets/imgs/hjab.png",
                fit: BoxFit.contain,
                height: 250.0,
              );
            },
            itemCount: product.images.length,
            viewportFraction: 1.0,
            scale: 0.9,
          ),
        ),
        Positioned(
            right: 20.0,
            top: 10.0,
            child: GestureDetector(
              onTap: () =>
                  _saveToWishList(state: singleProductBloc, context: context),
              child: !singleProductBloc.isWaiting
                  ? Icon(
                      !product.isFavourite
                          ? Icons.favorite_border
                          : Icons.favorite,
                      color: Constants.GreyColor,
                      size: 30.0,
                    )
                  : General.customThreeBounce(context,
                      color: Constants.GreyColor),
            )),
        Positioned(
            right: 20.0,
            top: 50.0,
            child: Icon(
              Icons.share,
              color: Constants.GreyColor,
              size: 30.0,
            ))
      ],
    );
  }
}
