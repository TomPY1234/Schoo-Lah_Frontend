import '../dependencies.dart';
import '../models/book.dart';
import 'book_service.dart';
import 'rest_service.dart';

class BookServiceRest implements BookService {
//------- Here is how we implement 'Singleton pattern' in Dart --------

  static final BookServiceRest _instance = BookServiceRest._constructor();
  factory BookServiceRest() {
    return _instance;
  }

  BookServiceRest._constructor();
  final rest = service<RestService>();

  Future<List<Book>> getAllBooks() async {
    final listJson = await rest.get('books');
    return (listJson as List)
        .map((itemJson) => Book.fromJson(itemJson))
        .toList();
  }
}
