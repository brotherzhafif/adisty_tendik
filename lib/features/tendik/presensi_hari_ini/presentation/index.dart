import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adisty_tendik_module/core/error/presentation/index.dart';
import '../bloc/presensi_hari_ini_bloc.dart';
import '../bloc/presensi_hari_ini_event.dart';
import '../bloc/presensi_hari_ini_state.dart';
import '../data/providers/presensi_hari_ini_provider.dart';
import '../data/repositories/presensi_hari_ini_repository.dart';
import '../domain/usecases/get_presensi_hari_ini_usecase.dart';
import 'widgets/info_presensi_card.dart';
import 'widgets/lokasi_presensi_card.dart';
import 'widgets/batas_koreksi_info.dart';
import 'widgets/ajukan_koreksi_card.dart';
import 'form.dart';
import 'list.dart';

// ============================================================
// HALAMAN UTAMA: DETAIL PRESENSI HARI INI (CLEAN ARCHITECTURE WRAPPER)
// ============================================================
class LandingPresensiHariIni extends StatelessWidget {
  const LandingPresensiHariIni({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = const PresensiHariIniProvider();
    final repository = PresensiHariIniRepository(provider: provider);
    final useCase = GetPresensiHariIniUseCase(repository: repository);

    return BlocProvider(
      create: (context) =>
          PresensiHariIniBloc(getPresensiHariIniUseCase: useCase)
            ..add(const FetchPresensiHariIniEvent()),
      child: const LandingPresensiHariIniView(),
    );
  }
}

// ============================================================
// VIEW COMPONENT: DETAIL PRESENSI HARI INI VIEW
// ============================================================
class LandingPresensiHariIniView extends StatelessWidget {
  const LandingPresensiHariIniView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFF2B86C3),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Detail Presensi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF6F7F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
                child: BlocListener<PresensiHariIniBloc, PresensiHariIniState>(
                  listener: (context, state) {
                    if (state is PresensiHariIniError) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AppErrorScreen.withMessage(
                            errorMessage: state.message,
                            onRetry: () {
                              Navigator.pop(context);
                              context.read<PresensiHariIniBloc>().add(
                                const FetchPresensiHariIniEvent(),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<PresensiHariIniBloc, PresensiHariIniState>(
                    builder: (context, state) {
                      if (state is PresensiHariIniLoading ||
                          state is PresensiHariIniInitial ||
                          state is PresensiHariIniError) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF2B86C3),
                          ),
                        );
                      }

                      if (state is PresensiHariIniLoaded) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<PresensiHariIniBloc>().add(
                            const RefreshPresensiHariIniEvent(),
                          );
                        },
                        color: const Color(0xFF2B86C3),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 32,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  state.detail.date.isNotEmpty
                                      ? state.detail.date
                                      : 'Jumat, 13 Oktober 2023',
                                  style: const TextStyle(
                                    color: Color(0xFF8B9098),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 1.50,
                                    letterSpacing: -0.18,
                                  ),
                                ),
                              ),
                              InfoPresensiCard(detail: state.detail),
                              const SizedBox(height: 24),
                              LokasiPresensiCard(
                                namaLokasi: state.detail.location.isNotEmpty
                                    ? state.detail.location
                                    : 'Kampus 4 - Universitas Ahmad Dahlan',
                              ),
                              const SizedBox(height: 24),
                              BatasKoreksiInfo(
                                maxHari: state.detail.maxHariKoreksi,
                              ),
                              const SizedBox(height: 24),
                              AjukanKoreksiCard(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FormKoreksiPage(),
                                    ),
                                  );
                                },
                                onRiwayatTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RiwayatKoreksiPage(),
                                    ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
