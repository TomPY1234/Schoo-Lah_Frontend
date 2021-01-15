import 'package:schoolah_mobile_app/models/user.dart';

abstract class UserDataService {
  Future<User> login(String us, String pw);
  Future logout();
  Future registerNew(
      {String username,
      String password,
      String name,
      int year,
      String school,
      String email,
      String type,
      String phone});
  Future<User> getCurrentUser();

  Future<List<User>> getStudentList();
}
