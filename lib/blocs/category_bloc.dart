import 'package:baraka/models/category.dart';
import 'package:baraka/models/product.dart';
import 'package:flutter/material.dart';

import 'bloc_state.dart';
import 'package:baraka/services/api.dart';

class CategoryBloc extends GeneralBlocState {
  List<Category> categories = [];
  List<Product> products = [];
  getCategories() async {
    try {
      waiting = true;
      notifyListeners();
      categories = await Api().getCategories();
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

  getCategoryProducts({@required catId}) async {
    try {
      waiting = true;
      notifyListeners();
      products = await Api().getCategoryProducts(catId: catId);
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
}
