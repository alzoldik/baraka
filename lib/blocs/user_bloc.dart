import 'package:baraka/models/user.dart';
import 'package:baraka/services/api.dart';

import 'bloc_state.dart';

class UserBloc extends GeneralBlocState {
  bool waiting = true;
  bool _isLogin = false;
  bool get isLogin => _isLogin;
  User _user;

  User get user => _user;
  setUser({User currentUser}) {
    _user = currentUser;
    _isLogin = true;
    notifyListeners();
  }

  logout() {
    _isLogin = false;
    _user = null;
    notifyListeners();
  }

  getUserData() async {
    try {
      waiting = true;
      notifyListeners();
      _user = await Api().getUserData();
      print('_user data lol:$_user');
      waiting = false;
      notifyListeners();
      setError(null);
    } catch (e) {
      waiting = false;
      notifyListeners();
      setError(e.toString());
      print("get user error :$e");
    }
  }
}
