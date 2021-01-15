import 'package:get_it/get_it.dart';
import 'package:schoolah_mobile_app/models/mock_todos.dart';
import 'package:schoolah_mobile_app/services/book_data_service.dart';
import 'models/mock_books.dart';
import 'services/todo_data_service.dart';

GetIt service = GetIt.instance;

void init() {
  service.registerLazySingleton<TodoDataService>(() => TodoDataServiceMock());
  service.registerLazySingleton<BookDataService>(() => BookDataServiceMock());
}
