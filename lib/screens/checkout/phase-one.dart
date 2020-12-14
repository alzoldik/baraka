import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/components/cart-item.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/components/wish-item.dart';
import 'package:baraka/screens/address/address-list.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class CheckoutPhaseOne extends StatefulWidget {
  @override
  _CheckoutPhaseOneState createState() => _CheckoutPhaseOneState();
}

class _CheckoutPhaseOneState extends State<CheckoutPhaseOne> {
  TextEditingController _controller;
  FocusNode _node;
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
                    ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CartItemWidget();
                        }),
                  ],
                ),
              ),
              _summationSection(),
              Container(
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
                        General.buildTxt(txt: "(5 عنصر)", color: Colors.grey)
                      ],
                    ),
                    General.sizeBoxVerical(20.0),
                    ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 120.0),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return WishItem();
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: RoundButton(
            onPress: () {
              Navigator.push(
                  context, ScaleTransationRoute(page: AddressListScreen()));
            },
            color: Theme.of(context).accentColor,
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
}
