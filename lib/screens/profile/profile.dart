import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/screens/address/address-list.dart';
import 'package:baraka/screens/orders/orders.dart';
import 'package:baraka/screens/payment-methods/payment-methods.dart';
import 'package:baraka/screens/profile/my-profile.dart';
import 'package:baraka/blocs/profile_bloc.dart';
import 'package:baraka/screens/wishe-list/wish-list.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum pages {
  My_ORDERS,
  WISH_LIST,
  DELIVERY_ADDRESSES,
  PAYMENT_METHODS,
  MY_PROFIIE
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc _profileBloc;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 100));
    _profileBloc = Provider.of<ProfileBloc>(context, listen: false);
    _profileBloc.getUserData();
  }

  _openPage({BuildContext context, pageName}) async {
    switch (pageName) {
      case pages.My_ORDERS:
        await Navigator.push(
            context, ScaleTransationRoute(page: OrdersScreen()));
        Navigator.pop(context);
        break;
      case pages.WISH_LIST:
        await Navigator.push(
            context, ScaleTransationRoute(page: WishListScreen()));
        Navigator.pop(context);
        break;
      case pages.DELIVERY_ADDRESSES:
        await Navigator.push(
            context, ScaleTransationRoute(page: AddressListScreen()));
        Navigator.pop(context);
        break;
      case pages.PAYMENT_METHODS:
        await Navigator.push(
            context, ScaleTransationRoute(page: PaymentMethodsScreen()));
        Navigator.pop(context);
        break;
      case pages.MY_PROFIIE:
        await Navigator.push(
            context, ScaleTransationRoute(page: MyProfileScreen()));
        Navigator.pop(context);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: General.arrowAppBar(),
        body: Consumer<ProfileBloc>(builder: (BuildContext context, state, __) {
          if (state.error != null) {
            return Center(child: General.buildTxt(txt: state.error));
          } else if (!state.waiting) {
            return Container(
              padding: EdgeInsets.all(15.0),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                children: <Widget>[
                  General.buildTxt(
                      txt:
                          "مرحبا ! ${state.user.userInfo.fname} ${state.user.userInfo.lname}",
                      isBold: true,
                      fontSize: 22.0,
                      isCenter: false),
                  General.buildTxt(
                      txt: state.user.userInfo.email, isCenter: false),
                  General.sizeBoxVerical(30.0),
                  General.buildTxt(
                      txt: "حسابي",
                      isCenter: false,
                      fontSize: 18.0,
                      isBold: true),
                  General.sizeBoxVerical(30.0),
                  _listItem(
                      title: "طلباتي",
                      onPress: () => _openPage(
                          context: context, pageName: pages.My_ORDERS)),
                  Divider(
                    color: Constants.GreyColor.withOpacity(0.8),
                  ),
                  General.sizeBoxVerical(10.0),
                  _listItem(
                      title: "قائمة الامنيات (2)",
                      onPress: () => _openPage(
                          context: context, pageName: pages.WISH_LIST)),
                  Divider(
                    color: Constants.GreyColor.withOpacity(0.8),
                  ),
                  General.sizeBoxVerical(10.0),
                  _listItem(
                      title: "عناوين التوصيل",
                      onPress: () => _openPage(
                          context: context,
                          pageName: pages.DELIVERY_ADDRESSES)),
                  Divider(
                    color: Constants.GreyColor.withOpacity(0.8),
                  ),
                  General.sizeBoxVerical(10.0),
                  _listItem(
                      title: "طرق الدفع",
                      onPress: () => _openPage(
                          context: context, pageName: pages.PAYMENT_METHODS)),
                  Divider(
                    color: Constants.GreyColor.withOpacity(0.8),
                  ),
                  General.sizeBoxVerical(10.0),
                  _listItem(
                      title: "ملفي الشخصي",
                      onPress: () => _openPage(
                          context: context, pageName: pages.MY_PROFIIE)),
                  General.sizeBoxVerical(30.0),
                  General.buildTxt(
                      txt: "الأعدادات",
                      isCenter: false,
                      fontSize: 18.0,
                      isBold: true),
                  General.sizeBoxVerical(30.0),
                  _listItem(title: "اللغة", onPress: () {}),
                  Divider(
                    color: Constants.GreyColor.withOpacity(0.8),
                  ),
                  General.sizeBoxVerical(10.0),
                  _listItem(title: "المساعدة", onPress: () {}),
                  Divider(
                    color: Constants.GreyColor.withOpacity(0.8),
                  ),
                  General.sizeBoxVerical(10.0),
                  _listItem(title: "اتصل بنا", onPress: () {}),
                  General.sizeBoxVerical(20.0),
                  Row(
                    children: <Widget>[
                      Icon(Icons.airline_seat_legroom_reduced),
                      General.sizeBoxHorizontial(6.0),
                      General.buildTxt(
                          txt: "تسجيل الخروج",
                          isBold: true,
                          fontSize: 16.0,
                          color: Colors.red)
                    ],
                  )
                ],
              ),
            );
          } else {
            return Center(
                child: General.customThreeBounce(context,
                    color: Theme.of(context).primaryColor, size: 30.0));
          }
        }));
  }

  _listItem({@required String title, @required Function onPress}) {
    return InkWell(
      onTap: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.shopping_cart,
                color: Constants.GreyColor,
              ),
              General.sizeBoxHorizontial(6.0),
              General.buildTxt(txt: title)
            ],
          ),
          Icon(
            Icons.arrow_forward,
            color: Constants.GreyColor,
            size: 20.0,
          )
        ],
      ),
    );
  }
}
