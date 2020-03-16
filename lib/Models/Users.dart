class User {
  String username;
  String firstname;
  String lastname;
  String email;
  String password;
  String apikey;
  int id;

  User(this.username, this.firstname, this.lastname, this.email, this.password,
      this.apikey, this.id);
      
  User.fromJson(Map<String, dynamic> parsedJson) {
    User user = new User(
        parsedJson['username'],
        parsedJson['first_name'],
        parsedJson['last_name'],
        parsedJson['email'],
        parsedJson['password'],
        parsedJson['api_key'],
        parsedJson['id']);
  }
}
