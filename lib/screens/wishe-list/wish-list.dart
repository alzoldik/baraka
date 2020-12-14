import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/blocs/wishlist_bloc.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/components/wish-item.dart';
import 'package:baraka/screens/address/address-list.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  TextEditingController _controller;
  FocusNode _node;
  WishlistBloc wishlistBloc;              ////- To access for widhlist Block

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  _init()async{
    await Future.delayed(Duration(milliseconds: 200));
    wishlistBloc =Provider.of<WishlistBloc>(context,listen: false);
    wishlistBloc.getWishlistProduct();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: General.arrowAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        General.buildTxt(
                            txt: "السلة", isBold: true, fontSize: 18.9),
                        General.sizeBoxHorizontial(5.0),
                        General.buildTxt(txt: "(2 عنصر)", color: Colors.grey)
                      ],
                    ),
                    General.sizeBoxVerical(20.0),
//                    Consumer<CardBloc>(
//                        builder: (BuildContext context, state, __) {
//                          if (state.error != null) {
//                            return Center(child: General.buildTxt(txt: state.error));
//                          } else if (!state.waiting) {
//                            print("asd");
//                            return buildCardList(state);
//                          } else {
//                            return Center(
//                                child: General.customThreeBounce(context,
//                                    color: Theme.of(context).primaryColor, size: 30.0));
//                          }
//                        }),

                  ],
                ),
              ),
              _summationSection(),
              Container(
                margin: EdgeInsets.only(bottom: 150),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: <Widget>[
                    General.sizeBoxVerical(20.0),
                    Row(
                      children: <Widget>[
                        General.buildTxt(
                            txt: "قائمة الامنيات",
                            isBold: true,
                            fontSize: 18.9),
                        General.sizeBoxHorizontial(5.0),
                        General.buildTxt(txt: "(5 عنصر )", color: Colors.grey)
                      ],
                    ),
                    General.sizeBoxVerical(20.0),
                    Container(
                      height: 300,
                      child: Consumer<WishlistBloc>(
                          builder: (BuildContext context, state, __) {
                            if (state.error != null) {
                              return Center(child: General.buildTxt(txt: state.error));
                            } else if (!state.waiting) {
                              print("asd");
                              return buildWishList(state);
                            } else {
                              return Center(
                                  child: General.customThreeBounce(context,
                                      color: Theme.of(context).primaryColor, size: 30.0));
                            }
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        child: RoundButton(
            onPress: () {
              Navigator.push(
                  context, ScaleTransationRoute(page: AddressListScreen()));
            },
            color: Theme.of(context).accentColor,
            roundVal: 5.0,
            verticalPadding: 20.0,
            buttonTitle: General.buildTxt(
                txt: "اشتري 2 عنصر ب 75 ر.س", color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _summationSection() {
    return Container(
      color: Color(General.getColorHexFromStr('#FAFAFA')),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            _buildPromoCode(),
            General.sizeBoxVerical(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                General.buildTxt(txt: "المجموع الفرعي 2 عنصر"),
                General.buildTxt(txt: "80 ر.س")
              ],
            ),
            General.sizeBoxVerical(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                General.buildTxt(txt: "رسوم الشحن"),
                General.buildTxt(txt: "40 ر.س")
              ],
            ),
            General.sizeBoxVerical(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    General.buildTxt(txt: "المجموع", isBold: true),
                    General.buildTxt(
                        color: Colors.grey.withOpacity(0.9),
                        txt: "(شامل ضريبة القيمة المضافة)",
                        fontSize: 10.0)
                  ],
                ),
                General.buildTxt(txt: "100 ر.س")
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildPromoCode() {
    return TextFormField(
        controller: _controller,
        focusNode: _node,
        keyboardAppearance: Brightness.light,
        validator: (String val) {},
        decoration: InputDecoration(
          labelText: "رمز قسيمة الخصم",
          labelStyle: TextStyle(fontSize: 14.0),
          contentPadding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
          isDense: true,
          filled: true,
          suffix: GestureDetector(
            onTap: () {
              print("asdd");
            },
            child: General.buildTxt(
                txt: "تطبيق القسيمة",
                fontSize: 13.0,
                color: Constants.PrimaryColor),
          ),
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ));
  }

  ////- To Build List Of Wishlist Products
  buildWishList(WishlistBloc state) {
    return state.wishlistProducts.isNotEmpty
        ? ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: state.wishlistProducts.length,
        padding: EdgeInsets.only(
            bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              //onTap: () {}),
              child: WishItem(
                wishlistItem: state.wishlistProducts[index],
              ));
        })
        : Container(
      child: Center(child: General.buildTxt(txt: "لا يوجد منتجات مميزة")),
    );
  }

//  buildCardList(CardBloc state) {
//    return state.cardListProducts.isNotEmpty
//        ? ListView.builder(
//        scrollDirection: Axis.vertical,
//        itemCount: state.cardListProducts.length,
//        padding: EdgeInsets.only(
//            bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
//        itemBuilder: (BuildContext context, int index) {
//          return GestureDetector(
//            //onTap: () {}),
//              child: CartItemWidget(
//                cardItem: state.cardListProducts[index],
//              ));
//        })
//        : Container(
//      child: Center(child: General.buildTxt(txt: "لا يوجد منتجات مميزة")),
//    );
//  }

}
