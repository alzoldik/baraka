import 'package:baraka/models/review.dart';

class ReviewResponse {
  List<Review> reviews;
  num totalPages;
  ReviewResponse({this.reviews, this.totalPages});
  factory ReviewResponse.fromJson(json) {
    Iterable list = json['data'];
    return ReviewResponse(
        totalPages: json['meta']['last_page'],
        reviews: json['data'] != null
            ? list.map((history) => Review.fromJson(history)).toList()
            : []);
  }
}
