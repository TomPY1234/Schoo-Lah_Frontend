import 'package:schoolah_mobile_app/dependencies.dart';
import 'package:schoolah_mobile_app/mainScreens/viewmodel.dart';
import 'package:schoolah_mobile_app/models/book.dart';
import 'package:schoolah_mobile_app/services/book_service.dart';

// The todo list is user-specific
class BooklistViewmodel extends Viewmodel {
  List<Book> books;

  BooklistViewmodel();
  BookService get dataService => service();

  Future<void> getAllBooks() async {
    turnBusy();
    books = await dataService.getAllBooks();
    print(books);
    turnIdle();
    // notifyListeners();
  }
}