import 'package:schoolah_mobile_app/models/book.dart';

abstract class BookDataService {
  Future<List<Book>> getBookList();
}
