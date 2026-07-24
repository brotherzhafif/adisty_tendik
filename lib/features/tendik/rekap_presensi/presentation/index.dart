import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';
import '../bloc/rekap_presensi_bloc.dart';
import '../bloc/rekap_presensi_event.dart';
import '../bloc/rekap_presensi_state.dart';
import '../data/providers/rekap_presensi_provider.dart';
import '../data/repositories/rekap_presensi_repository.dart';
import '../domain/usecases/get_rekap_presensi_usecase.dart';
import 'detail.dart';
import 'widgets/statistik_tendik_card.dart';
import 'widgets/summary_mini_card.dart';
import 'widgets/info_disclaimer_banner.dart';
import 'widgets/rekap_log_item.dart';

// ============================================================
// HALAMAN UTAMA: REKAP PRESENSI LANDING (CLEAN ARCHITECTURE WRAPPER)
// ============================================================
class RekapPresensi extends StatelessWidget {
  const RekapPresensi({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi Provider -> Repository -> UseCase -> BLoC
    final provider = const RekapPresensiProvider();
    final repository = RekapPresensiRepository(provider: provider);
    final useCase = GetRekapPresensiUseCase(repository: repository);

    return BlocProvider(
      create: (context) => RekapPresensiBloc(
        getRekapPresensiUseCase: useCase,
      )..add(const FetchRekapPresensiEvent()),
      child: const RekapPresensiView(),
    );
  }
}

// ============================================================
// VIEW COMPONENT: REKAP PRESENSI VIEW
// ============================================================
class RekapPresensiView extends StatelessWidget {
  const RekapPresensiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Rekap Presensi', style: AppTextStyle.headingXl),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 10),
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
                child: BlocBuilder<RekapPresensiBloc, RekapPresensiState>(
                  builder: (context, state) {
                    if (state is RekapPresensiLoading || state is RekapPresensiInitial) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2B86C3),
                        ),
                      );
                    }

                    if (state is RekapPresensiError) {
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
                                  context.read<RekapPresensiBloc>().add(
                                        const FetchRekapPresensiEvent(),
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

                    if (state is RekapPresensiLoaded) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<RekapPresensiBloc>().add(
                                const RefreshRekapPresensiEvent(),
                              );
                        },
                        color: const Color(0xFF2B86C3),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Card Statistik Tendik
                              const StatistikTendikCard(),
                              const SizedBox(height: 14),

                              // Row mini summary (Dinamis dari BLoC State)
                              Row(
                                children: [
                                  Expanded(
                                    child: SummaryMiniCard(
                                      title: 'Transport',
                                      value: state.totalTransport,
                                      unit: 'Rupiah',
                                      iconBgColor: const Color(0x142B86C3),
                                      iconColor: const Color(0xFF2B86C3),
                                      icon: Icons.directions_car,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: SummaryMiniCard(
                                      title: 'Total jam',
                                      value: state.totalJam,
                                      unit: 'jam: menit',
                                      iconBgColor: const Color(0x142B86C3),
                                      iconColor: const Color(0xFF2B86C3),
                                      icon: Icons.access_time_filled,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),

                              // Section Header "Monitoring"
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2B86C3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Monitoring',
                                  style: AppTextStyle.bodyLg.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),

                              // List rekap log presensi (Dynamic Looping)
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.logs.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final log = state.logs[index];
                                  return RekapLogItem(
                                    log: log,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RekapPresensiDetailPage(log: log),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),

                              // Info Disclaimer Banner
                              const InfoDisclaimerBanner(),
                              const SizedBox(height: 40),
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
          ],
        ),
      ),
    );
  }
}
