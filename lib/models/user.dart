class User {
  String username;
  String password;
  String name;
  String type;
  int year;

  User({this.username, this.password, this.name, this.type, this.year});

  Future login(String us, String pw, List<User> users) async {
    for (var u in users) {
      if (us == u.username && pw == u.password) {
        return Future.value(u);
      }
    }
    return null;
  }
}
