class Book {
  int year;
  String title;
  int price;
  String image;

  Book({this.year, this.title, this.price, this.image});
  Book.copy(Book from)
      : this(
            year: from.year,
            title: from.title,
            price: from.price,
            image: from.image);

  Book.fromJson(Map<String, dynamic> json)
      : this(
            year: json['year'],
            title: json['title'],
            price: json['price'],
            image: json['image']);

  Map<String, dynamic> toJson() =>
      {'year': year, 'title': title, 'price': price, 'image': image};
}
