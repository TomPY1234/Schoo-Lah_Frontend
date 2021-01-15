import 'package:schoolah_mobile_app/services/user_data_service.dart';

import 'user.dart';

List<User> globalUserList = [
  User(
      id: 1,
      username: 'ahmadaiman',
      password: 'ahmad123',
      name: 'Ahmad Aiman',
      type: 'student',
      year: 5,
      school: 'SK Impian Emas',
      phone: '0197542776',
      email: 'ahmad.aiman@gmail.com'),
  User(
      id: 2,
      username: 'nurain',
      password: 'ain123',
      name: 'Nur Ain',
      type: 'teacher',
      year: 0,
      phone: '0175875565',
      email: 'ainn765@gmail.com'),
];

class UserDataServiceMock implements UserDataService {
  User currUser;
  int nextId = 3;
  Future<User> login(String us, String pw) async {
    for (var u in globalUserList) {
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
        id: nextId++,
        username: username,
        password: password,
        name: name,
        year: year,
        school: school,
        email: email,
        type: type,
        phone: phone);
    globalUserList.add(newuser);
  }

  Future<User> getCurrentUser() async {
    return currUser;
  }

  Future updateDetails(
      {String name,
      int year,
      String school,
      String phone,
      String email}) async {
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
    currUser.name = name;
    currUser.year = year;
    currUser.school = school;
    currUser.phone = phone;
    currUser.email = email;
  }

  Future<List<User>> getStudentList() async {
    List<User> students;

    for (var u in globalUserList) {
      if (u.type == 'student') students.add(u);
      print(u.type);
    }
    return students;
  }
}
