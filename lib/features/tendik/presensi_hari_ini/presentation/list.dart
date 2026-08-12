import 'package:flutter/material.dart';
import 'detail.dart';
import 'widgets/riwayat_pengajuan_item.dart';
import '../../rekap_presensi/presentation/widgets/bulan_picker_modal.dart';

// ============================================================
// DATA MODEL: RIWAYAT PENGAJUAN DATA ITEM & BULAN
// ============================================================
class RiwayatPengajuanData {
  final StatusPengajuan status;
  final String date;
  final String type;
  final String diajukan;
  final String perubahanLabel;
  final String oldValue;
  final String newValue;

  const RiwayatPengajuanData({
    required this.status,
    required this.date,
    required this.type,
    required this.diajukan,
    required this.perubahanLabel,
    required this.oldValue,
    required this.newValue,
  });
}

class RiwayatBulanDataModel {
  final String labelBulan;
  final List<RiwayatPengajuanData> items;

  const RiwayatBulanDataModel({
    required this.labelBulan,
    required this.items,
  });

  int get year {
    final parts = labelBulan.trim().split(' ');
    if (parts.length >= 2) {
      return int.tryParse(parts.last) ?? DateTime.now().year;
    }
    return DateTime.now().year;
  }

  int get month {
    final parts = labelBulan.trim().split(' ');
    if (parts.isNotEmpty) {
      switch (parts.first.toLowerCase()) {
        case 'januari':
        case 'jan':
          return 1;
        case 'februari':
        case 'feb':
          return 2;
        case 'maret':
        case 'mar':
          return 3;
        case 'april':
        case 'apr':
          return 4;
        case 'mei':
          return 5;
        case 'juni':
        case 'jun':
          return 6;
        case 'juli':
        case 'jul':
          return 7;
        case 'agustus':
        case 'agu':
        case 'agt':
          return 8;
        case 'september':
        case 'sep':
          return 9;
        case 'oktober':
        case 'okt':
          return 10;
        case 'november':
        case 'nov':
          return 11;
        case 'desember':
        case 'des':
          return 12;
      }
    }
    return 1;
  }

  bool isAfterDate(DateTime date) {
    if (year > date.year) return true;
    if (year == date.year && month > date.month) return true;
    return false;
  }
}

// ============================================================
// HALAMAN: Riwayat Pengajuan Koreksi Presensi
// ============================================================
class RiwayatKoreksiPage extends StatefulWidget {
  const RiwayatKoreksiPage({super.key});

  @override
  State<RiwayatKoreksiPage> createState() => _RiwayatKoreksiPageState();
}

class _RiwayatKoreksiPageState extends State<RiwayatKoreksiPage> {
  int _currentIndex = 0;
  bool _slideLeft = true;

  // --- DATA DUMMY BERDASARKAN BULAN ---
  static const List<RiwayatBulanDataModel> _daftarBulanDummy = [
    RiwayatBulanDataModel(
      labelBulan: 'April 2026',
      items: [
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Rabu, 22 April 2026',
          type: 'Presensi',
          diajukan: '22 Apr 2026 · 17:00',
          perubahanLabel: 'Jam Pulang',
          oldValue: '-',
          newValue: '17:00',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Selasa, 14 April 2026',
          type: 'Presensi',
          diajukan: '14 Apr 2026 · 08:15',
          perubahanLabel: 'Jam Masuk',
          oldValue: '08:15',
          newValue: '07:30',
        ),
      ],
    ),
    RiwayatBulanDataModel(
      labelBulan: 'Mei 2026',
      items: [
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Rabu, 27 Mei 2026',
          type: 'Presensi',
          diajukan: '27 Mei 2026 · 16:30',
          perubahanLabel: 'Jam Pulang',
          oldValue: '15:30',
          newValue: '16:30',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Senin, 18 Mei 2026',
          type: 'Presensi',
          diajukan: '18 Mei 2026 · 08:00',
          perubahanLabel: 'Jam Masuk',
          oldValue: '08:20',
          newValue: '07:40',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.ditolak,
          date: 'Kamis, 07 Mei 2026',
          type: 'Shift',
          diajukan: '07 Mei 2026 · 14:00',
          perubahanLabel: 'Tukar Shift',
          oldValue: 'Shift 1',
          newValue: 'Shift 2',
        ),
      ],
    ),
    RiwayatBulanDataModel(
      labelBulan: 'Juni 2026',
      items: [
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Jumat, 26 Juni 2026',
          type: 'Presensi',
          diajukan: '26 Jun 2026 · 17:15',
          perubahanLabel: 'Jam Pulang',
          oldValue: '16:00',
          newValue: '17:00',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.ditolak,
          date: 'Selasa, 16 Juni 2026',
          type: 'Lupa Absen',
          diajukan: '16 Jun 2026 · 09:45',
          perubahanLabel: 'Jam Masuk',
          oldValue: '-',
          newValue: '07:45',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Kamis, 04 Juni 2026',
          type: 'Presensi',
          diajukan: '04 Jun 2026 · 08:10',
          perubahanLabel: 'Jam Masuk',
          oldValue: '08:10',
          newValue: '07:30',
        ),
      ],
    ),
    RiwayatBulanDataModel(
      labelBulan: 'Juli 2026',
      items: [
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Rabu, 29 Juli 2026',
          type: 'Presensi',
          diajukan: '29 Jul 2026 · 16:30',
          perubahanLabel: 'Jam Pulang',
          oldValue: '-',
          newValue: '16:30',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.ditolak,
          date: 'Kamis, 23 Juli 2026',
          type: 'Dinas Luar',
          diajukan: '23 Jul 2026 · 09:00',
          perubahanLabel: 'Lokasi Presensi',
          oldValue: 'Kampus 4',
          newValue: 'Gedung Rektorat',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Selasa, 14 Juli 2026',
          type: 'Presensi',
          diajukan: '14 Jul 2026 · 08:30',
          perubahanLabel: 'Jam Masuk',
          oldValue: '08:05',
          newValue: '07:25',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Senin, 06 Juli 2026',
          type: 'Izin Jam Kerja',
          diajukan: '06 Jul 2026 · 13:00',
          perubahanLabel: 'Izin Keluar Kantor',
          oldValue: '-',
          newValue: '13:00 - 15:00',
        ),
      ],
    ),
    RiwayatBulanDataModel(
      labelBulan: 'Agustus 2026',
      items: [
        RiwayatPengajuanData(
          status: StatusPengajuan.menunggu,
          date: 'Senin, 10 Agustus 2026',
          type: 'Presensi',
          diajukan: '10 Agu 2026 · 16:45',
          perubahanLabel: 'Jam Pulang',
          oldValue: '14:00',
          newValue: '16:30',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.menunggu,
          date: 'Rabu, 05 Agustus 2026',
          type: 'Presensi',
          diajukan: '05 Agu 2026 · 08:15',
          perubahanLabel: 'Jam Masuk',
          oldValue: '08:15',
          newValue: '07:30',
        ),
        RiwayatPengajuanData(
          status: StatusPengajuan.disetujui,
          date: 'Jumat, 01 Agustus 2026',
          type: 'Lupa Absen',
          diajukan: '01 Agu 2026 · 17:00',
          perubahanLabel: 'Presensi Lupa Absen',
          oldValue: '-',
          newValue: '17:00',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    int defaultIdx = _daftarBulanDummy.indexWhere(
      (b) => b.year == now.year && b.month == now.month,
    );
    if (defaultIdx == -1) {
      defaultIdx = _daftarBulanDummy.lastIndexWhere(
        (b) => !b.isAfterDate(now),
      );
    }
    if (defaultIdx == -1) {
      defaultIdx = _daftarBulanDummy.isNotEmpty ? 0 : 0;
    }
    _currentIndex = defaultIdx;
  }

  bool _canGoNext() {
    return _currentIndex < _daftarBulanDummy.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final bulanAktif = _daftarBulanDummy.isNotEmpty &&
            _currentIndex >= 0 &&
            _currentIndex < _daftarBulanDummy.length
        ? _daftarBulanDummy[_currentIndex]
        : const RiwayatBulanDataModel(labelBulan: '', items: []);

    final bool canGoNext = _canGoNext();

    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Riwayat Pengajuan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF6F7F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
            topRight: Radius.circular(34),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onHorizontalDragEnd: (details) {
            final dx = details.velocity.pixelsPerSecond.dx;
            if (dx < -300) {
              if (canGoNext) {
                setState(() {
                  _slideLeft = true;
                  _currentIndex++;
                });
              }
            } else if (dx > 300) {
              if (_currentIndex > 0) {
                setState(() {
                  _slideLeft = false;
                  _currentIndex--;
                });
              }
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Card Selector Bulan & Tahun ---
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Panah Kiri
                      IconButton(
                        icon: const Icon(Icons.chevron_left_rounded, size: 24),
                        color: _currentIndex > 0
                            ? const Color(0xFF293241)
                            : const Color(0xFFCCCED1),
                        onPressed: _currentIndex > 0
                            ? () {
                                setState(() {
                                  _slideLeft = false;
                                  _currentIndex--;
                                });
                              }
                            : null,
                      ),

                      // Teks Bulan & Tahun (AnimatedSwitcher & Search Picker Modal)
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final listBulanLabels = _daftarBulanDummy
                                .map((b) => b.labelBulan)
                                .toList();
                            final selectedIndex = await BulanPickerModal.show(
                              context,
                              listBulan: listBulanLabels,
                              selectedBulan: bulanAktif.labelBulan,
                            );
                            if (selectedIndex != null && selectedIndex != -1) {
                              setState(() {
                                _slideLeft = selectedIndex < _currentIndex;
                                _currentIndex = selectedIndex;
                              });
                            }
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 36,
                            child: Center(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 280),
                                transitionBuilder: (child, animation) {
                                  final offset = _slideLeft
                                      ? const Offset(-0.4, 0)
                                      : const Offset(0.4, 0);
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: offset,
                                      end: Offset.zero,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOutCubic,
                                      ),
                                    ),
                                    child: FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    ),
                                  );
                                },
                                child: Text(
                                  bulanAktif.labelBulan,
                                  key: ValueKey(bulanAktif.labelBulan),
                                  style: const TextStyle(
                                    color: Color(0xFF293241),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Panah Kanan (Disabled jika di bulan terakhir)
                      IconButton(
                        icon: const Icon(Icons.chevron_right_rounded, size: 24),
                        color: canGoNext
                            ? const Color(0xFF293241)
                            : const Color(0xFFCCCED1),
                        onPressed: canGoNext
                            ? () {
                                setState(() {
                                  _slideLeft = true;
                                  _currentIndex++;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- Daftar Item Pengajuan untuk Bulan Terpilih ---
                if (bulanAktif.items.isEmpty)
                  _buildEmptyState()
                else
                  ...bulanAktif.items.map((item) {
                    return RiwayatPengajuanItem(
                      status: item.status,
                      date: item.date,
                      type: item.type,
                      diajukan: item.diajukan,
                      perubahanLabel: item.perubahanLabel,
                      oldValue: item.oldValue,
                      newValue: item.newValue,
                      onDetailTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RiwayatKoreksiDetailPage.demo(),
                          ),
                        );
                      },
                    );
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 56, color: Color(0xFFCCCED1)),
          SizedBox(height: 12),
          Text(
            'Belum ada riwayat pengajuan',
            style: TextStyle(
              color: Color(0xFFAEB1B7),
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Pengajuan koreksi presensi Anda pada bulan ini akan tampil di sini',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFCCCED1),
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

