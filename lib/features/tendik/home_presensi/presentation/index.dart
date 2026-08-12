import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/home_presensi_bloc.dart';
import '../bloc/home_presensi_event.dart';
import '../bloc/home_presensi_state.dart';
import '../data/providers/home_presensi_provider.dart';
import '../data/repositories/home_presensi_repository.dart';
import '../domain/usecases/get_home_presensi_usecase.dart';
import 'widgets/presensi_state.dart';
import 'widgets/tombol_presensi_wrapper.dart';
import 'widgets/profile_header.dart';
import 'widgets/layanan_adisty_section.dart';
import 'widgets/presensi_card.dart';
import 'widgets/statistik_presensi.dart';
import '../../presensi_hari_ini/presentation/index.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

// ============================================================
// HALAMAN UTAMA - HomePage (CLEAN ARCHITECTURE WRAPPER)
// ============================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = const HomePresensiProvider();
    final repository = HomePresensiRepository(provider: provider);
    final useCase = GetHomePresensiUseCase(repository: repository);

    return BlocProvider(
      create: (context) =>
          HomePresensiBloc(getHomePresensiUseCase: useCase)
            ..add(const FetchHomePresensiEvent()),
      child: const HomePageView(),
    );
  }
}

// ============================================================
// VIEW COMPONENT - HOME PAGE VIEW
// ============================================================
class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: BlocBuilder<HomePresensiBloc, HomePresensiState>(
          builder: (context, state) {
            if (state is HomePresensiLoading || state is HomePresensiInitial) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF2B86C3)),
              );
            }

            if (state is HomePresensiError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bodyMd.copyWith(
                          color: Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<HomePresensiBloc>().add(
                            const FetchHomePresensiEvent(),
                          );
                        },
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        label: Text(
                          'Coba Lagi',
                          style: AppTextStyle.bodyMd.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B86C3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is HomePresensiLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomePresensiBloc>().add(
                    const RefreshHomePresensiEvent(),
                  );
                },
                color: const Color(0xFF2B86C3),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // --- Header Profil (Dinamis dari BLoC State) ---
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: ProfileHeader(profile: state.profile),
                      ),

                      // --- Konten Informasi (Presensi + Layanan) ---
                      _InformationSection(
                        state: state.presensiState,
                        onAdvanceState: () {
                          context.read<HomePresensiBloc>().add(
                            const AdvancePresensiStateEvent(),
                          );
                        },
                        onResetState: () {
                          context.read<HomePresensiBloc>().add(
                            const ResetPresensiStateEvent(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
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
      height: 80,
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
                width: 30,
                height: 30,
              ),
              const SizedBox(height: 4),
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
                  width: 30,
                  height: 30,
                ),
                const SizedBox(height: 4),
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
                width: 30,
                height: 30,
              ),
              const SizedBox(height: 4),
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
