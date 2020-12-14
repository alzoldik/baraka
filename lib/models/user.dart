class User {
  String accessToken;
  UserInfo userInfo;
  User({
    this.userInfo,
    this.accessToken,
  });
  factory User.fromJson(json) {
    return User(
        userInfo: UserInfo.fromJson(json['data']),
        accessToken: json['api_token'] ?? null);
  }

  dynamic toJson() {
    Map json = {"api_token": this.accessToken, "data": this.userInfo};
    json.removeWhere((key, value) {
      return value == null;
    });
    return json;
  }
}

class UserInfo {
  String phone, email, fname, lname,gender;
  num status, id;
  UserInfo({
    this.id,
    this.phone,
    this.email,
    this.fname,
    this.lname,
    this.gender,
  });

  factory UserInfo.fromJson(json) {
    return UserInfo(
      id: json["id"],
      phone: json["phone"],
      email: json['email'],
      fname: json['first_name'],
      lname: json['last_name'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["phone"] = phone;
    map['email'] = email;
    map['first_name'] = fname;
    map['last_name'] = lname;
    map['gender'] = gender;
    return map;
  }

  dynamic toJson() {
    Map json = {
      "id": this.id,
      "phone": this.phone,
      "email": this.email,
      "first_name": this.fname,
      "lname": this.lname,
      "gender": this.gender
    };
    json.removeWhere((key, value) {
      return value == null;
    });
    return json;
  }

  @override
  String toString() {
    return "{'id':${this.id},'mobile':${this.phone}}";
  }
}
