import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';
import '../bloc/skp_bloc.dart';
import '../bloc/skp_event.dart';
import '../bloc/skp_state.dart';
import '../data/providers/skp_provider.dart';
import '../data/repositories/skp_repository.dart';
import '../domain/usecases/get_skp_usecase.dart';
import 'widgets/skp_app_bar.dart';
import 'widgets/skp_profile_card.dart';
import 'widgets/skp_category_card.dart';

// ============================================================
// HALAMAN: SKP Pegawai Dashboard (CLEAN ARCHITECTURE + BLOC WRAPPER)
// ============================================================
class SkpDashboardSkp extends StatelessWidget {
  const SkpDashboardSkp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = const SkpProvider();
    final repository = SkpRepository(provider: provider);
    final useCase = GetSkpUseCase(repository: repository);

    return BlocProvider(
      create: (context) =>
          SkpBloc(getSkpUseCase: useCase)..add(const FetchSkpEvent()),
      child: const SkpDashboardSkpView(),
    );
  }
}

// ============================================================
// VIEW COMPONENT: SKP DASHBOARD SKP VIEW
// Menampilkan profil pegawai, selector tahun evaluasi (interaktif),
// dan 3 kategori penilaian (AIK, Tugas Umum, Penunjang) secara responsif.
// ============================================================
class SkpDashboardSkpView extends StatelessWidget {
  const SkpDashboardSkpView({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: BlocBuilder<SkpBloc, SkpState>(
                  builder: (context, state) {
                    if (state is SkpLoading || state is SkpInitial) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2B86C3),
                        ),
                      );
                    }

                    if (state is SkpError) {
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
                                  context.read<SkpBloc>().add(
                                    const FetchSkpEvent(),
                                  );
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
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

                    if (state is SkpLoaded) {
                      final profile = state.profile;
                      final yearData = state.currentYearData;

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<SkpBloc>().add(const RefreshSkpEvent());
                        },
                        color: const Color(0xFF2B86C3),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(21, 21, 21, 24),
                          child: Column(
                            children: [
                              // --- Profile Card ---
                              SkpProfileCard(
                                name: profile.name,
                                department: profile.department,
                                role: profile.role,
                                avatarUrl: profile.avatarUrl,
                                years: state.years,
                                activeYearIndex: state.activeYearIndex,
                                onYearChanged: (index) {
                                  context.read<SkpBloc>().add(
                                    ChangeYearSkpEvent(index),
                                  );
                                },
                                hasData: yearData.hasData,
                                score: yearData.totalSkpScore,
                                jumlahKategori: yearData.jumlahKategori,
                                dinilaiOlehNama: yearData.dinilaiOlehNama,
                                dinilaiOlehPosisi: yearData.dinilaiOlehPosisi,
                              ),
                              const SizedBox(height: 14),

                              // --- Dynamic Category Cards ---
                              ...yearData.categories.asMap().entries.map((
                                entry,
                              ) {
                                final index = entry.key;
                                final category = entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: SkpCategoryCard(
                                    title: category.title,
                                    weight: category.weight,
                                    subTitle: category.subTitle,
                                    indicators: category.indicators,
                                    totalScore: category.score,
                                    summaryTitle: category.summaryTitle,
                                    categoryIndex: index,
                                  ),
                                );
                              }),

                              const SizedBox(height: 16),
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
        ],
      ),
    );
  }
}
