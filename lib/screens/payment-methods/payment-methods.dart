import 'package:baraka/models/payment-method.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<PaymentMethod> paymentMethods;
  @override
  void initState() {
    super.initState();
    paymentMethods = [
      PaymentMethod(
          id: "1",
          title: "*******892",
          subTitle: "Ahmed ali - Expire on: 10/20",
          logo: "assets/imgs/mastercard.png"),
      PaymentMethod(
          id: "2",
          title: "*******892",
          subTitle: "Ahmed ali - Expire on: 10/20",
          logo: "assets/imgs/visa.png")
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
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: General.buildTxt(
                    txt: "طريقة الدفع او السداد", fontSize: 16.0, isBold: true),
              ),
              ListView.builder(
                  itemCount: paymentMethods.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      color: Color(General.getColorHexFromStr('#D8D8D8'))
                          .withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                paymentMethods[index].logo ??
                                    "assets/imgs/visa.png",
                                width: 50.0,
                              ),
                              General.sizeBoxHorizontial(10.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  General.buildTxt(
                                      txt: paymentMethods[index].title),
                                  General.sizeBoxVerical(10.0),
                                  General.buildTxt(
                                      txt: paymentMethods[index].subTitle)
                                ],
                              )
                            ],
                          ),
                          Icon(
                            Icons.delete,
                            size: 40.0,
                            color: Colors.red,
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
