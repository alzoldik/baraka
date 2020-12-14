import 'package:baraka/components/product-item.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:baraka/blocs/product_bloc.dart';
import 'package:provider/provider.dart';
import 'package:baraka/screens/product-details/product-details.dart';
import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/models/product.dart';

class FeaturedProducts extends StatefulWidget {
  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  ProductBloc productBloc;

  openDetails(Product product) {
    Navigator.push(
        context,
        ScaleTransationRoute(
            page: ProductDetailsScreen(
          product: product,
        )));
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 200));
    productBloc = Provider.of<ProductBloc>(context, listen: false);
    productBloc.getFeaturedProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          General.buildTxt(
              txt: "المنتجات المميزة",
              isBold: true,
              fontSize: 16.0,
              color: Colors.black54),
          General.sizeBoxVerical(10.0),
          Container(
            height: 250,
            child: Consumer<ProductBloc>(
                builder: (BuildContext context, state, __) {
              if (state.error != null) {
                return Center(child: General.buildTxt(txt: state.error));
              } else if (!state.waiting) {
                print("asd");
                return buildProductList(state);
              } else {
                return Center(
                    child: General.customThreeBounce(context,
                        color: Theme.of(context).primaryColor, size: 30.0));
              }
            }),
          ),
        ],
      ),
    );
  }

  buildProductList(ProductBloc state) {
    return state.featuredProducts.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.featuredProducts.length,
            padding: EdgeInsets.only(
                bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () => openDetails(state.featuredProducts[index]),
                  child: ProductItem(
                    product: state.featuredProducts[index],
                  ));
            })
        : Container(
            child: Center(child: General.buildTxt(txt: "لا يوجد منتجات مميزة")),
          );
  }
}
