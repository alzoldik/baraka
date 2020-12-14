import 'package:baraka/blocs/product-review.dart';
import 'package:baraka/components/review-item.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReviewsScreen extends StatelessWidget {
  final num productId;
  ReviewsScreen({@required this.productId});
  num currentPage = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  _onLoading(ProductReviewBloc state) {
    currentPage += 1;
    if (currentPage < state.totalPages) {
      state.loadMoreReviews(page: currentPage);
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  _onRefresh(ProductReviewBloc state) {
    currentPage = 0;
    state.getProductReviews(page: currentPage, productId: productId);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: General.buildTxt(txt: "المراجعات"),
        iconTheme:
            IconThemeData(color: Constants.GreyColor //change your color here
                ),
        elevation: 0.0,
      ),
      body: Consumer<ProductReviewBloc>(
          builder: (BuildContext context, state, __) {
        if (state.error != null) {
          return Center(child: General.buildTxt(txt: state.error));
        } else if (!state.waiting) {
          return Container(
            child: reviewList(state),
          );
        } else {
          return Center(
              child: General.customThreeBounce(context,
                  color: Theme.of(context).primaryColor, size: 30.0));
        }
      }),
    );
  }

  reviewList(ProductReviewBloc state) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        waterDropColor: Colors.blueAccent,
      ),
      onRefresh: () => _onRefresh(state),
      onLoading: () => _onLoading(state),
      child: ListView.builder(
          itemCount: state.reviewResponse.reviews.length,
          padding: EdgeInsets.all(10.0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ReviewItem(
              review: state.reviewResponse.reviews[index],
            );
          }),
    );
  }
}
