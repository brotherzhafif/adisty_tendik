import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/profile_header.dart';
import 'widgets/layanan_adisty_section_v2.dart';
import 'widgets/presensi_card_v1.dart';
import 'widgets/presensi_card_v2.dart';
import 'widgets/statistik_presensi_v1.dart';
import 'widgets/statistik_presensi_v2.dart';
import 'widgets/tombol_pulang.dart';

// ============================================================
// HALAMAN UTAMA - HomePage1
// ============================================================
class HomePage1_2 extends StatelessWidget {
  const HomePage1_2({super.key});

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
              _InformationSection(),
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
                          PresensiCardV1(),

                          // Row Statistik (jumlah presensi + status)
                          StatistikPresensiV1(),

                          // Tombol Pulang + hint
                          TombolPulang(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- Section Layanan Adisty ---
              LayananAdistySectionV2(),
            ],
          ),
        ),
      ],
    );
  }
}
