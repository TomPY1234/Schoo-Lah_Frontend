import 'package:schoolah_mobile_app/dependencies.dart';
import 'package:schoolah_mobile_app/mainScreens/viewmodel.dart';
import 'package:schoolah_mobile_app/models/user.dart';
import 'package:schoolah_mobile_app/services/user_service.dart';

// The todo list is user-specific
class UserlistViewmodel extends Viewmodel {
  List<User> users;

  UserlistViewmodel();
  UserService get dataService => service();

  Future<void> getStudentList() async {
    turnBusy();
    users = await dataService.getStudentList();
    print(users);
    turnIdle();
    // notifyListeners();
  }
}
