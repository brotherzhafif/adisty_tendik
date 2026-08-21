import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/models/monitoring_presensi_model.dart';
import 'widgets/lokasi_presensi_card.dart';
import 'widgets/detail_info_row.dart';
import 'widgets/shift_block.dart';

// ============================================================
// HALAMAN / KOMPONEN: DETAIL PRESENSI MONITORING
// Mendukung single shift & double shift
// ============================================================
class DetailPresensiKoreksi extends StatefulWidget {
  /// Semua tanggal yang tersedia (dari BLoC / JSON)
  final List<MonitoringTanggalModel> listTanggal;

  /// Index tanggal yang sedang aktif saat halaman dibuka
  final int initialTanggalIndex;

  /// ID pegawai — digunakan untuk mencari ulang pegawai di tanggal yang dipilih
  final String pegawaiId;

  const DetailPresensiKoreksi({
    super.key,
    required this.listTanggal,
    required this.initialTanggalIndex,
    required this.pegawaiId,
  });

  @override
  State<DetailPresensiKoreksi> createState() => _DetailPresensiKoreksiState();
}

class _DetailPresensiKoreksiState extends State<DetailPresensiKoreksi> {
  late int _tanggalIndex;
  MonitoringPegawaiModel? _pegawai;

  @override
  void initState() {
    super.initState();
    _tanggalIndex = widget.initialTanggalIndex;
    _pegawai = _findPegawai(_tanggalIndex);
  }

  MonitoringPegawaiModel? _findPegawai(int tanggalIndex) {
    if (tanggalIndex < 0 || tanggalIndex >= widget.listTanggal.length) {
      return null;
    }
    final list = widget.listTanggal[tanggalIndex].pegawai;
    try {
      return list.firstWhere((p) => p.id == widget.pegawaiId);
    } catch (_) {
      // Pegawai tidak hadir/tidak ada di tanggal ini
      return null;
    }
  }

  // ── Status helpers ──────────────────────────────────────────
  bool get _isLate =>
      (_pegawai?.status ?? '').toLowerCase() == 'late' ||
      (_pegawai?.status ?? '').toLowerCase() == 'terlambat';
  bool get _isAbsent =>
      (_pegawai?.status ?? '').toLowerCase() == 'absent' ||
      (_pegawai?.status ?? '').toLowerCase() == 'alpa';
  bool get _isDoubleShift => _pegawai?.masuk2 != null;

  Color get _statusBgColor {
    if (_isLate) return const Color(0x19FFAC2F);
    if (_isAbsent) return const Color(0x19E65768);
    return const Color(0x1918C079);
  }

  Color get _statusTextColor {
    if (_isLate) return const Color(0xFFFFAC2F);
    if (_isAbsent) return const Color(0xFFE65768);
    return const Color(0xFF18C079);
  }

  // ── Campus coordinate lookup ─────────────────────────────────
  /// Memetakan nama kampus ke koordinat. Fallback ke Kampus 4 UAD.
  static const Map<String, List<double>> _campusCoords = {
    'Kampus 1 UAD': [-7.8003, 110.3645],
    'Kampus 2 UAD': [-7.8163, 110.3827],
    'Kampus 3 UAD': [-7.8245, 110.3898],
    'Kampus 4 UAD': [-7.8331, 110.3831],
    'Kampus 5 UAD': [-7.7959, 110.4028],
  };

  double get _latitude {
    final key = _campusCoords.keys.firstWhere(
      (k) => (_pegawai?.lokasi ?? '').toLowerCase().contains(k.toLowerCase()),
      orElse: () => 'Kampus 4 UAD',
    );
    return _campusCoords[key]![0];
  }

  double get _longitude {
    final key = _campusCoords.keys.firstWhere(
      (k) => (_pegawai?.lokasi ?? '').toLowerCase().contains(k.toLowerCase()),
      orElse: () => 'Kampus 4 UAD',
    );
    return _campusCoords[key]![1];
  }

  // ── Date picker ─────────────────────────────────────────────
  Future<void> _openDatePicker() async {
    final dates = widget.listTanggal
        .map((t) => _parseTanggalIndonesia(t.tanggalLengkap))
        .whereType<DateTime>()
        .toList();
    if (dates.isEmpty) return;

    final currentTanggal = widget.listTanggal[_tanggalIndex];
    final initialDate =
        _parseTanggalIndonesia(currentTanggal.tanggalLengkap) ?? dates.first;
    final firstDate = dates.reduce((a, b) => a.isBefore(b) ? a : b);
    final lastDate = dates.reduce((a, b) => a.isAfter(b) ? a : b);

    DateTime? picked;

    if (Platform.isIOS) {
      picked = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (ctx) {
          DateTime temp = initialDate;
          return Container(
            height: 320,
            color: CupertinoColors.systemBackground.resolveFrom(ctx),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const Text('Batal'),
                      onPressed: () => Navigator.of(ctx).pop(null),
                    ),
                    CupertinoButton(
                      child: const Text(
                        'Pilih',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(temp),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDate,
                    minimumDate: firstDate,
                    maximumDate: lastDate,
                    onDateTimeChanged: (dt) => temp = dt,
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        locale: const Locale('id', 'ID'),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2B86C3),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF293241),
            ),
          ),
          child: child!,
        ),
      );
    }

    if (picked == null || !mounted) return;

    for (int i = 0; i < widget.listTanggal.length; i++) {
      final d = _parseTanggalIndonesia(widget.listTanggal[i].tanggalLengkap);
      if (d != null &&
          d.year == picked.year &&
          d.month == picked.month &&
          d.day == picked.day) {
        setState(() {
          _tanggalIndex = i;
          _pegawai = _findPegawai(i);
        });
        return;
      }
    }
  }

  // ── Build ───────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final currentTanggal = widget.listTanggal[_tanggalIndex];
    final pegawai = _pegawai;
    final isDoubleShift = _isDoubleShift;

    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B86C3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Detail Presensi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const ShapeDecoration(
                color: Color(0xFFF6F7F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(34),
                    topRight: Radius.circular(34),
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── 1. Date Header Card (clickable → date picker) ──
                      _DateHeaderCard(
                        tanggal: currentTanggal.labelTanggal,
                        onTap: _openDatePicker,
                      ),
                      const SizedBox(height: 14),

                      if (pegawai == null)
                        _buildNotFoundCard(currentTanggal.tanggalLengkap)
                      else ...[
                        // ── 2. Profile Card ────────────────────────────
                        _ProfileCard(
                          nama: pegawai.nama,
                          unit: pegawai.unit,
                          jabatan: pegawai.jabatan,
                          status: pegawai.status,
                          photoUrl: pegawai.photoUrl,
                          statusBgColor: _statusBgColor,
                          statusTextColor: _statusTextColor,
                          isDoubleShift: isDoubleShift,
                        ),
                        const SizedBox(height: 14),

                        // ── 3. Informasi Presensi Card ─────────────────
                        _buildCard(
                          title: 'Informasi Presensi',
                          children: [
                            DetailInfoRow(
                              icon: Icons.location_on_outlined,
                              iconBgColor: const Color(0x1EE65768),
                              iconColor: const Color(0xFFE65768),
                              label: 'Lokasi',
                              value: pegawai.lokasi,
                            ),
                            if (isDoubleShift) ...[
                              const Divider(
                                height: 24,
                                color: Color(0xFFEEF2F3),
                              ),
                              const DetailInfoRow(
                                icon: Icons.schedule,
                                iconBgColor: Color(0x1E2B86C3),
                                iconColor: Color(0xFF2B86C3),
                                label: 'Shift Hari Ini',
                                value: 'Double Shift',
                              ),
                            ],
                            const Divider(height: 24, color: Color(0xFFEEF2F3)),
                            DetailInfoRow(
                              icon: Icons.directions_car_outlined,
                              iconBgColor: const Color(0x1E2B86C3),
                              iconColor: const Color(0xFF2B86C3),
                              label: 'Transport',
                              value: pegawai.transport.startsWith('Rp')
                                  ? pegawai.transport
                                  : 'Rp ${pegawai.transport}',
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // ── 4. Detail Presensi / Detail Shift Card ─────
                        _buildCard(
                          title: isDoubleShift
                              ? 'Detail Shift'
                              : 'Detail Presensi',
                          children: [
                            if (!isDoubleShift) ...[
                              ShiftBlock(
                                shiftName: _statusLabel(pegawai.status),
                                tagBgColor: _statusBgColor,
                                tagTextColor: _statusTextColor,
                                masuk: pegawai.masuk,
                                pulang: pegawai.pulang,
                                durasi: pegawai.durasi,
                              ),
                            ] else ...[
                              ShiftBlock(
                                shiftName: 'Shift 1',
                                masuk: pegawai.masuk,
                                pulang: pegawai.pulang,
                                durasi: pegawai.durasi,
                              ),
                              const Divider(
                                height: 24,
                                color: Color(0xFFEEF2F3),
                              ),
                              ShiftBlock(
                                shiftName: 'Shift 2',
                                masuk: pegawai.masuk2!,
                                pulang: pegawai.pulang2 ?? '-',
                                durasi: pegawai.durasi2 ?? '-',
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 14),

                        // ── 5. Total Durasi Kerja ──────────────────────
                        _buildTotalDurasi(
                          isDoubleShift: isDoubleShift,
                          durasi: pegawai.durasi,
                          durasi2: pegawai.durasi2,
                        ),
                        const SizedBox(height: 14),

                        // ── 6. Lokasi Presensi (FlutterMap / OSM) ──────
                        LokasiPresensiCard(
                          namaLokasi: pegawai.lokasi,
                          alamatLine1: _resolveAlamat(pegawai.lokasi),
                          alamatLine2: 'Universitas Ahmad Dahlan',
                          latitude: _latitude,
                          longitude: _longitude,
                        ),

                        // ── 7. Alasan Koreksi (conditional) ───────────
                        if (pegawai.alasanKoreksi != null &&
                            pegawai.alasanKoreksi!.isNotEmpty) ...[
                          const SizedBox(height: 14),
                          _AlasanKoreksiCard(alasan: pegawai.alasanKoreksi!),
                        ],
                      ],

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────

  /// Card section wrapper (sama persis seperti di detail.dart)
  Widget _buildCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadows: const [
          BoxShadow(
            color: Color(0x087281DF),
            blurRadius: 4.11,
            offset: Offset(0, 0.52),
          ),
          BoxShadow(
            color: Color(0x0C7281DF),
            blurRadius: 6.99,
            offset: Offset(0, 1.78),
          ),
          BoxShadow(
            color: Color(0x0F7281DF),
            blurRadius: 10.20,
            offset: Offset(0, 4.11),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 1.50,
              letterSpacing: -0.27,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  /// Total Durasi Kerja — blue box (0xFFE8F1F9)
  Widget _buildTotalDurasi({
    required bool isDoubleShift,
    required String durasi,
    String? durasi2,
  }) {
    final totalLabel = isDoubleShift && durasi2 != null
        ? _addDurasi(durasi, durasi2)
        : durasi;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: ShapeDecoration(
        color: const Color(0xFFE8F1F9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Durasi Kerja',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.17,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            totalLabel,
            style: const TextStyle(
              color: Color(0xFF0067AD),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.34,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Sudah termasuk istirahat',
            style: TextStyle(
              color: Color(0xFF7A8089),
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Sederhana menjumlahkan dua string durasi "X Jam Y Menit"
  String _addDurasi(String d1, String d2) {
    int parseMinutes(String d) {
      final jamMatch = RegExp(r'(\d+)\s*[Jj]am').firstMatch(d);
      final menitMatch = RegExp(r'(\d+)\s*[Mm]enit').firstMatch(d);
      final jam = int.tryParse(jamMatch?.group(1) ?? '0') ?? 0;
      final menit = int.tryParse(menitMatch?.group(1) ?? '0') ?? 0;
      return jam * 60 + menit;
    }

    final total = parseMinutes(d1) + parseMinutes(d2);
    final jam = total ~/ 60;
    final menit = total % 60;
    if (menit == 0) return '$jam Jam';
    return '$jam Jam $menit Menit';
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'on time':
        return 'Tepat Waktu';
      case 'terlambat':
      case 'late':
        return 'Terlambat';
      case 'absent':
      case 'alpa':
        return 'Tidak Hadir';
      default:
        return status;
    }
  }

  Widget _buildNotFoundCard(String tanggal) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.event_busy_rounded,
            color: Color(0xFFAEB1B7),
            size: 48,
          ),
          const SizedBox(height: 12),
          const Text(
            'Data tidak tersedia',
            style: TextStyle(
              color: Color(0xFF293241),
              fontSize: 15,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pegawai ini tidak memiliki data presensi\npada $tanggal.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF8B9098),
              fontSize: 13,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  /// Mengembalikan baris alamat berdasarkan nama kampus
  static String _resolveAlamat(String lokasiNama) {
    final lower = lokasiNama.toLowerCase();
    if (lower.contains('kampus 1')) {
      return 'Jl. Kapas 9, Semaki, Umbulharjo';
    }
    if (lower.contains('kampus 2')) {
      return 'Jl. Pramuka 42, Sidikan, Umbulharjo';
    }
    if (lower.contains('kampus 3')) {
      return 'Jl. Prof. Dr. Soepomo, Janturan';
    }
    if (lower.contains('kampus 5')) {
      return 'Jl. Ki Ageng Pemanahan 19';
    }
    // default → kampus 4
    return 'Jl. Ringroad Selatan, Tamanan, Banguntapan';
  }
}

// ============================================================
// HELPER: parse "9 September 2026" / "Rabu, 9 September 2026" → DateTime
// ============================================================
DateTime? _parseTanggalIndonesia(String label) {
  const bulanMap = {
    'Januari': 1,
    'Februari': 2,
    'Maret': 3,
    'April': 4,
    'Mei': 5,
    'Juni': 6,
    'Juli': 7,
    'Agustus': 8,
    'September': 9,
    'Oktober': 10,
    'November': 11,
    'Desember': 12,
  };
  final cleaned = label.contains(',')
      ? label.split(',').last.trim()
      : label.trim();
  final parts = cleaned.split(' ');
  if (parts.length < 3) return null;
  final day = int.tryParse(parts[0]);
  final month = bulanMap[parts[1]];
  final year = int.tryParse(parts[2]);
  if (day == null || month == null || year == null) return null;
  return DateTime(year, month, day);
}

// ============================================================
// SUB-WIDGETS (private)
// ============================================================

class _DateHeaderCard extends StatelessWidget {
  final String tanggal;
  final VoidCallback onTap;

  const _DateHeaderCard({required this.tanggal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 14),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x087281DF),
              blurRadius: 4.11,
              offset: Offset(0, 0.52),
            ),
            BoxShadow(
              color: Color(0x0C7281DF),
              blurRadius: 6.99,
              offset: Offset(0, 1.78),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: ShapeDecoration(
                color: const Color(0x1E0067AD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: Color(0xFF0067AD),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                tanggal,
                style: const TextStyle(
                  color: Color(0xFF293241),
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.27,
                ),
              ),
            ),
            const Icon(
              Icons.calendar_today_rounded,
              color: Color(0xFF8B9098),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String nama;
  final String unit;
  final String jabatan;
  final String status;
  final String photoUrl;
  final Color statusBgColor;
  final Color statusTextColor;
  final bool isDoubleShift;

  const _ProfileCard({
    required this.nama,
    required this.unit,
    required this.jabatan,
    required this.status,
    required this.photoUrl,
    required this.statusBgColor,
    required this.statusTextColor,
    required this.isDoubleShift,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadows: const [
          BoxShadow(
            color: Color(0x087281DF),
            blurRadius: 4.11,
            offset: Offset(0, 0.52),
          ),
          BoxShadow(
            color: Color(0x0C7281DF),
            blurRadius: 6.99,
            offset: Offset(0, 1.78),
          ),
          BoxShadow(
            color: Color(0x0F7281DF),
            blurRadius: 10.20,
            offset: Offset(0, 4.11),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(64),
            child: Image.network(
              photoUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2B86C3),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 32),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  unit,
                  style: const TextStyle(
                    color: Color(0xFFAEB1B7),
                    fontSize: 10,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                Text(
                  jabatan,
                  style: const TextStyle(
                    color: Color(0xFFAEB1B7),
                    fontSize: 10,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: ShapeDecoration(
                        color: statusBgColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusTextColor,
                          fontSize: 11,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.18,
                        ),
                      ),
                    ),
                    if (isDoubleShift)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE8F1F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'Double Shift',
                          style: TextStyle(
                            color: Color(0xFF016EB8),
                            fontSize: 11,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.18,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AlasanKoreksiCard extends StatelessWidget {
  final String alasan;
  const _AlasanKoreksiCard({required this.alasan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadows: const [
          BoxShadow(
            color: Color(0x087281DF),
            blurRadius: 4.11,
            offset: Offset(0, 0.52),
          ),
          BoxShadow(
            color: Color(0x0C7281DF),
            blurRadius: 6.99,
            offset: Offset(0, 1.78),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: ShapeDecoration(
                  color: const Color(0x1EFFAC2F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                  ),
                ),
                child: const Icon(
                  Icons.edit_note_rounded,
                  color: Color(0xFFFFAC2F),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Alasan Koreksi',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F7F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              alasan,
              style: const TextStyle(
                color: Color(0xFF5F6570),
                fontSize: 14,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
