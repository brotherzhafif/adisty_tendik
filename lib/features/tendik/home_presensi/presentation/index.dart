import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/presensi_state.dart';
import 'widgets/tombol_presensi_wrapper.dart';
import 'widgets/profile_header.dart';
import 'widgets/layanan_adisty_section.dart';
import 'widgets/presensi_card.dart';
import 'widgets/statistik_presensi.dart';
import '../../presensi_hari_ini/presentation/index.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

// ============================================================
// HALAMAN UTAMA - HomePage
// ============================================================
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PresensiState _currentPresensiState = PresensiState.belumPresensi;

  // Callback untuk flow tombol presensi
  void _advanceState() {
    setState(() {
      switch (_currentPresensiState) {
        case PresensiState.belumPresensi:
          _currentPresensiState = PresensiState.shift1Selesai;
          break;
        case PresensiState.shift1Selesai:
          _currentPresensiState = PresensiState.pulang;
          break;
        case PresensiState.pulang:
          break;
      }
    });
  }

  // Setelah dialog konfirmasi pulang berhasil
  void _resetState() {
    setState(() {
      _currentPresensiState = PresensiState.belumPresensi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- Header Profil ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: ProfileHeader(),
              ),

              // --- Konten Informasi (Presensi + Layanan) ---
              _InformationSection(
                state: _currentPresensiState,
                onAdvanceState: _advanceState,
                onResetState: _resetState,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _Navbar(),
    );
  }
}

// ============================================================
// KOMPONEN: SECTION INFORMASI UTAMA
// Wrapper untuk semua section: presensi & layanan
// ============================================================
class _InformationSection extends StatelessWidget {
  final PresensiState state;
  final VoidCallback? onAdvanceState;
  final VoidCallback? onResetState;

  const _InformationSection({
    required this.state,
    this.onAdvanceState,
    this.onResetState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 18,
            children: [
              // --- Section Presensi ---
              SizedBox(
                width: 378,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 11,
                        children: [
                          // Card Presensi (biru) — berubah sesuai state
                          PresensiCard(state: state),

                          // Row Statistik — hanya muncul setelah masuk
                          if (state != PresensiState.belumPresensi)
                            const StatistikPresensi(),

                          // Tombol Presensi + hint
                          TombolPresensiWrapper(
                            state: state,
                            onAdvanceState: onAdvanceState,
                            onResetState: onResetState,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- Section Layanan Adisty ---
              const LayananAdistySection(),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// KOMPONEN: NAVBAR BAWAH
// Menampilkan 3 item navigasi: Beranda, Presensi, Profil
// Icon diambil dari assets/icons/(home_page)_ menggunakan flutter_svg.
// ============================================================
class _Navbar extends StatelessWidget {
  const _Navbar();

  @override
  Widget build(BuildContext context) {
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
                'assets/icons/(home_page)_home-icon.svg',
                width: 40,
                height: 40,
              ),
              Text(
                'Beranda',
                style: AppTextStyle.bodySm.copyWith(
                  color: const Color(0xFF016EB8),
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          // --- Tab Presensi (tidak aktif) ---
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LandingPresensiHariIni(),
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/(home_page)_presensi-icon.svg',
                  width: 40,
                  height: 40,
                ),
                Text(
                  'Presensi',
                  style: AppTextStyle.bodySm.copyWith(
                    color: const Color(0xFF5F6570),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // --- Tab Profil (tidak aktif) ---
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/(home_page)_profile-icon.svg',
                width: 40,
                height: 40,
              ),
              Text(
                'Profil',
                style: AppTextStyle.bodySm.copyWith(
                  color: const Color(0xFF5F6570),
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
