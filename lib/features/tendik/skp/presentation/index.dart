import 'package:flutter/material.dart';
import 'widgets/skp_app_bar.dart';
import 'widgets/skp_profile_card.dart';
import 'widgets/skp_category_card.dart';

// ============================================================
// HALAMAN: SKP Pegawai Dashboard
// Menampilkan profil pegawai, selector tahun evaluasi (interactive),
// dan 3 kategori penilaian (AIK, Tugas Umum, Penunjang) secara responsif.
// ============================================================
class SkpDashboardSkp extends StatefulWidget {
  const SkpDashboardSkp({super.key});

  @override
  State<SkpDashboardSkp> createState() => _SkpDashboardSkpState();
}

class _SkpDashboardSkpState extends State<SkpDashboardSkp> {
  int _activeYearIndex = 1; // Default ke 2026 (index 1)
  late final PageController _pageController;

  static const List<String> _years = ['2025', '2026', '2027'];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _activeYearIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _pindahTahun(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  // Data penilaian per tahun
  static final Map<String, _SkpYearData> _skpDataMap = {
    '2025': const _SkpYearData(
      aikScore: 84.50,
      tugasUmumScore: 85.00,
      penunjangScore: 88.00,
      aikIndicators: [
        SkpIndicatorData(name: 'Refreshing Al-Islam dan Kemuhammadiyahan', score: 85.00),
        SkpIndicatorData(name: 'Pengajian Tingkat Universitas', score: 80.00),
        SkpIndicatorData(name: 'Pengajian dan Tadarus di Unit Kerja', score: 90.00),
        SkpIndicatorData(name: 'Hafalan Surat Juz 30', score: 80.00),
        SkpIndicatorData(name: 'Keterlibatan Persyarikatan', score: 87.00),
        SkpIndicatorData(name: 'Partisipasi di Amal Usaha Muhammadiyah', score: 85.00),
      ],
      tugasUmumIndicators: [
        SkpIndicatorData(name: 'Tugas Tambahan Pejabat Struktural', score: 85.00),
        SkpIndicatorData(name: 'Penilaian individu sesuai deskripsi pekerjaan', score: 85.00),
        SkpIndicatorData(name: 'Penilaian pejabat penilai kinerja', score: 85.00),
        SkpIndicatorData(name: 'Kehadiran dalam sebulan', score: 85.00),
      ],
      penunjangIndicators: [
        SkpIndicatorData(name: 'Sertifikasi kompetensi', score: 88.00),
        SkpIndicatorData(name: 'Pelatihan', score: 88.00),
        SkpIndicatorData(name: 'Prestasi', score: 88.00),
        SkpIndicatorData(name: 'Keterlibatan Kepanitiaan', score: 88.00),
        SkpIndicatorData(name: 'Penghargaan Masa Kerja', score: 88.00),
      ],
    ),
    '2026': const _SkpYearData(
      aikScore: 88.80,
      tugasUmumScore: 90.00,
      penunjangScore: 90.00,
      aikIndicators: [
        SkpIndicatorData(name: 'Refreshing Al-Islam dan Kemuhammadiyahan', score: 90.00),
        SkpIndicatorData(name: 'Pengajian Tingkat Universitas', score: 80.00),
        SkpIndicatorData(name: 'Pengajian dan Tadarus di Unit Kerja', score: 95.00),
        SkpIndicatorData(name: 'Hafalan Surat Juz 30', score: 85.00),
        SkpIndicatorData(name: 'Keterlibatan Persyarikatan', score: 90.00),
        SkpIndicatorData(name: 'Partisipasi di Amal Usaha Muhammadiyah', score: 90.00),
      ],
      tugasUmumIndicators: [
        SkpIndicatorData(name: 'Tugas Tambahan Pejabat Struktural', score: 90.00),
        SkpIndicatorData(name: 'Penilaian individu sesuai deskripsi pekerjaan', score: 90.00),
        SkpIndicatorData(name: 'Penilaian pejabat penilai kinerja', score: 90.00),
        SkpIndicatorData(name: 'Kehadiran dalam sebulan', score: 90.00),
      ],
      penunjangIndicators: [
        SkpIndicatorData(name: 'Sertifikasi kompetensi', score: 90.00),
        SkpIndicatorData(name: 'Pelatihan', score: 90.00),
        SkpIndicatorData(name: 'Prestasi', score: 90.00),
        SkpIndicatorData(name: 'Keterlibatan Kepanitiaan', score: 90.00),
        SkpIndicatorData(name: 'Penghargaan Masa Kerja', score: 90.00),
      ],
    ),
    '2027': const _SkpYearData(
      aikScore: 92.50,
      tugasUmumScore: 95.00,
      penunjangScore: 92.00,
      aikIndicators: [
        SkpIndicatorData(name: 'Refreshing Al-Islam dan Kemuhammadiyahan', score: 95.00),
        SkpIndicatorData(name: 'Pengajian Tingkat Universitas', score: 90.00),
        SkpIndicatorData(name: 'Pengajian dan Tadarus di Unit Kerja', score: 98.00),
        SkpIndicatorData(name: 'Hafalan Surat Juz 30', score: 90.00),
        SkpIndicatorData(name: 'Keterlibatan Persyarikatan', score: 92.00),
        SkpIndicatorData(name: 'Partisipasi di Amal Usaha Muhammadiyah', score: 90.00),
      ],
      tugasUmumIndicators: [
        SkpIndicatorData(name: 'Tugas Tambahan Pejabat Struktural', score: 95.00),
        SkpIndicatorData(name: 'Penilaian individu sesuai deskripsi pekerjaan', score: 95.00),
        SkpIndicatorData(name: 'Penilaian pejabat penilai kinerja', score: 95.00),
        SkpIndicatorData(name: 'Kehadiran dalam sebulan', score: 95.00),
      ],
      penunjangIndicators: [
        SkpIndicatorData(name: 'Sertifikasi kompetensi', score: 92.00),
        SkpIndicatorData(name: 'Pelatihan', score: 92.00),
        SkpIndicatorData(name: 'Prestasi', score: 92.00),
        SkpIndicatorData(name: 'Keterlibatan Kepanitiaan', score: 92.00),
        SkpIndicatorData(name: 'Penghargaan Masa Kerja', score: 92.00),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    final activeYear = _years[_activeYearIndex];
    final yearData = _skpDataMap[activeYear]!;

    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      body: Column(
        children: [
          // --- Custom Blue App Bar ---
          SkpAppBar(
            title: 'SKP Pegawai',
            onBack: () => Navigator.of(context).maybePop(),
          ),

          // --- Scrollable Body Area ---
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
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                  child: Column(
                    children: [
                      // --- Profile Card ---
                      SkpProfileCard(
                        name: 'Ahmad Lufhfi Abdurrosyid, S.kom.',
                        department: 'BSI - Staff urusan pengembangan',
                        role: 'Programmer',
                        avatarUrl: 'https://placehold.co/64x64',
                        years: _years,
                        activeYearIndex: _activeYearIndex,
                        onYearChanged: (index) {
                          setState(() {
                            _activeYearIndex = index;
                          });
                        },
                        pageController: _pageController,
                        onPindahTahun: _pindahTahun,
                      ),
                      const SizedBox(height: 14),

                      // --- Category 1: Pengamalan AIK ---
                      SkpCategoryCard(
                        title: 'Pengamalan AIK',
                        weight: ' (35%)',
                        subTitle: 'Pengamalan Al Islam dan Kemuhammadiyahan',
                        indicators: yearData.aikIndicators,
                        totalScore: yearData.aikScore,
                        summaryTitle: 'SKOR Pengalaman AIK',
                        themeColor: const Color(0xFF2B86C3),
                        bannerBgColor: const Color(0x192B86C3),
                        summaryBorderColor: const Color(0xFF0067AD),
                      ),
                      const SizedBox(height: 14),

                      // --- Category 2: Tugas Umum ---
                      SkpCategoryCard(
                        title: 'Tugas Umum',
                        weight: ' (40%)',
                        subTitle: 'Melaksanakan Tugas Utama Tenaga Kependidikan',
                        indicators: yearData.tugasUmumIndicators,
                        totalScore: yearData.tugasUmumScore,
                        summaryTitle: 'SKOR Pengalaman AIK', // Typos/design labels preserved exactly
                        themeColor: const Color(0xFF4AAF57),
                        bannerBgColor: const Color(0x194AAF57),
                        summaryBorderColor: const Color(0xF54AAF57),
                      ),
                      const SizedBox(height: 14),

                      // --- Category 3: Penunjang ---
                      SkpCategoryCard(
                        title: 'Penunjang',
                        weight: ' (25%)',
                        subTitle: 'Melaksanakan Aktivitas Penunjang Tenaga Kependidikan',
                        indicators: yearData.penunjangIndicators,
                        totalScore: yearData.penunjangScore,
                        summaryTitle: 'SKOR Pengalaman AIK', // Typos/design labels preserved exactly
                        themeColor: const Color(0xFFFFAC2F),
                        bannerBgColor: const Color(0x19FFAC2F),
                        summaryBorderColor: const Color(0x19FFAC2F),
                      ),
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
}

// ============================================================
// MODEL INTERNAL: Penilaian per tahun
// ============================================================
class _SkpYearData {
  final double aikScore;
  final double tugasUmumScore;
  final double penunjangScore;
  final List<SkpIndicatorData> aikIndicators;
  final List<SkpIndicatorData> tugasUmumIndicators;
  final List<SkpIndicatorData> penunjangIndicators;

  const _SkpYearData({
    required this.aikScore,
    required this.tugasUmumScore,
    required this.penunjangScore,
    required this.aikIndicators,
    required this.tugasUmumIndicators,
    required this.penunjangIndicators,
  });
}