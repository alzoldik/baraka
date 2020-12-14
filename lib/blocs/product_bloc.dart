import 'bloc_state.dart';
import 'package:baraka/services/api.dart';
import 'package:baraka/models/product.dart';

class ProductBloc extends GeneralBlocState {
  bool _isWaiting = false;
  bool get isWaiting => _isWaiting;
  List<Product> featuredProducts;
  List<Product> recentlyProducts;
  getFeaturedProduct() async {
    try {
      waiting = true;
      notifyListeners();
      featuredProducts = await Api().getFeaturedProducts();
      waiting = false;
      notifyListeners();
      setError(null);
    } catch (e) {
      waiting = false;
      notifyListeners();
      setError(e.toString());
      print("featured products error :$e");
    }
  }

  addProductToWishlist({Product product}) async {
    product.isWaiting = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    product.isFavourite = true;
    product.isWaiting = false;
    notifyListeners();
  }

  getRecentlyProduct() async {
    try {
      waiting = true;
      notifyListeners();
      recentlyProducts = await Api().getRecentlyProducts();
      waiting = false;
      notifyListeners();
      setError(null);
    } catch (e) {
      waiting = false;
      notifyListeners();
      setError(e.toString());
      print("new products error :$e");
    }
  }
}
