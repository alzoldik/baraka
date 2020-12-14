import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/blocs/authentication_bloc.dart';
import 'package:baraka/components/email-field.dart';
import 'package:baraka/components/password-filed.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/screens/login/forgetPassword.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  AuthenticationBloc authenticationBloc;
  bool acceptTerms = false;

  _openCreateAccountScreen() {}

  init() async {
    await Future.delayed(Duration(milliseconds: 200));
    authenticationBloc = Provider.of<AuthenticationBloc>(context, listen: false);
    _emailController.text = "mo@gmail.com";
    _passwordController.text = "12345678";
  }

  @override
  initState() {
    super.initState();
    init();
  }

  _login() {
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      _formKey.currentState.save();
    }
    authenticationBloc.login(
        context: context,
        email: _emailController.text.replaceAll(new RegExp(r"\s+"), ""),
        password: int.parse(_passwordController.text));
  }

  _openForgetPasswordScreen() {
    Navigator.push(context, ScaleTransationRoute(page: ForgetPasswordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc =
        Provider.of<AuthenticationBloc>(context);
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
                    txt: "مرحبا بعودتك !", fontSize: 18.0, isBold: true),
                General.sizeBoxVerical(30.0),
                EmailField(
                  controller: _emailController,
                  node: _emailFocus,
                ),
                General.sizeBoxVerical(10.0),
                PasswordField(
                    controller: _passwordController,
                    node: _passwordFocus,
                    validation: true,
                    textLabel: "كلمة المرور"),
                General.sizeBoxVerical(20.0),
                GestureDetector(
                  onTap: _openForgetPasswordScreen,
                  child: General.buildTxt(
                      txt: "نسيت كلمة المرور؟",
                      isBold: true,
                      color: Colors.black),
                ),
                General.sizeBoxVerical(20.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RoundButton(
                      onPress: !authenticationBloc.isWaiting ? _login : null,
                      verticalPadding: 20.0,
                      roundVal: 5.0,
                      color: Theme.of(context).accentColor,
                      buttonTitle: !authenticationBloc.isWaiting
                          ? General.buildTxt(
                              txt: "دخول", color: Colors.white, fontSize: 16.0)
                          : General.customThreeBounce(context)),
                ),
                General.sizeBoxVerical(30.0),
                InkWell(
                  onTap: _openCreateAccountScreen,
                  child: Row(
                    children: [
                      General.buildTxt(txt: " لا تمتلك حساب  "),
                      General.buildTxt(
                          txt: "انشئ حسابا", isBold: true, color: Colors.black)
                    ],
                  ),
                ),
                General.sizeBoxVerical(30.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: Colors.black12,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: General.buildTxt(txt: "أو"),
                    ),
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: Colors.black12,
                      ),
                    )
                  ],
                ),
                General.sizeBoxVerical(30.0),
                socialMediaButton(
                    logo: 'assets/imgs/google.png',
                    title: "تسجيل الدخول عن طريق فيسبوك",
                    textColor: Colors.blue),
                General.sizeBoxVerical(10.0),
                socialMediaButton(
                    logo: 'assets/imgs/google.png',
                    title: "تسجيل الدخول عن طريق جوجل",
                    textColor: Colors.red),
                General.sizeBoxVerical(10.0),
                socialMediaButton(
                    logo: 'assets/imgs/apple.png',
                    title: "تسجيل الدخول عن طريق ابل",
                    textColor: Colors.black),
              ],
            ),
          ),
        ),
      ),
    );
  }

  socialMediaButton({String title, String logo, Color textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Color(General.getColorHexFromStr('#FAFAFA')),
          borderRadius: BorderRadiusDirectional.circular(50.0)),
      child: Row(
        children: [
          Image.asset(
            logo,
            width: 30.0,
          ),
          General.sizeBoxHorizontial(20.0),
          General.buildTxt(txt: "تسجيل الدخول عن طريق فيسبوك", color: textColor)
        ],
      ),
    );
  }

}
