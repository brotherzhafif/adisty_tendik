import 'package:flutter/material.dart';
import 'widgets/presensi_state.dart';
import 'widgets/tombol_presensi_wrapper.dart';
import 'widgets/profile_header.dart';
import 'widgets/layanan_adisty_section_v1.dart';
import 'widgets/presensi_card_v1.dart';
import 'widgets/statistik_presensi_v1.dart';

// ============================================================
// HALAMAN UTAMA - HomePage1
// ============================================================
class HomePage1 extends StatelessWidget {
  final PresensiState state;
  final VoidCallback? onAdvanceState;
  final VoidCallback? onResetState;

  const HomePage1({
    super.key,
    this.state = PresensiState.belumPresensi,
    this.onAdvanceState,
    this.onResetState,
  });

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
                state: state,
                onAdvanceState: onAdvanceState,
                onResetState: onResetState,
              ),
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
                          // Card Presensi (biru)
                          PresensiCardV1(state: state),

                          // Row Statistik (jumlah presensi + status)
                          StatistikPresensiV1(),

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
              LayananAdistySectionV1(),
            ],
          ),
        ),
      ],
    );
  }
}
