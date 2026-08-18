import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/models/monitoring_presensi_model.dart';
import 'widgets/lokasi_presensi_card.dart';

// ============================================================
// HALAMAN / KOMPONEN: DETAIL PRESENSI & KOREKSI MONITORING
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
          'Detail Presensi & Koreksi',
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
                    children: [
                      // ── Date Header Card (clickable → native date picker) ──
                      _DateHeaderCard(
                        tanggal: currentTanggal.labelTanggal,
                        onTap: _openDatePicker,
                      ),

                      const SizedBox(height: 14),

                      if (pegawai == null)
                        _buildNotFoundCard(currentTanggal.tanggalLengkap)
                      else ...[
                        // ── Profile & Status Card ────────────────────────
                        _ProfileCard(
                          nama: pegawai.nama,
                          unit: pegawai.unit,
                          jabatan: pegawai.jabatan,
                          status: pegawai.status,
                          photoUrl: pegawai.photoUrl,
                          statusBgColor: _statusBgColor,
                          statusTextColor: _statusTextColor,
                        ),

                        const SizedBox(height: 14),

                        // ── Informasi Presensi Card ──────────────────────
                        _InfoPresensiCard(
                          lokasi: pegawai.lokasi,
                          jamMasuk: pegawai.masuk,
                          jamPulang: pegawai.pulang,
                        ),

                        const SizedBox(height: 14),

                        // ── Lokasi Presensi (FlutterMap / OSM) ───────────
                        LokasiPresensiCard(
                          namaLokasi: pegawai.lokasi,
                          alamatLine1: _resolveAlamat(pegawai.lokasi),
                          alamatLine2: 'Universitas Ahmad Dahlan',
                          latitude: _latitude,
                          longitude: _longitude,
                        ),

                        // ── Alasan Koreksi (conditional) ─────────────────
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

  const _ProfileCard({
    required this.nama,
    required this.unit,
    required this.jabatan,
    required this.status,
    required this.photoUrl,
    required this.statusBgColor,
    required this.statusTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPresensiCard extends StatelessWidget {
  final String lokasi;
  final String jamMasuk;
  final String jamPulang;

  const _InfoPresensiCard({
    required this.lokasi,
    required this.jamMasuk,
    required this.jamPulang,
  });

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: ShapeDecoration(
            color: iconBgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF5F6570),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.08,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF293241),
                fontSize: 15,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

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
          BoxShadow(
            color: Color(0x0F7281DF),
            blurRadius: 10.20,
            offset: Offset(0, 4.11),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Presensi',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.27,
            ),
          ),
          const SizedBox(height: 14),
          _buildInfoRow(
            icon: Icons.location_on_rounded,
            iconBgColor: const Color(0x1EE65768),
            iconColor: const Color(0xFFE65768),
            label: 'Lokasi',
            value: lokasi,
          ),
          const Divider(height: 20, color: Color(0xFFEEEEEE)),
          _buildInfoRow(
            icon: Icons.login_rounded,
            iconBgColor: const Color(0x1E18C079),
            iconColor: const Color(0xFF18C079),
            label: 'Jam Masuk',
            value: '$jamMasuk WIB',
          ),
          const Divider(height: 20, color: Color(0xFFEEEEEE)),
          _buildInfoRow(
            icon: Icons.logout_rounded,
            iconBgColor: const Color(0x1EFFAC2F),
            iconColor: const Color(0xFFFFAC2F),
            label: 'Jam Pulang',
            value: '$jamPulang WIB',
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
