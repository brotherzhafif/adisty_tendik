import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';
import '../bloc/presensi_hari_ini_bloc.dart';
import '../bloc/presensi_hari_ini_event.dart';
import '../bloc/presensi_hari_ini_state.dart';
import '../data/providers/presensi_hari_ini_provider.dart';
import '../data/repositories/presensi_hari_ini_repository.dart';
import '../domain/usecases/get_presensi_hari_ini_usecase.dart';
import 'widgets/info_presensi_card.dart';
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
      create: (context) => PresensiHariIniBloc(
        getPresensiHariIniUseCase: useCase,
      )..add(const FetchPresensiHariIniEvent()),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Presensi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF6F7F9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
            topRight: Radius.circular(34),
          ),
        ),
        child: BlocBuilder<PresensiHariIniBloc, PresensiHariIniState>(
          builder: (context, state) {
            if (state is PresensiHariIniLoading ||
                state is PresensiHariIniInitial) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF2B86C3),
                ),
              );
            }

            if (state is PresensiHariIniError) {
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
                          context.read<PresensiHariIniBloc>().add(
                                const FetchPresensiHariIniEvent(),
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
                      )
                    ],
                  ),
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
                      horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoPresensiCard(detail: state.detail),
                      const SizedBox(height: 24),
                      BatasKoreksiInfo(
                          maxHari: state.detail.maxHariKoreksi),
                      const SizedBox(height: 24),
                      AjukanKoreksiCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FormKoreksiPage(),
                            ),
                          );
                        },
                        onRiwayatTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RiwayatKoreksiPage(),
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
    );
  }
}
