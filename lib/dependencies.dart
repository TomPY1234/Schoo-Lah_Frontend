import 'package:get_it/get_it.dart';
import 'package:schoolah_mobile_app/models/mock_todos.dart';
import 'package:schoolah_mobile_app/services/book_service.dart';
import 'package:schoolah_mobile_app/services/book_service_rest.dart';
import 'package:schoolah_mobile_app/services/fee_service_rest.dart';
import 'package:schoolah_mobile_app/services/user_data_service.dart';
import 'package:schoolah_mobile_app/services/qrcode_data_service.dart';
import 'models/mock_qrcode.dart';
import 'models/mock_users.dart';
import 'services/fee_service.dart';
import 'services/rest_service.dart';
import 'services/todo_data_service.dart';

GetIt service = GetIt.instance;

void init() {
  service.registerLazySingleton(() => RestService());

  service.registerLazySingleton<TodoDataService>(() => TodoDataServiceMock());
  service.registerLazySingleton<BookService>(() => BookServiceRest());
  service.registerLazySingleton<UserDataService>(() => UserDataServiceMock());

  service.registerLazySingleton<FeeService>(() => FeeServiceRest());
  service.registerLazySingleton<QRCodeDataService>(() => QRCodeDataServiceMock());
}
