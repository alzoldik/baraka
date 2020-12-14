import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/components/checkout-product-item.dart';
import 'package:baraka/components/order-summation.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/components/track-indicator.dart';
import 'package:baraka/screens/cancel-order/cancel-order.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: General.arrowAppBar(),
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
                    General.sizeBoxVerical(20.0),
                    General.buildTxt(
                        txt: "معرف الطلب : ndsjkk3532dngs",
                        fontSize: 16.0,
                        isBold: true,
                        color: Theme.of(context).accentColor),
                    General.sizeBoxVerical(20.0),
                    General.buildTxt(
                      txt: "تاريخ الطلب: 28 يونيو 2020",
                      fontSize: 13.0,
                      color: Colors.black87.withOpacity(0.7),
                    ),
                    General.sizeBoxVerical(15.0),
                    General.sizeBoxVerical(15.0),
                  ],
                ),
              ),
              _trackerWidget(),
              General.sizeBoxVerical(20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildOrderAddress(),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone,
                          size: 15.0,
                        ),
                        General.sizeBoxHorizontial(3.0),
                        General.buildTxt(
                            txt: "رقم الجوال", isBold: true, fontSize: 16.0)
                      ],
                    ),
                    General.sizeBoxVerical(20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            ScaleTransationRoute(page: CancelOrderScreen()));
                      },
                      child: Container(
                        color: Color(General.getColorHexFromStr('#fcf2f5')),
                        child: DottedBorder(
                          color: Color(General.getColorHexFromStr('#EA5C5C')),
                          strokeWidth: 1,
                          radius: Radius.circular(5.0),
                          strokeCap: StrokeCap.butt,
                          borderType: BorderType.RRect,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(15.0),
                            child: General.buildTxt(
                              txt: "إلغاء عناصر من هذا الطلب",
                              fontSize: 14.0,
                              isBold: true,
                              color:
                                  Color(General.getColorHexFromStr('#EA5C5C')),
                            ),
                          ),
                        ),
                      ),
                    ),
                    General.sizeBoxVerical(20.0),
                    General.buildTxt(txt: "+966556102004", fontSize: 14.0),
                    General.sizeBoxVerical(20.0),
                    ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return CheckoutProductItem();
                        }),
                    General.buildTxt(
                        txt: "طريقة الدفع او السداد",
                        fontSize: 16.0,
                        isBold: true),
                    General.sizeBoxVerical(10.0),
                    Row(
                      children: [
                        Icon(Icons.attach_money),
                        General.buildTxt(
                          txt: "الدفع عند الاستلام",
                        )
                      ],
                    ),
                    General.sizeBoxVerical(10.0),
                    OrderSummation(),
                    General.sizeBoxVerical(50.0),
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
            isActive: true,
            status: "قيد التجهيز",
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
          children: <Widget>[
            Icon(
              Icons.location_city,
              size: 15.0,
            ),
            General.sizeBoxHorizontial(3.0),
            General.buildTxt(txt: "عنوان الشحن", isBold: true, fontSize: 16.0)
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
