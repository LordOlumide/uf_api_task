class NetworkRequestException {
  final String message;
  final int code;

  const NetworkRequestException({required this.message, required this.code});

  @override
  String toString() {
    return '{message: $message, code: $code}';
  }
}
