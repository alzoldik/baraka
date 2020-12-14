import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: General.modalAppBar(context: context, title: "تصفية"),
      body: Container(
          padding: EdgeInsets.all(15.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: ListTile.divideTiles(context: context, tiles: [
              ListTile(
                onTap: () {},
                title: General.buildTxt(
                    txt: "الماركات", isCenter: false, fontSize: 15.0),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                ),
              ),
              ListTile(
                onTap: () {},
                title: General.buildTxt(
                    txt: "السعر", isCenter: false, fontSize: 15.0),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                ),
              ),
              ListTile(
                onTap: () {},
                title: General.buildTxt(
                    txt: "وصل حديثا", isCenter: false, fontSize: 15.0),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                ),
              ),
              ListTile(
                onTap: () {},
                title: General.buildTxt(
                    txt: "البائع", isCenter: false, fontSize: 15.0),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                ),
              )
            ]).toList(),
          )),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            RoundButton(
                onPress: () {},
                verticalPadding: 15.0,
                roundVal: 5.0,
                borderColor: Theme.of(context).accentColor,
                color: Colors.transparent,
                buttonTitle: General.buildTxt(
                    txt: "إعادة",
                    color: Theme.of(context).accentColor,
                    fontSize: 16.0)),
            General.sizeBoxHorizontial(10.0),
            Expanded(
              child: RoundButton(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  verticalPadding: 15.0,
                  roundVal: 5.0,
                  color: Theme.of(context).accentColor,
                  buttonTitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      General.buildTxt(
                          txt: "430 منتج", color: Colors.white, fontSize: 16.0),
                      General.buildTxt(
                          txt: "تطبيق", color: Colors.white, fontSize: 16.0)
                    ],
                  )),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
