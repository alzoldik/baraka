class ResponseError {
  final message;
  List<dynamic> errors;
  ResponseError({this.message, this.errors});
  factory ResponseError.fromJson(json) {
    List errs = [];
    if (json['errors'] != null) {
      json['errors'].forEach((k, v) => errs.add(v[0]));
    }
    return ResponseError(message: json['error'], errors: errs);
  }
}
