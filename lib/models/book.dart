class Book {
  int year;
  String title;
  double price;
  String image;

  Book({this.year, this.title, this.price, this.image});
  Book.copy(Book from)
      : this(
            year: from.year,
            title: from.title,
            price: from.price,
            image: from.image);

  Book.getBook(Book book)
      : this(
            year: book.year,
            title: book.title,
            price: book.price,
            image: book.image);
}
