class Book {
  final String isbn;
  final String title;
  final String subTitle;
  final String author;
  final DateTime publish_date; // "2023-01-03T06:00:53.401Z",
  final String publisher;
  final int pages;
  final String description;
  final String website;

  const Book({
    required this.isbn,
    required this.title,
    required this.subTitle,
    required this.author,
    required this.publish_date,
    required this.publisher,
    required this.pages,
    required this.description,
    required this.website,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      isbn: json['isbn'],
      title: json['title'],
      subTitle: json['subTitle'],
      author: json['author'],
      publish_date: DateTime.parse(json['publish_date']),
      publisher: json['publisher'],
      pages: json['pages'],
      description: json['description'],
      website: json['website'],
    );
  }

  @override
  String toString() {
    return '{isbn: $isbn, title: $title, subTitle: $subTitle, author: #author, '
        'publish_date: $publish_date, publisher: $publisher, pages: $pages, '
        'description: $description, website: $website}';
  }
}
