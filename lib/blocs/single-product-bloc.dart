import 'package:flutter/material.dart';
import 'bloc_state.dart';
import 'package:baraka/services/api.dart';
import 'package:baraka/models/product.dart';

class SingleProductBloc extends GeneralBlocState {
  bool _isWaiting = false;
  Product product;
  int quantity = 1;
  bool get isWaiting => _isWaiting;
  getSingleProduct({@required num productId}) async {
    try {
      setWaiting();
      product = await Api().getProductById(id: productId);
      dismissWaiting();
      setError(null);
    } catch (e) {
      dismissWatingWithError();
      setError(e.toString());
      print("product error :$e");
    }
  }

  increase() {
    quantity++;
    notifyListeners();
  }

  decrease() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  addToWishList({@required num productId}) async {
    try {
      _isWaiting = true;
      notifyListeners();
      await Api().addProductToWishList(productId: productId);
      product.isFavourite = true;
      _isWaiting = false;
      notifyListeners();
    } catch (e) {
      _isWaiting = false;
      notifyListeners();
      print("add to wishlist error :$e");
    }
  }

  removeFromWishList({@required num productId}) async {
    try {
      _isWaiting = true;
      notifyListeners();
      await Api().addProductToWishList(productId: productId);
      product.isFavourite = true;
      _isWaiting = false;
      notifyListeners();
    } catch (e) {
      _isWaiting = false;
      notifyListeners();
      print("add to wishlist error :$e");
    }
  }
}
