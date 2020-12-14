import 'package:baraka/components/product-item.dart';
import 'package:baraka/screens/home/slider.dart';
import 'package:baraka/screens/side-menu/side-menu.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:baraka/blocs/product_bloc.dart';
import 'package:provider/provider.dart';
import 'package:baraka/screens/product-details/product-details.dart';
import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/models/product.dart';

import 'categories-bar.dart';
import 'featured-products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
    productBloc.getRecentlyProduct();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  _openSideMenu() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.white),
          child: SideMenu(),
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(icon: Icon(Icons.menu), onPressed: _openSideMenu),
          actions: <Widget>[
            IconButton(
                icon: Image.asset(
                  'assets/imgs/basket.png',
                  width: 30.0,
                ),
                onPressed: () {})
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SliderSection(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      General.sizeBoxVerical(20.0),
                      CategoriesBar(),
                      General.sizeBoxVerical(20.0),
                      FeaturedProducts(),
                      buildRecentlyArrived()
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  buildRecentlyArrived() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        General.buildTxt(
            txt: "وصل حديثا",
            isBold: true,
            fontSize: 16.0,
            color: Colors.black54),
        General.sizeBoxVerical(10.0),
        Container(
          height: 250,
          child:
              Consumer<ProductBloc>(builder: (BuildContext context, state, __) {
            if (state.error != null) {
              return Center(child: General.buildTxt(txt: state.error));
            } else if (!state.waiting) {
              return buildProductList(state);
            } else {
              return Center(
                  child: General.customThreeBounce(context,
                      color: Theme.of(context).primaryColor, size: 30.0));
            }
          }),
        ),
      ],
    );
  }

  buildProductList(ProductBloc state) {
    return state.recentlyProducts.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.recentlyProducts.length,
            padding: EdgeInsets.only(
                bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () => openDetails(state.recentlyProducts[index]),
                  child: ProductItem(
                    product: state.recentlyProducts[index],
                  ));
            })
        : Container(
            child: Center(child: General.buildTxt(txt: "لا يوجد منتجات جديدة")),
          );
  }
}
