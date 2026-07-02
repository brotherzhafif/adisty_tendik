import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/profile_header.dart';
import 'widgets/layanan_adisty_section.dart';
import 'widgets/presensi_card_v1.dart';
import 'widgets/presensi_card_v2.dart';
import 'widgets/statistik_presensi_v1.dart';
import 'widgets/statistik_presensi_v2.dart';
import 'widgets/tombol_pulang.dart';

// ============================================================
// HALAMAN UTAMA - HomePage2
// ============================================================
class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

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
                          PresensiCardV2(),

                          // Row Statistik (jumlah presensi + status)
                          StatistikPresensiV2(),

                          // Tombol Pulang + hint
                          TombolPulang(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- Section Layanan Adisty ---
              LayananAdistySection(),
            ],
          ),
        ),
      ],
    );
  }
}


// ============================================================
// KOMPONEN: KOTAK PRESENSI (Masuk / Pulang)
// Digunakan ulang untuk kotak masuk dan kotak pulang
// ============================================================

// ============================================================
// KOMPONEN: BARIS LOKASI & TRANSPORTASI
// Menampilkan lokasi kampus dan info transportasi harian
// yang digabung dalam satu area di dalam card biru
// ============================================================


// ============================================================
// KOMPONEN: BADGE STATISTIK (reusable)
// Digunakan untuk tiap badge statistik di baris statistik
// ============================================================



// ============================================================
// KOMPONEN: CARD LAYANAN (reusable)
// Digunakan untuk tiap kartu layanan: Tunjangan, Cuti, dll
// ============================================================
