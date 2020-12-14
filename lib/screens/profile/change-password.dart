import 'package:baraka/components/password-filed.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  FocusNode _currentPasswordFocus = FocusNode();
  FocusNode _newPasswordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: General.modalAppBar(context: context),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PasswordField(
                  controller: _currentPasswordController,
                  node: _currentPasswordFocus,
                  nextFocusNode: _newPasswordFocus,
                  textLabel: "كلمة المرور الحالية"),
              General.sizeBoxVerical(20.0),
              PasswordField(
                  controller: _newPasswordController,
                  node: _newPasswordFocus,
                  nextFocusNode: _confirmPasswordFocus,
                  textLabel: "كلمة المرور الجديدة"),
              General.sizeBoxVerical(20.0),
              PasswordField(
                  controller: _confirmPasswordController,
                  node: _confirmPasswordFocus,
                  textLabel: "تأكيد كلمة المرور الجديدة"),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: RoundButton(
            onPress: () {},
            verticalPadding: 20.0,
            roundVal: 5.0,
            color: Theme.of(context).accentColor,
            buttonTitle: General.buildTxt(
                txt: "تغيير كلمة المرور", color: Colors.white, fontSize: 16.0)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
