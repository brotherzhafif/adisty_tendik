import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';
import 'bloc/logbook_bloc.dart';
import 'bloc/logbook_event.dart';
import 'bloc/logbook_state.dart';
import 'data/models/logbook_model.dart';
import 'data/providers/logbook_provider.dart';
import 'data/repositories/logbook_repository.dart';
import 'domain/usecases/get_logbook_usecase.dart';
import 'widgets/logbook_app_bar.dart';
import 'widgets/logbook_profile_card.dart';
import 'widgets/logbook_section_header.dart';
import 'widgets/logbook_activity_item.dart';
import 'widgets/logbook_month_stats.dart';
import 'detail.dart';
import 'form.dart';
import '../rekap_presensi/presentation/widgets/bulan_picker_modal.dart';

// ============================================================
// TYPEDEF: Compatibility Alias untuk LogbookBulanDataModel
// ============================================================
typedef LogbookBulanData = LogbookBulanDataModel;

// ============================================================
// HALAMAN: Logbook Dashboard Tendik (CLEAN ARCHITECTURE + BLOC WRAPPER)
// ============================================================
class LogbookPage extends StatelessWidget {
  const LogbookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = const LogbookProvider();
    final repository = LogbookRepository(provider: provider);
    final useCase = GetLogbookUseCase(repository: repository);

    return BlocProvider(
      create: (context) =>
          LogbookBloc(getLogbookUseCase: useCase)
            ..add(const FetchLogbookEvent()),
      child: const LogbookPageView(),
    );
  }
}

// ============================================================
// VIEW COMPONENT: LOGBOOK PAGE VIEW
// Menampilkan profil pegawai, navigasi bulan (swipeable),
// dan daftar aktivitas logbook untuk bulan yang dipilih.
// ============================================================
class LogbookPageView extends StatelessWidget {
  const LogbookPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogbookBloc, LogbookState>(
      builder: (context, state) {
        final bool showTambahButton =
            state is LogbookLoaded && !state.currentBulanData.hasSkor;

        return Scaffold(
          backgroundColor: const Color(0xFF2B86C3),
          floatingActionButton: showTambahButton
              ? Material(
                  elevation: 6,
                  shadowColor: const Color(0x332B86C3),
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF2B86C3),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogbookFormPage(),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Tambah',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                              letterSpacing: -0.08,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : null,
          body: Column(
            children: [
              // --- AppBar Biru ---
              LogbookAppBar(
                title: 'Logbook',
                onBack: () => Navigator.of(context).maybePop(),
              ),

              // --- Konten Utama ---
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
                    child: Builder(
                      builder: (context) {
                        if (state is LogbookLoading ||
                            state is LogbookInitial) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF2B86C3),
                            ),
                          );
                        }

                        if (state is LogbookError) {
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
                                      context.read<LogbookBloc>().add(
                                        const FetchLogbookEvent(),
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

                        if (state is LogbookLoaded) {
                          final currentBulan = state.currentBulanData;

                          return RefreshIndicator(
                            onRefresh: () async {
                              context.read<LogbookBloc>().add(
                                const RefreshLogbookEvent(),
                              );
                            },
                            color: const Color(0xFF2B86C3),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                20,
                                16,
                                24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // --- Card Gabungan Header & Selector Bulan ---
                                  _LogbookHeaderCard(
                                    profile: state.profile,
                                    dataBulan: state.dataBulan,
                                    bulanIndex: state.bulanIndex,
                                    onBulanChanged: (index) {
                                      context.read<LogbookBloc>().add(
                                        ChangeBulanLogbookEvent(index),
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 24),

                                  // --- Header Section Aktivitas ---
                                  LogbookSectionHeader(
                                    jumlahAktivitas:
                                        currentBulan.aktivitas.length,
                                    showTambah: false,
                                  ),

                                  const SizedBox(height: 16),

                                  // --- Daftar Aktivitas ---
                                  _DaftarAktivitas(
                                    daftarAktivitas: currentBulan.aktivitas,
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
            ],
          ),
        );
      },
    );
  }
}

// ============================================================
// KOMPONEN: Card Gabungan Profil, Selector Bulan, dan Statistik
// Container luar berwarna putih dan profil tetap statis.
// Hanya navigator bulan di tengah yang dapat digeser (swipe).
// ============================================================
class _LogbookHeaderCard extends StatefulWidget {
  final LogbookProfileModel profile;
  final List<LogbookBulanDataModel> dataBulan;
  final int bulanIndex;
  final ValueChanged<int> onBulanChanged;

  const _LogbookHeaderCard({
    required this.profile,
    required this.dataBulan,
    required this.bulanIndex,
    required this.onBulanChanged,
  });

  @override
  State<_LogbookHeaderCard> createState() => _LogbookHeaderCardState();
}

class _LogbookHeaderCardState extends State<_LogbookHeaderCard> {
  bool _slideLeft = true;

  @override
  void didUpdateWidget(covariant _LogbookHeaderCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.bulanIndex != oldWidget.bulanIndex) {
      _slideLeft = widget.bulanIndex < oldWidget.bulanIndex;
    }
  }

  bool _canGoNext() {
    return widget.bulanIndex < widget.dataBulan.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final bulanAktif =
        widget.dataBulan.isNotEmpty &&
            widget.bulanIndex >= 0 &&
            widget.bulanIndex < widget.dataBulan.length
        ? widget.dataBulan[widget.bulanIndex]
        : const LogbookBulanDataModel(labelBulan: '', aktivitas: []);

    final bool canGoNext = _canGoNext();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (details) {
        final dx = details.velocity.pixelsPerSecond.dx;
        if (dx < -300) {
          if (canGoNext) {
            widget.onBulanChanged(widget.bulanIndex + 1);
          }
        } else if (dx > 300) {
          if (widget.bulanIndex > 0) {
            widget.onBulanChanged(widget.bulanIndex - 1);
          }
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x087281DF),
              blurRadius: 4.11,
              offset: Offset(0, 0.52),
            ),
            BoxShadow(
              color: Color(0x0C7281DF),
              blurRadius: 6.99,
              offset: Offset(0, 1.78),
            ),
            BoxShadow(
              color: Color(0x0F7281DF),
              blurRadius: 10.20,
              offset: Offset(0, 4.11),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Profil Pegawai (Dinamis dari BLoC State) ---
            LogbookProfileCard(
              namaLengkap: widget.profile.namaLengkap.isNotEmpty
                  ? widget.profile.namaLengkap
                  : 'Ahmad Luthfi Abdurrosyid, S.Kom.',
              unitKerja: widget.profile.unitKerja.isNotEmpty
                  ? widget.profile.unitKerja
                  : 'RD - Sub Direktorat Pengembangan',
              jabatan: widget.profile.jabatan.isNotEmpty
                  ? widget.profile.jabatan
                  : 'Programmer',
              subUnit: widget.profile.subUnit.isNotEmpty
                  ? widget.profile.subUnit
                  : 'Aplikasi dan Basis',
              photoUrl: widget.profile.photoUrl.isNotEmpty
                  ? widget.profile.photoUrl
                  : 'https://placehold.co/64x64',
            ),

            // --- Row Selector Bulan & Tahun ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Panah Kiri
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded, size: 24),
                  color: widget.bulanIndex > 0
                      ? const Color(0xFF293241)
                      : const Color(0xFFCCCED1),
                  onPressed: widget.bulanIndex > 0
                      ? () => widget.onBulanChanged(widget.bulanIndex - 1)
                      : null,
                ),

                // Teks Bulan & Tahun (AnimatedSwitcher & Search Picker Modal)
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final listBulanLabels = widget.dataBulan
                          .map((b) => b.labelBulan)
                          .toList();
                      final selectedIndex = await BulanPickerModal.show(
                        context,
                        listBulan: listBulanLabels,
                        selectedBulan: bulanAktif.labelBulan,
                      );
                      if (selectedIndex != null && selectedIndex != -1) {
                        widget.onBulanChanged(selectedIndex);
                      }
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 40,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 280),
                          transitionBuilder: (child, animation) {
                            final offset = _slideLeft
                                ? const Offset(-0.4, 0)
                                : const Offset(0.4, 0);
                            return SlideTransition(
                              position:
                                  Tween<Offset>(
                                    begin: offset,
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOutCubic,
                                    ),
                                  ),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            bulanAktif.labelBulan,
                            key: ValueKey(bulanAktif.labelBulan),
                            style: const TextStyle(
                              color: Color(0xFF293241),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 1.50,
                              letterSpacing: -0.18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Panah Kanan (Disabled jika di bulan terakhir)
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded, size: 24),
                  color: canGoNext
                      ? const Color(0xFF293241)
                      : const Color(0xFFCCCED1),
                  onPressed: canGoNext
                      ? () => widget.onBulanChanged(widget.bulanIndex + 1)
                      : null,
                ),
              ],
            ),

            // --- Stats (Dinamis berdasarkan bulan aktif) ---
            if (bulanAktif.hasSkor) ...[
              const SizedBox(height: 12),
              LogbookMonthStats(
                totalSkor: bulanAktif.totalSkor!,
                jumlahAktivitas: bulanAktif.aktivitas.length,
                dinilaiOlehNama: bulanAktif.dinilaiOlehNama,
                dinilaiOlehPosisi: bulanAktif.dinilaiOlehPosisi,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================
// KOMPONEN: Daftar item aktivitas
// ============================================================
class _DaftarAktivitas extends StatelessWidget {
  final List<LogbookActivityModel> daftarAktivitas;

  const _DaftarAktivitas({required this.daftarAktivitas});

  @override
  Widget build(BuildContext context) {
    if (daftarAktivitas.isEmpty) {
      return _EmptyState();
    }

    return Column(
      children: List.generate(daftarAktivitas.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: LogbookActivityItem(
            data: daftarAktivitas[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LogbookDetailPage(activity: daftarAktivitas[index]),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

// ============================================================
// KOMPONEN: Empty state jika belum ada aktivitas
// ============================================================
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 56, color: Color(0xFFCCCED1)),
          SizedBox(height: 12),
          Text(
            'Belum ada aktivitas',
            style: TextStyle(
              color: Color(0xFFAEB1B7),
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tap tombol Tambah untuk menambah aktivitas baru',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFCCCED1),
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
