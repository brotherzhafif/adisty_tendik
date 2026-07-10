import 'package:flutter/material.dart';
import 'widgets/logbook_app_bar.dart';
import 'widgets/logbook_profile_card.dart';
import 'widgets/logbook_section_header.dart';
import 'widgets/logbook_activity_item.dart';
import 'widgets/logbook_month_stats.dart';
import 'detail.dart';
import 'form.dart';

// ============================================================
// MODEL: Data satu bulan logbook
// ============================================================
class LogbookBulanData {
  final String labelBulan;
  final List<LogbookActivityData> aktivitas;

  // Stats (null = belum ada data skor untuk bulan ini)
  final int? totalSkor;
  final int maxSkor;
  final String? kategori;
  final Color? kategoriColor;
  final int? progressPersen;

  const LogbookBulanData({
    required this.labelBulan,
    required this.aktivitas,
    this.totalSkor,
    this.maxSkor = 100,
    this.kategori,
    this.kategoriColor,
    this.progressPersen,
  });

  bool get hasSkor => totalSkor != null;
}

// ============================================================
// HALAMAN: Logbook Dashboard Tendik
// Menampilkan profil pegawai, navigasi bulan (swipeable),
// dan daftar aktivitas logbook untuk bulan yang dipilih.
// ============================================================
class LogbookPage extends StatefulWidget {
  const LogbookPage({super.key});

  @override
  State<LogbookPage> createState() => _LogbookPageState();
}

class _LogbookPageState extends State<LogbookPage> {
  int _bulanIndex = 1;

  // --- Data dummy per bulan ---
  // Pada implementasi nyata, data ini diambil dari BLoC / repository
  static final List<LogbookBulanData> _dataBulan = [
    // Mei 2026 — sudah ada skor
    LogbookBulanData(
      labelBulan: 'Mei 2026',
      totalSkor: 90,
      maxSkor: 100,
      kategori: 'Baik',
      kategoriColor: const Color(0xFF4AAF57),
      progressPersen: 80,
      aktivitas: const [
        LogbookActivityData(
          tanggal: '06',
          bulan: 'MEI',
          hariNama: 'Rabu',
          judul:
              'Membuat Algoritma Proses Fungsi-Fungsi Aplikasi - Utama Programmer',
          deskripsi:
              'Tambah internal server nama di hostname diisi softskill.id...',
        ),
        LogbookActivityData(
          tanggal: '07',
          bulan: 'MEI',
          hariNama: 'Kamis',
          judul:
              'Melakukan Pengujian Unit-unit Fungsi Sistem Aplikasi - Utama Programmer',
          deskripsi:
              'Aktivitas pengujian keamanan untuk widget yang telah selesai...',
        ),
      ],
    ),

    // Juni 2026 — sudah ada skor
    LogbookBulanData(
      labelBulan: 'Juni 2026',
      totalSkor: 85,
      maxSkor: 100,
      kategori: 'Baik',
      kategoriColor: const Color(0xFF4AAF57),
      progressPersen: 75,
      aktivitas: const [
        LogbookActivityData(
          tanggal: '03',
          bulan: 'JUNI',
          hariNama: 'Selasa',
          judul:
              'Membuat Dokumentasi Teknis Sistem Aplikasi - Utama Programmer',
          deskripsi:
              'Pembuatan dokumen teknis untuk sistem yang sedang dikembangkan...',
        ),
        LogbookActivityData(
          tanggal: '05',
          bulan: 'JUNI',
          hariNama: 'Kamis',
          judul: 'Melakukan Code Review dan Refactoring - Utama Programmer',
          deskripsi: 'Mereview kode dan melakukan perbaikan struktur kode...',
        ),
      ],
    ),

    // Juli 2026 — belum ada skor (bulan berjalan)
    LogbookBulanData(
      labelBulan: 'Juli 2026',
      aktivitas: const [
        LogbookActivityData(
          tanggal: '03',
          bulan: 'JULI',
          hariNama: 'Kamis',
          judul:
              'Melakukan Pengujian Unit-unit Fungsi Sistem Aplikasi Yang Sudah Dibuat - Utama Programmer',
          deskripsi:
              'Aktivitas pengujian keamanan untuk widget yang telah selesai dikembangkan...',
        ),
        LogbookActivityData(
          tanggal: '04',
          bulan: 'JULI',
          hariNama: 'Jumat',
          judul:
              'Melakukan Pengujian Unit-unit Fungsi Sistem Aplikasi Yang Sudah Dibuat - Utama Programmer',
          deskripsi:
              'Aktivitas pengujian keamanan untuk widget yang telah sembuang ke1 komposisi...',
        ),
        LogbookActivityData(
          tanggal: '05',
          bulan: 'JULI',
          hariNama: 'Sabtu',
          judul: 'Melakukan Pekerjaan Tambahan Selain Jabdes Utama - Tambahan',
          deskripsi:
              'Activity beresih, TA revisi + geld makan anak computer programmerku...',
        ),
        LogbookActivityData(
          tanggal: '06',
          bulan: 'JULI',
          hariNama: 'Minggu',
          judul:
              'Membuat Algoritma Proses Fungsi-Fungsi Aplikasi - Utama Programmer',
          deskripsi:
              'Tambah internal server nama di hostname diisi softskill.id Informasi kosong...',
        ),
        LogbookActivityData(
          tanggal: '07',
          bulan: 'JULI',
          hariNama: 'Senin',
          judul:
              'Membuat Algoritma Proses Fungsi-Fungsi Aplikasi - Utama Programmer',
          deskripsi:
              'Tambah internal server nama di hostname diisi softskill.id Informasi kosong...',
        ),
        LogbookActivityData(
          tanggal: '08',
          bulan: 'JULI',
          hariNama: 'Selasa',
          judul:
              'Membuat Algoritma Proses Fungsi-Fungsi Aplikasi - Utama Programmer',
          deskripsi:
              'Tambah internal server nama di hostname diisi softskill.id Informasi kosong...',
        ),
        LogbookActivityData(
          tanggal: '09',
          bulan: 'JULI',
          hariNama: 'Rabu',
          judul:
              'Membuat Algoritma Proses Fungsi-Fungsi Aplikasi - Utama Programmer',
          deskripsi:
              'Tambah internal server nama di hostname diisi softskill.id Informasi kosong...',
        ),
      ],
    ),

    // Agustus 2026 — belum ada data
    const LogbookBulanData(labelBulan: 'Agustus 2026', aktivitas: []),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      body: Column(
        children: [
          // --- AppBar Biru ---
          LogbookAppBar(
            title: 'Logbook',
            onBack: () => Navigator.of(context).maybePop(),
          ),

          // --- Konten Utama (scrollable) ---
          Expanded(
            child: _LogbookBody(
              dataBulan: _dataBulan,
              bulanIndex: _bulanIndex,
              onBulanChanged: (index) => setState(() => _bulanIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// KOMPONEN: Body konten logbook (area putih melengkung)
// ============================================================
class _LogbookBody extends StatelessWidget {
  final List<LogbookBulanData> dataBulan;
  final int bulanIndex;
  final ValueChanged<int> onBulanChanged;

  const _LogbookBody({
    required this.dataBulan,
    required this.bulanIndex,
    required this.onBulanChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Card Gabungan: Profil (Statis) + Selector Bulan (Swipeable) + Statistik (Statis/Dinamis) ---
              _LogbookHeaderCard(
                dataBulan: dataBulan,
                bulanIndex: bulanIndex,
                onBulanChanged: onBulanChanged,
              ),

              const SizedBox(height: 24),

              // --- Header Section Aktivitas ---
              LogbookSectionHeader(
                jumlahAktivitas: dataBulan[bulanIndex].aktivitas.length,
                onTambah: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogbookFormPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // --- Daftar Aktivitas ---
              _DaftarAktivitas(
                daftarAktivitas: dataBulan[bulanIndex].aktivitas,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// KOMPONEN: Card Gabungan Profil, Selector Bulan, dan Statistik
// Container luar berwarna putih dan profil tetap statis.
// Hanya navigator bulan di tengah yang dapat digeser (swipe).
// ============================================================
class _LogbookHeaderCard extends StatefulWidget {
  final List<LogbookBulanData> dataBulan;
  final int bulanIndex;
  final ValueChanged<int> onBulanChanged;

  const _LogbookHeaderCard({
    required this.dataBulan,
    required this.bulanIndex,
    required this.onBulanChanged,
  });

  @override
  State<_LogbookHeaderCard> createState() => _LogbookHeaderCardState();
}

class _LogbookHeaderCardState extends State<_LogbookHeaderCard> {
  bool _slideLeft = true;

  @override
  void didUpdateWidget(covariant _LogbookHeaderCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.bulanIndex != oldWidget.bulanIndex) {
      _slideLeft = widget.bulanIndex < oldWidget.bulanIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bulanAktif = widget.dataBulan[widget.bulanIndex];

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (details) {
        final dx = details.velocity.pixelsPerSecond.dx;
        if (dx < -300) {
          if (widget.bulanIndex < widget.dataBulan.length - 1) {
            widget.onBulanChanged(widget.bulanIndex + 1);
          }
        } else if (dx > 300) {
          if (widget.bulanIndex > 0) {
            widget.onBulanChanged(widget.bulanIndex - 1);
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
            BoxShadow(
              color: Color(0x0F7281DF),
              blurRadius: 10.20,
              offset: Offset(0, 4.11),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Profil Pegawai (Statis) ---
            const LogbookProfileCard(
              namaLengkap: 'Ahmad Luthfi Abdurrosyid, S.Kom.',
              unitKerja: 'RD - Sub Direktorat Pengembangan',
              jabatan: 'Programmer',
              subUnit: 'Aplikasi dan Basis',
              photoUrl: 'https://placehold.co/64x64',
            ),

            // --- Row Selector Bulan & Tahun ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Panah Kiri (Statis)
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded, size: 24),
                  color: widget.bulanIndex > 0
                      ? const Color(0xFF293241)
                      : const Color(0xFFCCCED1),
                  onPressed: widget.bulanIndex > 0
                      ? () => widget.onBulanChanged(widget.bulanIndex - 1)
                      : null,
                ),

                // Teks Bulan & Tahun (AnimatedSwitcher)
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        transitionBuilder: (child, animation) {
                          final offset = _slideLeft
                              ? const Offset(-0.4, 0)
                              : const Offset(0.4, 0);
                          return SlideTransition(
                            position: Tween<Offset>(begin: offset, end: Offset.zero)
                                .animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutCubic,
                                  ),
                                ),
                            child: FadeTransition(opacity: animation, child: child),
                          );
                        },
                        child: Text(
                          widget.dataBulan[widget.bulanIndex].labelBulan,
                          key: ValueKey(widget.dataBulan[widget.bulanIndex].labelBulan),
                          style: const TextStyle(
                            color: Color(0xFF293241),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                            letterSpacing: -0.18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Panah Kanan (Statis)
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded, size: 24),
                  color: widget.bulanIndex < widget.dataBulan.length - 1
                      ? const Color(0xFF293241)
                      : const Color(0xFFCCCED1),
                  onPressed: widget.bulanIndex < widget.dataBulan.length - 1
                      ? () => widget.onBulanChanged(widget.bulanIndex + 1)
                      : null,
                ),
              ],
            ),

            // --- Stats (Statis/Dinamis berdasarkan bulan aktif) ---
            if (bulanAktif.hasSkor) ...[
              const SizedBox(height: 12),
              LogbookMonthStats(
                totalSkor: bulanAktif.totalSkor!,
                maxSkor: bulanAktif.maxSkor,
                kategori: bulanAktif.kategori!,
                kategoriColor: bulanAktif.kategoriColor!,
                progressPersen: bulanAktif.progressPersen!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================
// KOMPONEN: Daftar item aktivitas
// ============================================================
class _DaftarAktivitas extends StatelessWidget {
  final List<LogbookActivityData> daftarAktivitas;

  const _DaftarAktivitas({required this.daftarAktivitas});

  @override
  Widget build(BuildContext context) {
    if (daftarAktivitas.isEmpty) {
      return _EmptyState();
    }

    return Column(
      children: List.generate(daftarAktivitas.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: LogbookActivityItem(
            data: daftarAktivitas[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LogbookDetailPage(activity: daftarAktivitas[index]),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

// ============================================================
// KOMPONEN: Empty state jika belum ada aktivitas
// ============================================================
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 56, color: Color(0xFFCCCED1)),
          SizedBox(height: 12),
          Text(
            'Belum ada aktivitas',
            style: TextStyle(
              color: Color(0xFFAEB1B7),
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tap tombol Tambah untuk menambah aktivitas baru',
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
