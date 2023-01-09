class Token {
  final String token;
  final DateTime expirationTime;

  const Token({
    required this.token,
    required this.expirationTime,
  });

  // factory Token.fromJson(Map<String, dynamic> tokenJson) {
  //   return Token(
  //     token: tokenJson['token'],
  //     expirationTime: DateTime.parse(tokenJson['expires']),
  //   );
  // }

  @override
  String toString() {
    return '{token: $token, expirationTime: $expirationTime}';
  }
}
