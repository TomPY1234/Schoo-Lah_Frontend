import 'package:get_it/get_it.dart';
import 'package:schoolah_mobile_app/services/book_service.dart';
import 'package:schoolah_mobile_app/services/book_service_rest.dart';
import 'package:schoolah_mobile_app/services/fee_service_rest.dart';
import 'package:schoolah_mobile_app/services/qrcode_data_service.dart';
import 'models/mock_qrcode.dart';
import 'package:schoolah_mobile_app/services/todo_service_rest.dart';
import 'package:schoolah_mobile_app/services/user_service.dart';
import 'package:schoolah_mobile_app/services/user_service_rest.dart';
import 'services/fee_service.dart';
import 'services/rest_service.dart';
import 'services/todo_service.dart';

GetIt service = GetIt.instance;

void init() {
  service.registerLazySingleton(() => RestService());

  service.registerLazySingleton<TodoService>(() => TodoServiceRest());
  service.registerLazySingleton<BookService>(() => BookServiceRest());
  service.registerLazySingleton<UserService>(() => UserServiceRest());
  service.registerLazySingleton<FeeService>(() => FeeServiceRest());
  service.registerLazySingleton<QRCodeDataService>(() => QRCodeDataServiceMock());
}
