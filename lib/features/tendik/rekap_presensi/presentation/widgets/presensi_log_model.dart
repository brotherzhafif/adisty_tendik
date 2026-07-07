// ============================================================
// DATA MODEL: PRESENSI LOG
// ============================================================
class PresensiLog {
  final String date;
  final String dayName;
  final String dayNum;
  final String status;
  final List<String> badges;
  final String location;
  final String transport;
  final String masuk;
  final String pulang;
  final String durasi;
  final String catatan;

  const PresensiLog({
    required this.date,
    required this.dayName,
    required this.dayNum,
    required this.status,
    required this.badges,
    required this.location,
    required this.transport,
    required this.masuk,
    required this.pulang,
    required this.durasi,
    this.catatan = '-',
  });
}
