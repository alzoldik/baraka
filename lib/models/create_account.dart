class CreateAccount {
  String firstname, lastname, email, password, confirmPassword;
  num gender,dateOfBirth;
  CreateAccount({
    this.confirmPassword,
    this.email,
    this.gender,
    this.lastname,
    this.firstname,
    this.password,
    this.dateOfBirth,
  });

  dynamic toJson() {
    Map json = {
      'first_name': this.firstname,
      'last_name': this.lastname,
      'email': this.email,
      'gender': this.gender,
      'password': this.password,
      'password_confirmation': this.confirmPassword,
      'date_of_birth': this.dateOfBirth==null?"":this.dateOfBirth,
    };
    json.removeWhere((key, value) {
      return value == null || value == '';
    });
    return json;
  }
}
