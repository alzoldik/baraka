import 'package:baraka/components/checkout-product-item.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class CancelOrderScreen extends StatefulWidget {
  @override
  _CancelOrderScreenState createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  PersistentBottomSheetController _bottomSheetController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  num selectedReason = 0;
  bool acceptTerms = false;
  List<CancelationReason> reasons;
  @override
  void initState() {
    super.initState();
    reasons = [
      CancelationReason(reason: "غيرت رأيي", val: 0),
      CancelationReason(reason: "نسيت استخدام قسيمتي", val: 1),
      CancelationReason(reason: "بدون سبب", val: 2),
      CancelationReason(reason: "غيرت رأيي", val: 3),
      CancelationReason(reason: "نسيت استخدام قسيمتي", val: 4),
      CancelationReason(reason: "بدون سبب", val: 5),
      CancelationReason(reason: "غيرت رأيي", val: 6),
      CancelationReason(reason: "نسيت استخدام قسيمتي", val: 7),
      CancelationReason(reason: "بدون سبب", val: 8)
    ];
  }

  openBottomSheet() async {
    _bottomSheetController =
        _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.bottomCenter,
        color: Colors.black12.withOpacity(0.1),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  alignment: Alignment.topRight,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: reasons.map((reason) {
                        return Column(
                          children: [
                            RadioListTile(
                              value: reason.val,
                              groupValue: selectedReason,
                              title: General.buildTxt(
                                  txt: reason.reason, isCenter: false),
                              onChanged: (val) {
                                print("Radio Tile pressed $val");
                                _bottomSheetController.setState(() {
                                  selectedReason = val;
                                });
                              },
                              dense: true,
                              activeColor: Theme.of(context).accentColor,
                              selected: false,
                            ),
                            Divider()
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                )),
            Positioned(
              top: -20.0,
              left: 20.0,
              child: InkWell(
                onTap: () {
                  _bottomSheetController.close();
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(100.0)),
                  child: Icon(Icons.close),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: General.modalAppBar(context: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              General.buildTxt(
                  txt: "معرف الطلب : ESF434364643",
                  color: Theme.of(context).accentColor),
              General.sizeBoxVerical(10.0),
              General.buildTxt(txt: "حدد العناصر التي تريد الغاءها"),
              General.sizeBoxVerical(20.0),
              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: acceptTerms,
                                onChanged: (val) {},
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () => openBottomSheet(),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          color:
                                              Theme.of(context).accentColor)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      General.buildTxt(txt: "اختر سببا"),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Theme.of(context).accentColor,
                                      )
                                    ],
                                  ),
                                ),
                              ))
                            ],
                          ),
                          General.sizeBoxVerical(10.0),
                          CheckoutProductItem()
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

class CancelationReason {
  String reason;
  num val;
  CancelationReason({this.reason, this.val});
}
