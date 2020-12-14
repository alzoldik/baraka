import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/models/payment-method.dart';
import 'package:baraka/screens/orders/order-details.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int selectedPaymentMethod;
  String _selectedItem = "1";
  List<SortItem> items;
  List<PaymentMethod> paymentMethods;
  @override
  void initState() {
    super.initState();
    items = [
      SortItem(id: "1", name: "البداية"),
      SortItem(id: "2", name: "النهاية")
    ];
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
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    General.buildTxt(txt: "عرض الطلبات من", fontSize: 18.0),
                    Container(
                      height: 35.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border:
                              Border.all(color: Theme.of(context).accentColor)),
                      child: DropdownButton<String>(
                        items: items.map((item) {
                          return new DropdownMenuItem<String>(
                            value: item.id,
                            child: General.buildTxt(
                                txt: item.name,
                                color: Theme.of(context).accentColor),
                          );
                        }).toList(),
                        value: _selectedItem,
                        onChanged: (String val) {
                          setState(() {
                            _selectedItem = val;
                          });
                        },
                        underline: Container(),
                        // itemHeight: 20.0,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              General.sizeBoxVerical(20.0),
              _orderItem(context),
              _orderItem(context),
              _orderItem(context)
            ],
          ),
        ),
      ),
    );
  }

  _orderItem(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          decoration: BoxDecoration(
              color: Color(General.getColorHexFromStr('#FAFAFA'))),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      General.buildTxt(
                          txt: "معرف الطلب : 323523532636", isBold: true),
                      General.sizeBoxVerical(5.0),
                      General.buildTxt(
                        txt: "تاريخ الطلب: 28 يونيو 2020",
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          ScaleTransationRoute(page: OrderDetailsScreen()));
                    },
                    child: Row(
                      children: <Widget>[
                        General.buildTxt(
                            txt: "عرض التفاصيل",
                            fontSize: 12.0,
                            color: Theme.of(context).accentColor),
                        Icon(Icons.keyboard_arrow_left,
                            color: Theme.of(context).accentColor)
                      ],
                    ),
                  )
                ],
              ),
              Divider(
                color: Constants.GreyColor.withOpacity(0.8),
              ),
              Container(
                  height: 80.0,
                  child: ListView(
                    itemExtent: 250.0,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      productItem(),
                      productItem(),
                      productItem(),
                      productItem(),
                      productItem()
                    ],
                  ))
            ],
          ),
        ),
        General.sizeBoxVerical(20.0),
      ],
    );
  }

  productItem() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/imgs/hjab.png",
            width: 70.0,
            height: 70.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              General.buildTxt(txt: "ساعرض مثال حي لهذا"),
              General.sizeBoxVerical(20.0),
              General.buildTxt(
                  txt: "تم التوصيل",
                  isBold: true,
                  fontSize: 13.0,
                  color: Theme.of(context).accentColor)
            ],
          )
        ],
      ),
    );
  }
}

class SortItem {
  String name, id;
  SortItem({this.id, this.name});
}
