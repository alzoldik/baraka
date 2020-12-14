import 'package:baraka/components/loading_dialogue.dart';
import 'package:baraka/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class General {
  static sizeBoxHorizontial(space) {
    return SizedBox(
      width: space,
    );
  }

  static sizeBoxVerical(space) {
    return SizedBox(
      height: space,
    );
  }

  static showToast({@required txt, Color color}) {
    return Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: color == null ? Colors.black87 : color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static customThreeBounce(BuildContext context,
      {Color color = Colors.white, size = 20.0}) {
    return Center(
      child: SpinKitThreeBounce(
        color: color,
        size: size,
      ),
    );
  }

  static arrowAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme:
          IconThemeData(color: Constants.GreyColor //change your color here
              ),
      title: Image.asset(
        'assets/imgs/logo.png',
        width: 30.0,
      ),
    );
  }

  static modalAppBar(
      {@required BuildContext context,
      String title,
      bool hideCancelButton = false}) {
    return AppBar(
      leading: IconButton(
          icon: Image.asset(
            "assets/imgs/logo.png",
          ),
          onPressed: () {}),
      title: title != null ? General.buildTxt(txt: title) : Container(),
      actions: [
        !hideCancelButton
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: General.buildTxt(
                      txt: "إلغاء",
                      color: Theme.of(context).accentColor,
                      fontSize: 20.0),
                ),
              )
            : Container()
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
    );
  }

  static buildTxt(
      {@required String txt,
      Color color = Constants.GreyColor,
      double fontSize,
      double lineHeight = 1,
      bool isBold = false,
      bool isOverflow = false,
      bool isHaveLineThrough = false,
      isCenter = true}) {
    return Text(
      txt,
      textAlign: isCenter ? TextAlign.center : null,
      overflow: isOverflow ? TextOverflow.ellipsis : null,
      style: TextStyle(
          color: color,
          height: lineHeight,
          fontFamily: "Montserrat",
          decoration: isHaveLineThrough ? TextDecoration.lineThrough : null,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }

  static dismissLoadingDialog(context) {
    if (Navigator.of(context).canPop()) Navigator.pop(context);
  }

  static showLoadingDialog(context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingDialog();
      },
    );
  }

  static Future<void> showDialogue(
      {@required Widget txtWidget,
      @required BuildContext context,
      String actionLabel = "Cancel"}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[sizeBoxVerical(10.0), txtWidget],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: General.buildTxt(txt: actionLabel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static formatDate(String date) {
    DateTime myDate = DateTime.parse(date);
    return new DateFormat('yyyy/MM/dd').format(myDate);
  }

  static int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }
}
