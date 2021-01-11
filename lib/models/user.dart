class User {
  String username;
  String password;
  String name;
  String type;
  int year;
  String phone;
  String email;
  String school;

  User(
      {this.username,
      this.password,
      this.name,
      this.type,
      this.year,
      this.phone,
      this.email,
      this.school});

  Future login(String us, String pw, List<User> users) async {
    for (var u in users) {
      if (us == u.username && pw == u.password) {
        return Future.value(u);
      }
    }
    return null;
  }
}
