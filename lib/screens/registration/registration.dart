import 'package:baraka/blocs/user_bloc.dart';
import 'package:baraka/components/email-field.dart';
import 'package:baraka/components/input_field.dart';
import 'package:baraka/components/password-filed.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/components/select-gender.dart';
import 'package:baraka/models/create_account.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/utils/languages/translations_delegate_base.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baraka/blocs/authentication_bloc.dart';
import 'dart:convert';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static TextEditingController _fnameController = TextEditingController();
  static TextEditingController _lnameController = TextEditingController();
  static TextEditingController _emailController = TextEditingController();
  static TextEditingController _passwordController = TextEditingController();
  static TextEditingController _confirmPasswordController =
      TextEditingController();
  FocusNode _fnameFocus = FocusNode();
  FocusNode _lnameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  FocusNode _confirmPasswordFocus = FocusNode();
  AuthenticationBloc authenticationBloc;
  CreateAccount request;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedValueSingleDialog = '';
  bool acceptTerms = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(milliseconds: 500));
    authenticationBloc =
        Provider.of<AuthenticationBloc>(context, listen: false);
    request = CreateAccount();
  }

  matchPassword(String confirmPassword) {
    if (_passwordController.text.isEmpty) {
      return "تاكيد كلمة المرور مطلوبة";
    } else if (_passwordController.text != confirmPassword) {
      return "كلمة المرور غير متطابقة";
    } else if (_passwordController.text.length < 8) {
      return "يجب الا يقل تاكيد كلمة المرور عن ٨ احرف";
    } else {
      return null;
    }
  }

  _selectedGender(num val) {
    request.gender = val;
    print('ddd  val :$val');
  }

  _register() {
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      _formKey.currentState.save();
    }
    if (!acceptTerms) {
      General.showDialogue(
          txtWidget: General.buildTxt(
              txt: "يجب الموافقة اولا علي الشروط وسياسة الاستخدام",
              color: Colors.black,
              lineHeight: 1.5),
          context: context);
      return;
    }
    request.firstname = _fnameController.text;
    request.lastname = _lnameController.text;
    request.email = _emailController.text;
    request.password = _passwordController.text;
    request.confirmPassword = _confirmPasswordController.text;
    print("json data is :${jsonEncode(request)}");
    authenticationBloc.register(data: request, context: context);
  }

  _back() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc =
        Provider.of<AuthenticationBloc>(context);
    UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
    return Scaffold(
      appBar: General.modalAppBar(context: context, hideCancelButton: true),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                General.buildTxt(
                    txt: "إنشاء حساب جديد", fontSize: 18.0, isBold: true),
                General.sizeBoxVerical(30.0),
                InputField(
                    controller: _fnameController,
                    node: _fnameFocus,
                    textLabel: "الاسم الاول",
                    validation: "الاسم الاول مطلوب",
                    nextFocusNode: _lnameFocus),
                General.sizeBoxVerical(10.0),
                InputField(
                    controller: _lnameController,
                    node: _lnameFocus,
                    textLabel: "الاسم الثاني",
                    validation: "الاسم الثاني مطلوب",
                    nextFocusNode: _emailFocus),
                General.sizeBoxVerical(10.0),
                EmailField(
                  controller: _emailController,
                  node: _emailFocus,
                  nextFocusNode: _passwordFocus,
                ),
                General.sizeBoxVerical(10.0),
                SelectGender(
                  selectedGender: _selectedGender,
                ),
                General.sizeBoxVerical(10.0),
                PasswordField(
                    controller: _passwordController,
                    node: _passwordFocus,
                    validation: true,
                    nextFocusNode: _confirmPasswordFocus,
                    textLabel: "كلمة المرور"),
                General.sizeBoxVerical(10.0),
                Container(
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    focusNode: _confirmPasswordFocus,
                    keyboardAppearance: Brightness.light,
                    validator: (String val) => matchPassword(val),
                    textInputAction: TextInputAction.done,
                    decoration: Constants.textFieldDecoration.copyWith(
                        contentPadding: EdgeInsets.all(0.0),
                        labelText: 'تأكيد كلمة المرور',
                        labelStyle: TextStyle(fontSize: 14.0)),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: acceptTerms,
                      onChanged: (val) {
                        acceptTerms = val;
                        setState(() {});
                      },
                    ),
                    General.buildTxt(
                        txt:
                            "من خلال التسجيل انت توافق علي الشروط وسياسة الاستخدام",
                        fontSize: 12.0),
                  ],
                ),
                General.sizeBoxVerical(20.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RoundButton(
                      onPress: !authenticationBloc.isWaiting ? _register : null,
                      verticalPadding: 20.0,
                      roundVal: 5.0,
                      color: Theme.of(context).accentColor,
                      buttonTitle: !authenticationBloc.isWaiting
                          ? General.buildTxt(
                              txt: "تسجيل", color: Colors.white, fontSize: 16.0)
                          : General.customThreeBounce(context)),
                ),
                General.sizeBoxVerical(30.0),
                Row(
                  children: [
                    General.buildTxt(txt: " تمتلك حسابا بالفعل ؟"),
                    General.buildTxt(
                        txt: "تسجيل الدخول", isBold: true, color: Colors.black)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
