import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/components/checkout-product-item.dart';
import 'package:baraka/components/order-summation.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/components/track-indicator.dart';
import 'package:baraka/screens/cancel-order/cancel-order.dart';
import 'package:baraka/screens/tabs/tabs.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class TrackOrderPhaseOneScreen extends StatefulWidget {
  @override
  _TrackOrderPhaseOneScreenState createState() =>
      _TrackOrderPhaseOneScreenState();
}

class _TrackOrderPhaseOneScreenState extends State<TrackOrderPhaseOneScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(30.0), // here the desired height
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          )),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    General.buildTxt(
                        txt: "شكرا لطلبك ، احمد",
                        fontSize: 16.0,
                        isBold: true,
                        color: Constants.PrimaryColor),
                    General.sizeBoxVerical(20.0),
                    General.buildTxt(
                      txt: "ستتلقي بريدا الكترونيا علي",
                      fontSize: 13.0,
                      color: Colors.black87.withOpacity(0.7),
                    ),
                    General.sizeBoxVerical(10.0),
                    General.buildTxt(
                      txt: "asd@gmail.com",
                      fontSize: 13.0,
                      color: Colors.black87.withOpacity(0.7),
                    ),
                    General.sizeBoxVerical(10.0),
                    General.buildTxt(
                      txt: "بمجر تاكيد طلبك",
                      fontSize: 13.0,
                      color: Colors.black87.withOpacity(0.7),
                    ),
                    General.sizeBoxVerical(15.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: RoundButton(
                          onPress: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                ScaleTransationRoute(
                                    page: TabsScreen(
                                  tabIndex: 0,
                                )),
                                (Route<dynamic> route) => false);
                          },
                          verticalPadding: 17.0,
                          roundVal: 5.0,
                          color: Theme.of(context).accentColor,
                          buttonTitle: General.buildTxt(
                              txt: "مواصلة التسوق",
                              color: Colors.white,
                              fontSize: 16.0)),
                    ),
                    General.sizeBoxVerical(15.0),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: General.buildTxt(
                    txt: "معرف الطلب : Edsnkj3434n34", isBold: true),
              ),
              General.sizeBoxVerical(10.0),
              _trackerWidget(),
              General.sizeBoxVerical(10.0),
              OrderSummation(),
              General.sizeBoxVerical(20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildOrderAddress(),
                    Row(
                      children: <Widget>[
                        Icon(Icons.phone),
                        General.sizeBoxHorizontial(3.0),
                        General.buildTxt(
                            txt: "رقم الجوال", isBold: true, fontSize: 16.0)
                      ],
                    ),
                    General.sizeBoxVerical(20.0),
                    General.buildTxt(txt: "+966556102004", fontSize: 14.0),
                    General.sizeBoxVerical(20.0),
                    General.buildTxt(
                        txt: "راجع طلباتك", fontSize: 16.0, isBold: true),
                    General.sizeBoxVerical(20.0),
                    ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CheckoutProductItem();
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _trackerWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          TackIndicator(
            isActive: true,
            status: "تم الطلب",
          ),
          General.sizeBoxHorizontial(10.0),
          TackIndicator(
            status: "",
          ),
          General.sizeBoxHorizontial(10.0),
          TackIndicator(
            status: "",
          ),
          General.sizeBoxHorizontial(10.0),
          TackIndicator(
            status: "",
          )
        ],
      ),
    );
  }

  _buildOrderAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.location_city),
                General.sizeBoxHorizontial(3.0),
                General.buildTxt(
                    txt: "عنوان الشحن", isBold: true, fontSize: 16.0)
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, ScaleTransationRoute(page: CancelOrderScreen()));
              },
              child: General.buildTxt(
                  txt: "إلغاء", color: Theme.of(context).accentColor),
            )
          ],
        ),
        General.sizeBoxVerical(10.0),
        General.buildTxt(
          txt: "محمد مختار",
          fontSize: 12.0,
        ),
        General.sizeBoxVerical(10.0),
        General.buildTxt(
            txt:
                "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص",
            isCenter: false,
            fontSize: 12.0,
            lineHeight: 1.5),
        General.sizeBoxVerical(15.0),
      ],
    );
  }
}
