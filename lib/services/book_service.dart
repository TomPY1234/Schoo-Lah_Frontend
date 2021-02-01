import 'package:schoolah_mobile_app/models/book.dart';

abstract class BookService {
  Future<List<Book>> getAllBooks();
}
