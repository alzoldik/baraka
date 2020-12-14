import 'dart:convert';

import 'package:baraka/blocs/profile_bloc.dart';
import 'package:baraka/components/email-field.dart';
import 'package:baraka/components/input_field.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/models/create_account.dart';
import 'package:baraka/models/user.dart';
import 'package:baraka/models/userInfo_edit.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  EditProfileScreen({this.user});
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  FocusNode _fnameFocus = FocusNode();
  FocusNode _lnameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  ProfileBloc _profileBloc;
  String ganderSelected ;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    _emailController.text = widget.user.userInfo.email;
    _fnameController.text = widget.user.userInfo.fname;
    _lnameController.text = widget.user.userInfo.lname;
    //ganderSelected =
    await Future.delayed(Duration(milliseconds: 10));
    _profileBloc = Provider.of<ProfileBloc>(context, listen: false);
  }

  _save() {
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      _formKey.currentState.save();
    }
    UpdateUserInfo request = UpdateUserInfo(
        email: _emailController.text,
        firstName: _fnameController.text,
        lastName: _lnameController.text,
        gender: ganderSelected == null ? widget.user.userInfo.gender:int.parse(ganderSelected),
       dateOfBirth: null,
    );
    _profileBloc.updateProfile(context: context, request: request);
    print('request :${json.encode(request)}');
  }

  @override
  Widget build(BuildContext context) {
    ProfileBloc profileBloc = Provider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: General.modalAppBar(context: context),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(
                  controller: _fnameController,
                  node: _fnameFocus,
                  textLabel: "الاسم الاول",
                  nextFocusNode: _lnameFocus,
                  validation: "الاسم الاول مطلوب",
                ),
                General.sizeBoxVerical(20.0),
                InputField(
                  controller: _lnameController,
                  node: _lnameFocus,
                  textLabel: "الاسم الثاني",
                  validation: "الاسم الثاني مطلوب",
                ),
                General.sizeBoxVerical(20.0),
                EmailField(
                  controller: _emailController,
                  node: _emailFocus,
                ),
                General.sizeBoxVerical(20.0),

                /////- For Gender updates
                Container(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          child: DropdownButton<String>(
                              hint: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Select Gander",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              value: ganderSelected,
                              onChanged: (String Value) {
                                setState(() {
                                  ganderSelected = Value;
                                  //ganderController.text=ganderSelected;
                                  //updateInfo();
                                  print("G\n\n ${ganderSelected}");
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                  value: "0",
                                  child: Text(
                                    "Female",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "1",
                                  child: Text(
                                    "Male",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),



              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: RoundButton(
            onPress: !profileBloc.isWaiting ? _save : null,
            verticalPadding: 20.0,
            roundVal: 5.0,
            color: Theme.of(context).accentColor,
            buttonTitle: !profileBloc.isWaiting
                ? General.buildTxt(
                    txt: "حفظ", color: Colors.white, fontSize: 16.0)
                : Container(
                    height: 15.0,
                    // width: 25.0,
                    child: General.customThreeBounce(context),
                  )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
