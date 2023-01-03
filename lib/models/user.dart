import './book.dart';

class User {
  final String userID;
  final String username;
  final List<Book> books;

  const User({
    required this.userID,
    required this.username,
    required this.books,
  });

  factory User.fromJson(Map<String, dynamic> userJson) {
    final List<Book> books = [];

    final List<dynamic> bookJsonList = userJson['books'] as List<dynamic>;
    if (bookJsonList.isNotEmpty) {
      for (Map<String, dynamic> bookJson
          in bookJsonList as List<Map<String, dynamic>>) {
        final book = Book.fromJson(bookJson);
        books.add(book);
      }
    }

    return User(
      userID: userJson['userID'],
      username: userJson['username'],
      books: books,
    );
  }

  @override
  String toString() {
    return '{userID: $userID, username: $username, books: $books}';
  }
}
