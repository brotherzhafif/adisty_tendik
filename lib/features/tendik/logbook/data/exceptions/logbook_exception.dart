class LogbookException implements Exception {
  final String message;

  const LogbookException([this.message = 'Terjadi kesalahan pada data Logbook']);

  @override
  String toString() => 'LogbookException: $message';
}
