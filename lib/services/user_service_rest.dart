import 'package:schoolah_mobile_app/models/user.dart';
import 'package:schoolah_mobile_app/services/user_service.dart';

import '../dependencies.dart';
import 'rest_service.dart';

class UserServiceRest implements UserService {
//------- Here is how we implement 'Singleton pattern' in Dart --------

  static final UserServiceRest _instance = UserServiceRest._constructor();
  factory UserServiceRest() {
    return _instance;
  }

  UserServiceRest._constructor();
  final rest = service<RestService>();

  User currUser;

  Future<List<User>> getAllUsers() async {
    final listJson = await rest.get('users');
    return (listJson as List)
        .map((itemJson) => User.fromJson(itemJson))
        .toList();
  }

  Future<User> login(String us, String pw) async {
    List<User> all = await getAllUsers();
    for (var u in all) {
      if (us == u.username && pw == u.password) {
        currUser = u;
        return Future.value(u);
      }
    }
    return null;
  }

  Future logout() async {
    currUser = null;
  }

  Future registerNew(
      {String username,
      String password,
      String name,
      int year,
      String school,
      String email,
      String type,
      String phone}) async {
    final newuser = User(
        username: username,
        password: password,
        name: name,
        year: year,
        school: school,
        email: email,
        type: type,
        phone: phone);

    final json = await rest.post('users/', data: newuser);
    return User.fromJson(json);
  }

  Future<User> getCurrentUser() async {
    return currUser;
  }

  Future setCurrentUser({User curruser}) async {
    currUser = curruser;
  }

  Future updateDetails(
      {String name,
      int year,
      String school,
      String phone,
      String email,
      String id}) async {
    if (name == null) {
      name = currUser.name;
    }
    if (year == null) {
      year = currUser.year;
    }

    if (school == null) {
      school = currUser.school;
    }

    if (phone == null) {
      phone = currUser.phone;
    }

    if (email == null) {
      email = currUser.email;
    }

    final json = await rest.patch('users/$id', data: {
      'name': name,
      'year': year,
      'school': school,
      'phone': phone,
      'email': email
    });
    return User.fromJson(json);
  }

  Future<List<User>> getStudentList() async {
    List<User> students = new List<User>();
    List<User> globalUserList = await getAllUsers();
    for (int i = 0; i < globalUserList.length; i++) {
      if (globalUserList[i].type == 'student') {
        students.add(globalUserList[i]);
      }
    }
    return students;
  }
}
