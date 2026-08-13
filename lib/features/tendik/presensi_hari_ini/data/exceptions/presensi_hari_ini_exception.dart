class PresensiHariIniException implements Exception {
  final String message;

  const PresensiHariIniException([
    this.message = 'Terjadi kesalahan pada data Presensi Hari Ini',
  ]);

  @override
  String toString() => 'PresensiHariIniException: $message';
}
