import 'dart:convert';
import 'package:baraka/models/create_account.dart';
import 'package:baraka/models/response_error.dart';
import 'package:baraka/models/review_response.dart';
import 'package:baraka/models/user.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/utils/shared_preference.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:baraka/models/category.dart';
import 'package:baraka/models/product.dart';

class Api {
  Future registration({CreateAccount params}) async {
    try {
      String responseBody = await postServices('customer/register', params);
      Map<String, dynamic> responseJson = json.decode(responseBody);
      print('responseJson :$responseJson');
      return User.fromJson(responseJson);
    } catch (e) {
      throw e;
    }
  }

  Future login({String email, int password}) async {
    try {
      Map params = {"email": email, "password": password};
      String responseBody = await postServices('customer/login', params);
      Map<String, dynamic> responseJson = json.decode(responseBody);
      User user = User.fromJson(responseJson);
      print('\nlogin response  :${user.userInfo.fname}');
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future register({CreateAccount request}) async {
    try {
      String responseBody = await postServices('customer/login', request);
      Map<String, dynamic> responseJson = json.decode(responseBody);
      User user = User.fromJson(responseJson);
      print('login response  :$user');
      return user;
    } catch (e) {
      throw e;
    }
  }

  updateUserProfile({UpdateUserInfo params}) async {
    try {
      User user;
      String responseBody =
          await putServices(url: "customer/profile?token=", params: params);
      User userData = await SharedPreferenceHandler.getuserData();
      Map<String, dynamic> responseJson = json.decode(responseBody);
      print("update user response : $responseJson");
      user = User.fromJson(responseJson);
      user.accessToken = userData.accessToken;
      print('user my loooo  :$user');
      return user;
    } catch (e) {
      throw e;
    }
  }

  getProducts() async {
    try {
      List<Product> products = [];
      String responseBody = await getServices('products');
      Iterable list = json.decode(responseBody)['data'];
      products = list.map((product) => Product.fromJson(product)).toList();
      return products;
    } catch (e) {
      throw e;
    }
  }

  addProductToWishList({num productId}) async {
    print("productId :$productId");
    try {
      String responseBody = await getServices('wishlist/add/$productId?token=');
      Map<String, dynamic> responseJson = json.decode(responseBody);
      print("add to wishlist response $responseJson");
    } catch (e) {
      throw e;
    }
  }

//still in development
  removeProductFromWishList({num productId}) async {
    try {
      String responseBody = await getServices('wishlist/add/$productId?token=');
      Map<String, dynamic> responseJson = json.decode(responseBody);
      print("add to wishlist response $responseJson");
    } catch (e) {
      throw e;
    }
  }

  getCategoryProducts({num catId}) async {
    try {
      List<Product> products = [];
      String responseBody = await getServices('products?category_id=$catId');
      Iterable list = json.decode(responseBody)['data'];
      products = list.map((product) => Product.fromJson(product)).toList();
      return products;
    } catch (e) {
      throw e;
    }
  }

  getUserData() async {
    try {
      User user;
      User userData = await SharedPreferenceHandler.getuserData();
      String responseBody =
          await getServices('customers/${userData.userInfo.id}?token=');
      var responseJson = json.decode(responseBody);
      user = User.fromJson(responseJson);
      user.accessToken = userData.accessToken;
      return user;
    } catch (e) {
      throw e;
    }
  }

  getFeaturedProducts() async {
    try {
      List<Product> products = [];
      String responseBody = await getServices('featured-products');
      Iterable list = json.decode(responseBody)['data'];
      products = list.map((product) => Product.fromJson(product)).toList();
      print('featured products list :$products');
      return products;
    } catch (e) {
      throw e;
    }
  }

  getRecentlyProducts() async {
    try {
      List<Product> products = [];
      String responseBody = await getServices('new-products');
      Iterable list = json.decode(responseBody)['data'];
      products = list.map((product) => Product.fromJson(product)).toList();
      print('new products list :$products');
      return products;
    } catch (e) {
      throw e;
    }
  }

  getProductReviews({num productId}) async {
    try {
      String responseBody = await getServices('reviews?product_id=$productId');
      Map<String, dynamic> responseJson = json.decode(responseBody);
      ReviewResponse reviewResponse = ReviewResponse.fromJson(responseJson);
      print('productReview :$reviewResponse');
      return reviewResponse;
    } catch (e) {
      throw e;
    }
  }

  getProductById({num id}) async {
    try {
      String responseBody = await getServices('products/$id');
      Map<String, dynamic> responseJson = json.decode(responseBody);
      Product product = Product.fromJson(responseJson['data']);
      return product;
    } catch (e) {
      throw e;
    }
  }

  getCategories() async {
    try {
      List<Category> cats = [];
      String responseBody = await getServices('categories');
      Iterable list = json.decode(responseBody)['data'];
      cats = list.map((cat) => Category.fromJson(cat)).toList();
      return cats;
    } catch (e) {
      throw e;
    }
  }

  Future postServices(
    String url,
    dynamic params,
  ) async {
    print('url :${Constants.baseUrl}$url');

    try {
      String request = jsonEncode(params);
      String accessToken = await SharedPreferenceHandler.getAccessToken();
      var response = await http
          .post('${Constants.baseUrl}$url',
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Accept-Language': 'ar',
                'Authorization':
                    accessToken != null ? 'Bearer $accessToken' : null,
              },
              body: request)
          .timeout(Duration(minutes: 1));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        var responseJson = json.decode(response.body);
        print("error stack is :$responseJson");
        ResponseError error = ResponseError.fromJson(responseJson);
        print(error.message);
        throw Exception(error);
      }
    } catch (error) {
      print("error :$error");
      throw error;
    }
  }

  static Future getServices(String url, {String tag}) async {
    print('get url  is :${Constants.baseUrl}$url');
    try {
      String accessToken = await SharedPreferenceHandler.getAccessToken();
      print("my token :$accessToken");
      Response response = await http.get('${Constants.baseUrl}$url', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': accessToken != null ? 'Bearer $accessToken' : null
      }).timeout(Duration(seconds: 60));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        var responseJson = json.decode(response.body);
        print("error stack is:$responseJson");

        ResponseError error = ResponseError.fromJson(responseJson);
        print(error.message);
        throw Exception(error.message);
      }
    } catch (err) {
      print('catch get error is :$err');
      throw err;
    }
  }

  Future putServices({
    String url,
    dynamic params,
  }) async {
    print(url);
    try {
      String accessToken = await SharedPreferenceHandler.getAccessToken();
      String request = jsonEncode(params);
      var response = await http
          .put('${Constants.baseUrl}$url',
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Accept-Language': await SharedPreferenceHandler.getLang(),
                'Authorization':
                    accessToken != null ? 'Bearer $accessToken' : null,
              },
              body: request)
          .timeout(Duration(seconds: 60));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        var responseJson = json.decode(response.body);
        print("error stack is:$responseJson");
        ResponseError error = ResponseError.fromJson(responseJson);
        print(error.message);
        print(error.errors);
        throw Exception(error);
      }
    } catch (error) {
      print("error :$error");
      throw error;
    }
  }

  static Future deleteServices(String url) async {
    print(url);
    try {
      String accessToekn = await SharedPreferenceHandler.getAccessToken();
      Response response =
          await http.delete('${Constants.baseUrl}$url', headers: {
        'Content-Type': 'application/json',
        'Accept-Language': await SharedPreferenceHandler.getLang() ?? 'ar',
        'Accept': 'application/json',
        'Authorization': accessToekn
      }).timeout(Duration(seconds: 60));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        var responseJson = json.decode(response.body);
        print("error stack is:$responseJson");
        ResponseError error = ResponseError.fromJson(responseJson);
        print(error.message);
        throw Exception(error.message);
      }
    } catch (err) {
      throw err;
    }
  }

  /////--- To get All User Address
  getAddresses() async {
    try {
      List<Address> Addresses = [];
      String responseBody = await getServices('addresses');
      Iterable list = json.decode(responseBody)['data'];
      Addresses = list.map((product) => Address.fromJson(product)).toList();
      return Addresses;
    } catch (e) {
      throw e;
    }
  }

  ////- To get Wishlit Items
  ////- To get Wishlit Items
  getWishProducts() async {
    try {
      List<Wishlist> wishlistProducts = [];
      String responseBody = await getServices('wishlist?token=');
      Iterable list = json.decode(responseBody)['data'];
      wishlistProducts =
          list.map((product) => Wishlist.fromJson(product)).toList();
      print('WishList products list :${wishlistProducts[0]}');
      return wishlistProducts;
    } catch (e) {
      throw e;
    }
  }

//  getCardProducts() async {
//    try {
//      List<CardModel> cardProducts = [];
//      String responseBody = await getServices('checkout/cart?token=');
//      Iterable list = json.decode(responseBody)['data']['items'];
//      cardProducts = list.map((product) => CardModel.fromJson(product)).toList();
//      print('Card products list :${cardProducts[0]}');
//      return cardProducts;
//    } catch (e) {
//      throw e;
//    }
//  }

}
