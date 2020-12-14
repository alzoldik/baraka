import 'package:baraka/models/review_response.dart';
import 'package:flutter/material.dart';
import 'bloc_state.dart';
import 'package:baraka/services/api.dart';

class ProductReviewBloc extends GeneralBlocState {
  ReviewResponse reviewResponse;
  num totalPages;
  getProductReviews({@required num productId, @required num page}) async {
    try {
      waiting = true;
      notifyListeners();
      reviewResponse = await Api().getProductReviews(productId: 1);
      totalPages = reviewResponse.totalPages;
      waiting = false;
      notifyListeners();
      setError(null);
    } catch (e) {
      waiting = false;
      notifyListeners();
      setError(e.toString());
      print("product reviews error :$e");
    }
  }

  loadMoreReviews({page}) async {
    ReviewResponse response = await _loadReviews(currentPage: page);
    reviewResponse.reviews.addAll(response.reviews);
    notifyListeners();
  }

  _loadReviews({currentPage}) async {
    return await Api().getProductReviews(productId: 1);
  }
}
