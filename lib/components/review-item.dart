import 'package:baraka/models/review.dart';
import 'package:baraka/utils/constants.dart';
import 'package:baraka/widgets/general.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  ReviewItem({this.review});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/imgs/star.png',
                  width: 20.0,
                ),
                General.sizeBoxHorizontial(5.0),
                General.buildTxt(txt: review.rating),
                General.sizeBoxHorizontial(5.0),
                General.buildTxt(txt: review.reviewer)
              ],
            ),
            General.buildTxt(
                txt: General.formatDate(review.date),
                fontSize: 12.0,
                color: Color(General.getColorHexFromStr('#707070'))
                    .withOpacity(0.7))
          ],
        ),
        General.sizeBoxVerical(10.0),
        General.buildTxt(
            fontSize: 13.0,
            color: Constants.GreyColor,
            isCenter: false,
            lineHeight: 1.6,
            txt: review.comment),
        Divider()
      ],
    );
  }
}
