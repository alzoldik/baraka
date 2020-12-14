import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/components/checkout-product-item.dart';
import 'package:baraka/components/order-summation.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/models/payment-method.dart';
import 'package:baraka/screens/tack-order/phase-one.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class CheckoutPhaseTwoScreen extends StatefulWidget {
  @override
  _CheckoutPhaseTwoScreenState createState() => _CheckoutPhaseTwoScreenState();
}

class _CheckoutPhaseTwoScreenState extends State<CheckoutPhaseTwoScreen> {
  int selectedPaymentMethod;
  List<PaymentMethod> paymentMethods;
  @override
  void initState() {
    super.initState();
    selectedPaymentMethod = 0;
    paymentMethods = [
      PaymentMethod(
          id: "1",
          title: "الدفع عند الاستلام",
          value: 0,
          logo: "assets/imgs/cash.png"),
      PaymentMethod(
          id: "2", title: "Stripp", value: 1, logo: "assets/imgs/cash.png"),
      PaymentMethod(
          id: "3", title: "Apple pay", value: 2, logo: "assets/imgs/cash.png"),
      PaymentMethod(
          id: "4", title: "حوالة بنكية", value: 3, logo: "assets/imgs/cash.png")
    ];
  }

  setSelectedPaymentMethod(int val) {
    setState(() {
      selectedPaymentMethod = val;
    });
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
              ListView(
                shrinkWrap: true,
                children: paymentMethods.map((method) {
                  return RadioListTile(
                    value: method.value,
                    groupValue: selectedPaymentMethod,
                    title: General.buildTxt(txt: method.title, isCenter: false),
                    onChanged: (val) {
                      print("Radio Tile pressed $val");
                      setSelectedPaymentMethod(val);
                    },
                    dense: true,
                    activeColor: Theme.of(context).accentColor,
                    secondary: Image.asset(
                      "assets/imgs/cash.png",
                      width: 30.0,
                    ),
                    selected: false,
                  );
                }).toList(),
              ),
              OrderSummation(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    General.sizeBoxVerical(15.0),
                    General.buildTxt(
                        txt: "الشحن الي", fontSize: 16.0, isBold: true),
                    General.sizeBoxVerical(10.0),
                    Row(
                      children: <Widget>[
                        Icon(Icons.location_city),
                        General.sizeBoxHorizontial(3.0),
                        General.buildTxt(txt: "العنوان")
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
                    General.buildTxt(
                        txt: "راجع طلباتك", fontSize: 16.0, isBold: true),
                    General.sizeBoxVerical(20.0),
                    ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 100.0),
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
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: RoundButton(
            onPress: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  ScaleTransationRoute(page: TrackOrderPhaseOneScreen()),
                  (Route<dynamic> route) => false);
            },
            verticalPadding: 20.0,
            roundVal: 5.0,
            color: Theme.of(context).accentColor,
            buttonTitle: General.buildTxt(
                txt: "اعتماد الطلب", color: Colors.white, fontSize: 16.0)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
