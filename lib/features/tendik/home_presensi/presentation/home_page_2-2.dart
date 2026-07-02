import 'package:flutter/material.dart';
import 'widgets/presensi_state.dart';
import 'widgets/tombol_pulang.dart';
import 'widgets/profile_header.dart';
import 'widgets/layanan_adisty_section_v2.dart';
import 'widgets/presensi_card_v2.dart';
import 'widgets/statistik_presensi_v2.dart';

// ============================================================
// HALAMAN UTAMA - HomePage2
// ============================================================
class HomePage2_2 extends StatelessWidget {
  final PresensiState state;

  const HomePage2_2({super.key, this.state = PresensiState.belumPresensi});

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
              _InformationSection(state: state),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// KOMPONEN: SECTION INFORMASI UTAMA
// Wrapper untuk semua section: presensi & layanan
// ============================================================
class _InformationSection extends StatelessWidget {
  final PresensiState state;

  const _InformationSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 18,
            children: [
              // --- Section Presensi ---
              Container(
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
                          // Card Presensi (biru)
                          PresensiCardV2(state: state),

                          // Row Statistik (jumlah presensi + status)
                          StatistikPresensiV2(),

                          // Tombol Presensi + hint
                          _TombolPresensiWrapper(state: state),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- Section Layanan Adisty ---
              const LayananAdistySectionV2(),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// KOMPONEN: TOMBOL PRESENSI + FOOTER HINT (state-aware)
// ============================================================
class _TombolPresensiWrapper extends StatelessWidget {
  final PresensiState state;

  const _TombolPresensiWrapper({required this.state});

  @override
  Widget build(BuildContext context) {
    String buttonText;
    List<Color> buttonGradient;
    Color footerBg;
    String footerText;
    Color footerTextColor;

    switch (state) {
      case PresensiState.belumPresensi:
        buttonText = 'Masuk';
        buttonGradient = const [Color(0xFF4AAF57), Color(0xFF49C95A)];
        footerBg = const Color(0xFFF6F7F7);
        footerText = 'Klik tombol diatas saat Anda ingin Masuk';
        footerTextColor = const Color(0xFF5F6570);
        break;
      case PresensiState.shift1Selesai:
        buttonText = 'Lanjut Shift';
        buttonGradient = const [Color(0xFF0067AD), Color(0xFF4497D0)];
        footerBg = const Color(0xFFE8F1F9);
        footerText =
            'Shift 1 telah selesai. Silahkan lanjutkan ke shift berikutnya.';
        footerTextColor = const Color(0xFF2B86C3);
        break;
      case PresensiState.pulang:
        buttonText = 'Pulang';
        buttonGradient = const [Color(0xFFFFAC2F), Color(0xFFFFC268)];
        footerBg = const Color(0xFFF6F7F7);
        footerText = 'Klik tombol diatas saat Anda ingin pulang';
        footerTextColor = const Color(0xFF5F6570);
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [TombolPresensi(text: buttonText, gradient: buttonGradient)],
    );
  }
}
