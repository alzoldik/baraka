import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/components/input_field.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/components/select-city.dart';
import 'package:baraka/components/select-country.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'map.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController _streetController = TextEditingController();
  TextEditingController _buildNumberController = TextEditingController();
  TextEditingController _addressDetailsController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  FocusNode _streetFocus = FocusNode();
  FocusNode _buildNumberFocus = FocusNode();
  FocusNode _addressDetailsFocus = FocusNode();
  FocusNode _fnameFocus = FocusNode();
  FocusNode _lnameFocus = FocusNode();
  FocusNode _mobileFocus = FocusNode();
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'SA');
  bool isHideFloatBtn = false;
  String mobile = '';
  @override
  void initState() {
    super.initState();
    checkKeyboardVisibility();
  }

  checkKeyboardVisibility() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(
            () => visible ? isHideFloatBtn = true : isHideFloatBtn = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: General.modalAppBar(context: context),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 130.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                General.buildTxt(
                    txt: "معلومات عنوان التواصل", fontSize: 16.0, isBold: true),
                General.sizeBoxVerical(10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, ScaleTransationRoute(page: MapScreen()));
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/imgs/selected-map.png',
                        width: 70.0,
                      ),
                      General.sizeBoxHorizontial(20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          General.buildTxt(
                              txt: "طنطا - حسن رضوان - السلطان حسن",
                              color: Colors.black),
                          General.sizeBoxVerical(10.0),
                          General.buildTxt(
                            txt: "محافظة الغربية",
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Divider(),
                General.sizeBoxVerical(20.0),
                SelectCountry(),
                General.sizeBoxVerical(20.0),
                SelectCity(),
                General.sizeBoxVerical(20.0),
                General.buildTxt(txt: "العنوان", fontSize: 16.0, isBold: true),
                General.sizeBoxVerical(10.0),
                InputField(
                    controller: _streetController,
                    node: _streetFocus,
                    nextFocusNode: _buildNumberFocus,
                    textLabel: "اسم الشارع"),
                General.sizeBoxVerical(10.0),
                InputField(
                    controller: _buildNumberController,
                    node: _buildNumberFocus,
                    nextFocusNode: _addressDetailsFocus,
                    textLabel: "رقم المبني"),
                General.sizeBoxVerical(10.0),
                InputField(
                    controller: _addressDetailsController,
                    node: _addressDetailsFocus,
                    nextFocusNode: _mobileFocus,
                    textLabel: "تفاصيل العنوان"),
                General.sizeBoxVerical(20.0),
                General.buildTxt(
                    txt: "معلومات شخصية", fontSize: 16.0, isBold: true),
                General.sizeBoxVerical(20.0),
                Container(
                  child: InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      print(number.phoneNumber);
                      mobile = number.phoneNumber;
                    },
                    onInputValidated: (bool value) {
                      // print("kk  :$value");
                    },
                    focusNode: _mobileFocus,
                    ignoreBlank: false,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: phoneNumber,
                    textFieldController: _mobileController,
                    errorMessage: "not valid phhone number",
                    formatInput: true,
                    hintText: "رقم الجوال",
                    locale: "en",
                  ),
                ),
                General.sizeBoxVerical(10.0),
                InputField(
                  controller: _fnameController,
                  node: _fnameFocus,
                  textLabel: "الاسم الاول",
                  nextFocusNode: _lnameFocus,
                  validation: "الاسم الاول مطلوب",
                ),
                General.sizeBoxVerical(10.0),
                InputField(
                  controller: _lnameController,
                  node: _lnameFocus,
                  textLabel: "الاسم الثاني",
                  validation: "الاسم الثاني مطلوب",
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: !isHideFloatBtn
          ? Container(
              width: MediaQuery.of(context).size.width * 0.9,
              child: RoundButton(
                  onPress: () {},
                  verticalPadding: 20.0,
                  roundVal: 5.0,
                  color: Theme.of(context).accentColor,
                  buttonTitle: General.buildTxt(
                      txt: "حفظ العنوان", color: Colors.white, fontSize: 16.0)),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
