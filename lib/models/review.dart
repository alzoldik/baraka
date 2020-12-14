class Review {
  num id;
  String title, rating, comment, reviewer, status, date;
  Review(
      {this.id,
      this.comment,
      this.rating,
      this.reviewer,
      this.date,
      this.status,
      this.title});

  factory Review.fromJson(json) {
    return Review(
        id: json['id'],
        title: json['title'],
        comment: json['comment'],
        rating: json['rating'],
        reviewer: json['name'],
        status: json['status'],
        date: json['created_at']);
  }
}
