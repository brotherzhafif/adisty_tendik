class RekapPresensiException implements Exception {
  final String message;

  const RekapPresensiException([this.message = 'Terjadi kesalahan pada data Rekap Presensi']);

  @override
  String toString() => 'RekapPresensiException: $message';
}
