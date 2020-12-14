import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/blocs/user_bloc.dart';
import 'package:baraka/models/create_account.dart';
import 'package:baraka/models/user.dart';
import 'package:baraka/screens/login/login.dart';
import 'package:baraka/screens/tabs/tabs.dart';
import 'package:baraka/services/api.dart';
import 'package:baraka/utils/shared_preference.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc_state.dart';

class AuthenticationBloc extends GeneralBlocState {
  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  CreateAccount _createAccount;
  CreateAccount get createAccount => _createAccount;

  setUserData({CreateAccount data}) {
    _createAccount = data;
    notifyListeners();
  }

  login({BuildContext context, String email, int password}) async {
    UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
    try {
      _isWaiting = true;
      notifyListeners();
      User user = await Api().login(email: email, password: password);
      userBloc.setUser(currentUser: user);
      SharedPreferenceHandler.setUserData(user);
      userBloc.getUserData();
      _isWaiting = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          ScaleTransationRoute(
              page: TabsScreen(
            tabIndex: 2,
          )),
          (Route<dynamic> route) => false);
    } catch (e) {
      _isWaiting = false;
      notifyListeners();
      print('login error :$e');
      General.showDialogue(
          txtWidget: General.buildTxt(
              txt: e.message.message,
              fontSize: 13.0,
              lineHeight: 1.3,
              color: Colors.black),
          context: context);
    }
  }

  register({CreateAccount data, BuildContext context}) async {
    UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
    try {
      _isWaiting = true;
      notifyListeners();
      User user = await Api().registration(params: data);
      userBloc.setUser(currentUser: user);
      SharedPreferenceHandler.setUserData(user);
      userBloc.getUserData();
      _isWaiting = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
          context,
          ScaleTransationRoute(
              page: TabsScreen(
            tabIndex: 0,
          )),
          (Route<dynamic> route) => false);
    } catch (e) {
      _isWaiting = false;
      notifyListeners();
      print("register err : $e");
      List<dynamic> errors = e.message.errors;
      Widget err = Column(
        children: errors.map<Widget>((err) {
          return Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: General.buildTxt(
                txt: err, fontSize: 13.0, lineHeight: 1.5, color: Colors.black),
          );
        }).toList(),
      );
      General.showDialogue(txtWidget: err, context: context);
    }
  }
}
