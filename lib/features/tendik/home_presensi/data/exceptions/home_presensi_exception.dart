class HomePresensiException implements Exception {
  final String message;

  const HomePresensiException([
    this.message = 'Terjadi kesalahan pada data Home Presensi',
  ]);

  @override
  String toString() => 'HomePresensiException: $message';
}
