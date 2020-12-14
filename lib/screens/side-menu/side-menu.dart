import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/screens/address/address-list.dart';
import 'package:baraka/screens/orders/orders.dart';
import 'package:baraka/screens/payment-methods/payment-methods.dart';
import 'package:baraka/screens/profile/my-profile.dart';
import 'package:baraka/screens/wishe-list/wish-list.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

enum pages {
  My_ORDERS,
  WISH_LIST,
  DELIVERY_ADDRESSES,
  PAYMENT_METHODS,
  MY_PROFIIE
}

class SideMenu extends StatelessWidget {
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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        children: <Widget>[
          General.sizeBoxVerical(70.0),
          General.buildTxt(
              txt: "مرحبا ! محمد مختار",
              isBold: true,
              fontSize: 22.0,
              isCenter: false),
          General.buildTxt(txt: "asd@gmail.com", isCenter: false),
          General.sizeBoxVerical(30.0),
          General.buildTxt(
              txt: "حسابي", isCenter: false, fontSize: 18.0, isBold: true),
          General.sizeBoxVerical(30.0),
          _listItem(
              title: "طلباتي",
              onPress: () =>
                  _openPage(context: context, pageName: pages.My_ORDERS)),
          Divider(
            color: Constants.GreyColor.withOpacity(0.8),
          ),
          General.sizeBoxVerical(10.0),
          _listItem(
              title: "قائمة الامنيات (2)",
              onPress: () =>
                  _openPage(context: context, pageName: pages.WISH_LIST)),
          Divider(
            color: Constants.GreyColor.withOpacity(0.8),
          ),
          General.sizeBoxVerical(10.0),
          _listItem(
              title: "عناوين التوصيل",
              onPress: () => _openPage(
                  context: context, pageName: pages.DELIVERY_ADDRESSES)),
          Divider(
            color: Constants.GreyColor.withOpacity(0.8),
          ),
          General.sizeBoxVerical(10.0),
          _listItem(
              title: "طرق الدفع",
              onPress: () =>
                  _openPage(context: context, pageName: pages.PAYMENT_METHODS)),
          Divider(
            color: Constants.GreyColor.withOpacity(0.8),
          ),
          General.sizeBoxVerical(10.0),
          _listItem(
              title: "ملفي الشخصي",
              onPress: () =>
                  _openPage(context: context, pageName: pages.MY_PROFIIE)),
          General.sizeBoxVerical(30.0),
          General.buildTxt(
              txt: "الأعدادات", isCenter: false, fontSize: 18.0, isBold: true),
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
