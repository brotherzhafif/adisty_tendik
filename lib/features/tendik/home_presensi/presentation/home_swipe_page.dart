import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_page_1.dart' as page1;
import 'home_page_1-2.dart' as page1_2;
import 'home_page_2.dart' as page2;
import 'home_page_2-2.dart' as page2_2;

// ============================================================
// HALAMAN SWIPE - HomeSwipePage
// Wrapper utama yang menyatukan semua homepage dalam
// PageView swipeable (kiri/kanan, looping tak terbatas)
// dengan Navbar bawah.
// ============================================================
class HomeSwipePage extends StatefulWidget {
  const HomeSwipePage({super.key});

  @override
  State<HomeSwipePage> createState() => _HomeSwipePageState();
}

class _HomeSwipePageState extends State<HomeSwipePage> {
  // Jumlah halaman asli
  static const int _pageCount = 4;

  // Offset besar agar bisa scroll dua arah dari tengah
  static const int _loopOffset = 1000;

  // Controller dimulai dari tengah agar swipe kiri/kanan sama-sama bisa
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _loopOffset);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Halaman aktif (0-indexed, sudah di-mod ke jumlah halaman asli)
  int get _currentPage {
    if (!_pageController.hasClients) return 0;
    return (_pageController.page?.round() ?? _loopOffset) % _pageCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      body: PageView.builder(
        controller: _pageController,
        physics: const PageScrollPhysics(),
        onPageChanged: (_) => setState(() {}),
        itemBuilder: (context, index) {
          final page = index % _pageCount;
          switch (page) {
            case 0:
              return const page1.HomePage1();
            case 1:
              return const page1_2.HomePage1_2();
            case 2:
              return const page2.HomePage2();
            case 3:
              return const page2_2.HomePage2_2();
            default:
              return const page1.HomePage1();
          }
        },
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _pageController,
        builder: (context, _) {
          return _Navbar(currentPage: _currentPage);
        },
      ),
    );
  }
}

// ============================================================
// KOMPONEN: NAVBAR BAWAH
// Menampilkan 3 item navigasi: Beranda, Presensi, Profil
// Icon diambil dari assets/icons/ menggunakan flutter_svg.
// currentPage digunakan untuk menentukan tab aktif (Beranda).
// ============================================================
class _Navbar extends StatelessWidget {
  final int currentPage;

  const _Navbar({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    // Tab Beranda aktif jika di halaman mana pun (semua adalah Beranda)
    // Bisa dikembangkan nanti ketika ada halaman Presensi & Profil terpisah
    const bool isBerandaActive = true;

    return Container(
      width: double.infinity,
      height: 100,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 0,
            offset: Offset(0.50, 0),
            spreadRadius: 0.50,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Tab Beranda (aktif) ---
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/home-icon.svg',
                width: 40,
                height: 40,
              ),
              const Text(
                'Beranda',
                style: TextStyle(
                  color: Color(0xFF016EB8),
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  height: 1.49,
                ),
              ),
            ],
          ),

          // --- Tab Presensi (tidak aktif) ---
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/presensi-icon.svg',
                width: 40,
                height: 40,
              ),
              const Text(
                'Presensi',
                style: TextStyle(
                  color: Color(0xFF5F6570),
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  height: 1.49,
                ),
              ),
            ],
          ),

          // --- Tab Profil (tidak aktif) ---
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/profile-icon.svg',
                width: 40,
                height: 40,
              ),
              const Text(
                'Profil',
                style: TextStyle(
                  color: Color(0xFF5F6570),
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  height: 1.49,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
