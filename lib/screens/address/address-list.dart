import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/screens/address/map.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: General.arrowAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            height: 300,
            child: Consumer<AddressBloc>(
                builder: (BuildContext context, state, __) {
              if (state.error != null) {
                return Center(child: General.buildTxt(txt: state.error));
              } else if (!state.waiting) {
                print("asd");
                return buildAddressesList(state);
              } else {
                return Center(
                    child: General.customThreeBounce(context,
                        color: Theme.of(context).primaryColor, size: 30.0));
              }
            }),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: RoundButton(
            onPress: () {
              Navigator.push(context, ScaleTransationRoute(page: MapScreen()));
            },
            borderColor: Theme.of(context).accentColor,
            roundVal: 5.0,
            verticalPadding: 20.0,
            color: Colors.white,
            buttonTitle: General.buildTxt(
                txt: "+ اضف عنوان جديد", color: Theme.of(context).accentColor)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

////- To Build List Of Addresses
buildAddressesList(AddressBloc state) {
  return state.userAddresses.isNotEmpty
      ? ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.userAddresses.length,
          padding:
              EdgeInsets.only(bottom: 20.0, left: 15.0, right: 15.0, top: 20.0),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                //onTap: () {}),
                child: AddressItemWidget(
              userAddressItem: state.userAddresses[index],
            ));
          })
      : Container(
          child: Center(child: General.buildTxt(txt: "لا يوجد عنواين توصيل")),
        );
}
