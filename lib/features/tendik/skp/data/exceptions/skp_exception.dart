class SkpException implements Exception {
  final String message;

  const SkpException([this.message = 'Terjadi kesalahan pada data SKP']);

  @override
  String toString() => 'SkpException: $message';
}
