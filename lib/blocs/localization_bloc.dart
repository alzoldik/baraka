import 'package:baraka/utils/shared_preference.dart';
import 'package:flutter/material.dart';

class LocalizationBloc extends ChangeNotifier {
  Locale _appLocale;
  Locale get appLocal {
    return _appLocale ?? Locale("ar");
  }

  LocalizationBloc() {
    setBaseLocale();
  }

  void setBaseLocale() async {
    // String savedLocal = await SharedPreferenceHandler.getLang();
    _appLocale = Locale("ar");
    notifyListeners();
  }

  void changeDirection() async {
    if (_appLocale == Locale("ar")) {
      await SharedPreferenceHandler.setLang('en');
      _appLocale = Locale("en");
    } else {
      await SharedPreferenceHandler.setLang('ar');
      _appLocale = Locale("ar");
    }
    notifyListeners();
  }
}
