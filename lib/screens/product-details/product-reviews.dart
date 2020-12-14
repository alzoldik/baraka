import 'package:baraka/animations/scale-transation-route.dart';
import 'package:baraka/components/review-item.dart';
import 'package:baraka/components/round_buttton.dart';
import 'package:baraka/models/product.dart';
import 'package:baraka/models/review_response.dart';
import 'package:baraka/screens/reviews/reviews.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductReviews extends StatelessWidget {
  final ReviewResponse reviewResponse;
  final Product product;
  num counter = 5;
  ProductReviews({this.reviewResponse, this.product});
  @override
  Widget build(BuildContext context) {
    print('percentages :${product.reviews.percentages}');
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          General.buildTxt(txt: "تقييم عام", isBold: true),
          General.sizeBoxVerical(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  General.buildTxt(
                      txt: "${product.reviews.averageRating}/5",
                      fontSize: 20.0,
                      isBold: true,
                      color: Color(General.getColorHexFromStr('#EFCE4A'))),
                  SmoothStarRating(
                    isReadOnly: true,
                    size: 15,
                    starCount: 5,
                    rating: 4.0,
                    spacing: 2.0,
                    borderColor: Color(General.getColorHexFromStr('#EFCE4A')),
                    color: Color(General.getColorHexFromStr('#EFCE4A')),
                  ),
                  General.sizeBoxVerical(6.0),
                  General.buildTxt(
                      txt: "بناءا علي ${product.reviews.total} تقييم",
                      fontSize: 10.0)
                ],
              ),
              General.sizeBoxHorizontial(15.0),
              Expanded(
                  child: Column(
                      children: product.reviews.percentages.map((percentage) {
                return LinearPercentIndicator(
                  lineHeight: 8.0,
                  leading: Container(
                    child: General.buildTxt(txt: '${counter--}'),
                  ),
                  trailing: General.buildTxt(txt: percentage.toString()),
                  percent: percentage / 100,
                  isRTL: true,
                  backgroundColor: Color(General.getColorHexFromStr('#797979'))
                      .withOpacity(0.5),
                  progressColor: Color(General.getColorHexFromStr('#EFCE4A')),
                );
              }).toList()))
            ],
          ),
          // General.sizeBoxVerical(15.0),
          General.buildTxt(txt: "اراء العملاء", isBold: true),
          General.sizeBoxVerical(15.0),
          ListView.builder(
              itemCount: reviewResponse.reviews.take(2).length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ReviewItem(
                  review: reviewResponse.reviews[index],
                );
              }),
          General.sizeBoxVerical(15.0),
          Container(
            alignment: Alignment.center,
            child: RoundButton(
              onPress: () {
                Navigator.push(
                    context,
                    ScaleTransationRoute(
                        page: ReviewsScreen(
                      productId: product.id,
                    )));
              },
              buttonTitle: General.buildTxt(
                  txt: "المزيد", color: Theme.of(context).primaryColor),
              color: Colors.transparent,
              borderColor: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
