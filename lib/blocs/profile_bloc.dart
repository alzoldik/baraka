import 'package:baraka/blocs/bloc_state.dart';
import 'package:baraka/blocs/user_bloc.dart';
import 'package:baraka/models/user.dart';

import 'package:baraka/services/api.dart';
import 'package:baraka/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileBloc extends GeneralBlocState {
  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  User _user;
  User get user => _user;

  getUserData() async {
    try {
      waiting = true;
      notifyListeners();
      _user = await Api().getUserData();
      print('_user lol:$_user');
      waiting = false;
      notifyListeners();
      setError(null);
    } catch (e) {
      waiting = false;
      notifyListeners();
      setError(e.toString());
      print("all products error :$e");
    }
  }

  updateProfile({UpdateUserInfo request, BuildContext context}) async {
    try {
      _isWaiting = true;
      notifyListeners();
      await Api().updateUserProfile(params: request);
      UserBloc userBloc = Provider.of<UserBloc>(context, listen: false);
      userBloc.setUser(currentUser: _user);
      await SharedPreferenceHandler.setUserData(user);
      _isWaiting = false;
      notifyListeners();
    } catch (e) {
      _isWaiting = false;
      notifyListeners();
      print("update profile error :$e");
    }
  }
}
