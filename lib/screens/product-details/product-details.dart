import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/blocs/product-review.dart';
import 'package:baraka/blocs/single-product-bloc.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/screens/checkout/phase-one.dart';
import 'package:baraka/screens/product-details/product-reviews.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baraka/models/product.dart';
import 'product-slider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  ProductDetailsScreen({@required this.product});
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  SingleProductBloc _singleProductBloc;
  ProductReviewBloc _productReviewBloc;
  PersistentBottomSheetController _bottomSheetController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 200));
    _singleProductBloc = Provider.of<SingleProductBloc>(context, listen: false);
    _productReviewBloc = Provider.of<ProductReviewBloc>(context, listen: false);
    _singleProductBloc.getSingleProduct(productId: widget.product.id);
    _productReviewBloc.getProductReviews(productId: widget.product.id, page: 1);
  }

  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text(
      "الوصف",
      style: TextStyle(color: Constants.PrimaryColor),
    ),
    1: Text(
      "المواصفات",
      style: TextStyle(color: Constants.PrimaryColor),
    ),
    2: Text(
      "التقييم والمراجعات",
      style: TextStyle(color: Constants.PrimaryColor),
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme:
            IconThemeData(color: Constants.GreyColor //change your color here
                ),
        elevation: 0.0,
      ),
      body: Consumer<SingleProductBloc>(
          builder: (BuildContext context, state, __) {
        if (state.error != null) {
          return Center(child: General.buildTxt(txt: state.error));
        } else if (!state.waiting) {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProductSlider(
                    product: state.product,
                  ),
                  General.sizeBoxVerical(20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        General.buildTxt(
                            txt: state.product.name, fontSize: 16.0),
                        General.sizeBoxVerical(10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/imgs/star.png",
                                  width: 15.0,
                                ),
                                General.sizeBoxHorizontial(5.0),
                                General.buildTxt(
                                    txt: state.product.reviews.averageRating,
                                    fontSize: 12.0,
                                    color: Color(
                                        General.getColorHexFromStr('#EFCE4A'))),
                                General.sizeBoxHorizontial(10.0),
                                General.buildTxt(
                                    txt:
                                        "(${state.product.reviews.total} تقييمات)",
                                    color: Colors.black38,
                                    fontSize: 13.0)
                              ],
                            ),
                            state.product.discountPercent > 0
                                ? Container(
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                        color: Color(General.getColorHexFromStr(
                                            '#EA5C5C')),
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: General.buildTxt(
                                        txt:
                                            "خصم ${state.product.discountPercent}%",
                                        fontSize: 13.0,
                                        color: Colors.white),
                                  )
                                : Container()
                          ],
                        ),
                        General.sizeBoxVerical(10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                General.buildTxt(
                                    txt:
                                        "${state.product.priceAfterDiscountFormatted}",
                                    fontSize: 13.0,
                                    isBold: true),
                                General.sizeBoxHorizontial(10.0),
                                state.product.discountPercent > 0
                                    ? General.buildTxt(
                                        txt:
                                            "${state.product.priceBeforeDiscountFormatted}",
                                        fontSize: 12.0,
                                        isHaveLineThrough: true,
                                        color: Colors.black38,
                                      )
                                    : Container()
                              ],
                            ),
                            General.buildTxt(
                                txt: "(شامل ضريبة القيمة المضافة)",
                                color: Colors.black26,
                                fontSize: 12.0)
                          ],
                        ),
                      ],
                    ),
                  ),
                  General.sizeBoxVerical(10.0),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    color: Color(General.getColorHexFromStr('#FAFAFA')),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/imgs/return-box.png",
                              width: 15.0,
                            ),
                            General.sizeBoxHorizontial(5.0),
                            General.buildTxt(
                                txt: "هذا المنتج لا يمكن استبداله او ارجاعه",
                                color: Constants.GreyColor)
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/imgs/shop.png",
                              width: 15.0,
                            ),
                            General.sizeBoxHorizontial(5.0),
                            Row(
                              children: <Widget>[
                                General.buildTxt(
                                    txt: "الكمية المتوفرة : ",
                                    color: Constants.GreyColor),
                                General.buildTxt(
                                    txt: "${state.product.quantity} قطعة",
                                    color: Theme.of(context).primaryColor)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  General.sizeBoxVerical(15.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoSlidingSegmentedControl(
                        groupValue: segmentedControlGroupValue,
                        padding: EdgeInsets.all(10.0),
                        children: myTabs,
                        onValueChanged: (i) {
                          setState(() {
                            segmentedControlGroupValue = i;
                          });
                        }),
                  ),
                  General.sizeBoxVerical(20.0),
                  Container(
                    padding: EdgeInsets.only(bottom: 120.0),
                    child: showAppropriateSegment(state.product),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
              child: General.customThreeBounce(context,
                  color: Theme.of(context).primaryColor, size: 30.0));
        }
      }),
      floatingActionButton: Consumer<SingleProductBloc>(
          builder: (BuildContext context, state, __) {
        if (!state.waiting) {
          return Container(
            child: Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: GestureDetector(
                        onTap: () => _openTopSheet(state),
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          decoration:
                              BoxDecoration(color: Constants.PrimaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.shopping_basket,
                                color: Colors.white,
                              ),
                              General.sizeBoxHorizontial(5.0),
                              General.buildTxt(
                                  txt: "اضف الي السلة", color: Colors.white)
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => openBottomSheet(state),
                      child: Container(
                        padding: EdgeInsets.all(11.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black38)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            General.buildTxt(
                                txt: "الكمية", color: Constants.GreyColor),
                            General.buildTxt(
                                txt: state.quantity.toString(),
                                color: Constants.GreyColor)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _openTopSheet(SingleProductBloc state) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 500),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180.0,
              color: Colors.white,
              child: Card(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: <Widget>[
                    General.sizeBoxVerical(60.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.do_not_disturb_alt),
                            General.sizeBoxHorizontial(10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                General.buildTxt(
                                    txt: state.product.name,
                                    isCenter: false,
                                    fontSize: 16.0),
                                General.sizeBoxVerical(6.0),
                                General.buildTxt(
                                    txt: 'أضف الي السلة',
                                    isCenter: false,
                                    color: Constants.PrimaryColor)
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            General.buildTxt(
                                txt: 'اجمالي السلة',
                                isCenter: false,
                                color: Colors.black45,
                                fontSize: 12.0),
                            General.sizeBoxVerical(6.0),
                            General.buildTxt(
                                txt:
                                    '${state.product.priceAfterDiscount * state.quantity} ريال',
                                isCenter: false,
                                isBold: true,
                                fontSize: 12.0,
                                color: Constants.GreyColor)
                          ],
                        )
                      ],
                    ),
                    General.sizeBoxVerical(15.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RoundButton(
                              onPress: () {},
                              color: Colors.white,
                              borderColor: Constants.GreyColor,
                              buttonTitle: General.buildTxt(
                                  txt: "مواصلة التسوق",
                                  color: Constants.GreyColor)),
                        ),
                        General.sizeBoxHorizontial(6.0),
                        Expanded(
                          child: RoundButton(
                              onPress: () {
                                Navigator.push(
                                    context,
                                    ScaleTransationRoute(
                                        page: CheckoutPhaseOne()));
                              },
                              color: Theme.of(context).accentColor,
                              buttonTitle: General.buildTxt(
                                  txt: "الدفع", color: Colors.white)),
                        )
                      ],
                    )
                  ],
                ),
              )),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<Offset>(
            begin: Offset(0, -1.0),
            end: Offset.zero,
          )),
          child: child,
        );
      },
    );
  }

  openBottomSheet(SingleProductBloc state) async {
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
                height: MediaQuery.of(context).size.height * 0.19,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      General.sizeBoxVerical(20.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: General.buildTxt(
                            txt: "الكمية",
                            isBold: true,
                            fontSize: 16.0,
                            color: Theme.of(context).accentColor),
                      ),
                      General.sizeBoxVerical(20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(Icons.add_circle_outline, size: 30.0),
                              onPressed: () {
                                state.increase();
                                _bottomSheetController.setState(() {});
                              }),
                          General.buildTxt(
                              txt: state.quantity.toString(),
                              isBold: true,
                              fontSize: 35.0,
                              color: Theme.of(context).accentColor),
                          IconButton(
                              icon:
                                  Icon(Icons.remove_circle_outline, size: 30.0),
                              onPressed: () {
                                _singleProductBloc.decrease();
                                _bottomSheetController.setState(() {});
                              }),
                        ],
                      )
                    ],
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

  showAppropriateSegment(Product product) {
    switch (segmentedControlGroupValue) {
      case 0:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              General.buildTxt(txt: "نظرة عامة", isBold: true),
              General.sizeBoxVerical(10.0),
              General.buildTxt(
                  fontSize: 13.0,
                  color: Constants.GreyColor,
                  isCenter: false,
                  lineHeight: 1.6,
                  txt: product.description),
            ],
          ),
        );
        break;
      case 1:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              General.buildTxt(txt: "نظرة sss", isBold: true),
              General.sizeBoxVerical(10.0),
              General.buildTxt(
                  fontSize: 13.0,
                  color: Constants.GreyColor,
                  isCenter: false,
                  lineHeight: 1.6,
                  txt:
                      "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص"),
            ],
          ),
        );
        break;
      case 2:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Consumer<ProductReviewBloc>(
                  builder: (BuildContext context, state, __) {
                if (state.error != null) {
                  return Center(child: General.buildTxt(txt: state.error));
                } else if (!state.waiting) {
                  return ProductReviews(
                    reviewResponse: state.reviewResponse,
                    product: _singleProductBloc.product,
                  );
                } else {
                  return Center(
                      child: General.customThreeBounce(context,
                          color: Theme.of(context).primaryColor, size: 30.0));
                }
              })
            ],
          ),
        );
        break;
      default:
    }
  }
}
