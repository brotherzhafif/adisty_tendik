import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/monitoring_presensi_bloc.dart';
import '../bloc/monitoring_presensi_event.dart';
import '../bloc/monitoring_presensi_state.dart';
import '../data/providers/monitoring_presensi_provider.dart';
import '../data/repositories/monitoring_presensi_repository.dart';
import '../domain/usecases/get_monitoring_presensi_usecase.dart';
import 'monitoring_detail.dart';
import 'widgets/bulan_picker_modal.dart';

// ============================================================
// HALAMAN UTAMA: MONITORING PRESENSI (BLoC & Clean Architecture)
// Menampilkan rekap & status presensi pegawai per tanggal
// ============================================================
class MonitoringPresensi extends StatelessWidget {
  const MonitoringPresensi({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = MonitoringPresensiProvider();
    final repository = MonitoringPresensiRepository(provider: provider);
    final useCase = GetMonitoringPresensiUseCase(repository: repository);

    return BlocProvider(
      create: (context) => MonitoringPresensiBloc(
        getMonitoringPresensiUseCase: useCase,
      )..add(FetchMonitoringPresensiEvent()),
      child: const _MonitoringPresensiView(),
    );
  }
}

class _MonitoringPresensiView extends StatelessWidget {
  const _MonitoringPresensiView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B86C3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Monitoring Presensi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                child: BlocBuilder<MonitoringPresensiBloc,
                    MonitoringPresensiState>(
                  builder: (context, state) {
                    if (state is MonitoringPresensiLoading ||
                        state is MonitoringPresensiInitial) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF2B86C3),
                        ),
                      );
                    }

                    if (state is MonitoringPresensiError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline_rounded,
                              color: Colors.red,
                              size: 48,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              state.message,
                              style: const TextStyle(
                                color: Color(0xFF293241),
                                fontSize: 14,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<MonitoringPresensiBloc>().add(
                                      FetchMonitoringPresensiEvent(),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2B86C3),
                              ),
                              child: const Text('Coba Lagi'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is MonitoringPresensiLoaded) {
                      final currentTanggal = state.currentTanggal;
                      final listLabels = state.listTanggal
                          .map((e) => e.labelTanggal)
                          .toList();

                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity != null) {
                            if (details.primaryVelocity! < 0) {
                              // Swipe kiri -> Tanggal berikutnya
                              if (state.selectedIndex <
                                  state.listTanggal.length - 1) {
                                context.read<MonitoringPresensiBloc>().add(
                                      ChangeIndexMonitoringEvent(
                                        state.selectedIndex + 1,
                                      ),
                                    );
                              }
                            } else if (details.primaryVelocity! > 0) {
                              // Swipe kanan -> Tanggal sebelumnya
                              if (state.selectedIndex > 0) {
                                context.read<MonitoringPresensiBloc>().add(
                                      ChangeIndexMonitoringEvent(
                                        state.selectedIndex - 1,
                                      ),
                                    );
                              }
                            }
                          }
                        },
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 21,
                            vertical: 20,
                          ),
                          child: Column(
                            children: [
                              // --- Date Info Card (Clickable to open picker) ---
                              InkWell(
                                onTap: () async {
                                  final newIndex = await BulanPickerModal.show(
                                    context,
                                    listBulan: listLabels,
                                    selectedBulan: currentTanggal.labelTanggal,
                                  );
                                  if (newIndex != null && context.mounted) {
                                    context.read<MonitoringPresensiBloc>().add(
                                          ChangeIndexMonitoringEvent(newIndex),
                                        );
                                  }
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 19,
                                    vertical: 12,
                                  ),
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
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: ShapeDecoration(
                                          color: const Color(0x1E0067AD),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.calendar_today_rounded,
                                          color: Color(0xFF0067AD),
                                          size: 22,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentTanggal.hariNama,
                                              style: const TextStyle(
                                                color: Color(0xFF8B9098),
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              currentTanggal.tanggalLengkap,
                                              style: const TextStyle(
                                                color: Color(0xFF293241),
                                                fontSize: 16,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.27,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.unfold_more_rounded,
                                        color: Color(0xFF8B9098),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // --- Date Selector Card (With Left/Right Arrow Navigation) ---
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
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
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.chevron_left_rounded,
                                        color: state.selectedIndex > 0
                                            ? const Color(0xFF293241)
                                            : const Color(0xFFCCCCCC),
                                        size: 24,
                                      ),
                                      onPressed: state.selectedIndex > 0
                                          ? () {
                                              context
                                                  .read<
                                                      MonitoringPresensiBloc>()
                                                  .add(
                                                    ChangeIndexMonitoringEvent(
                                                      state.selectedIndex - 1,
                                                    ),
                                                  );
                                            }
                                          : null,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        final newIndex =
                                            await BulanPickerModal.show(
                                          context,
                                          listBulan: listLabels,
                                          selectedBulan:
                                              currentTanggal.labelTanggal,
                                        );
                                        if (newIndex != null &&
                                            context.mounted) {
                                          context
                                              .read<MonitoringPresensiBloc>()
                                              .add(
                                                ChangeIndexMonitoringEvent(
                                                  newIndex,
                                                ),
                                              );
                                        }
                                      },
                                      child: Text(
                                        currentTanggal.tanggalLengkap,
                                        style: const TextStyle(
                                          color: Color(0xFF293241),
                                          fontSize: 16,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.27,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.chevron_right_rounded,
                                        color: state.selectedIndex <
                                                state.listTanggal.length - 1
                                            ? const Color(0xFF293241)
                                            : const Color(0xFFCCCCCC),
                                        size: 24,
                                      ),
                                      onPressed: state.selectedIndex <
                                              state.listTanggal.length - 1
                                          ? () {
                                              context
                                                  .read<
                                                      MonitoringPresensiBloc>()
                                                  .add(
                                                    ChangeIndexMonitoringEvent(
                                                      state.selectedIndex + 1,
                                                    ),
                                                  );
                                            }
                                          : null,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),

                              // --- List Items Monitoring Presensi Pegawai ---
                              ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: currentTanggal.pegawai.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final pegawai = currentTanggal.pegawai[index];
                                  final isLate = pegawai.status == 'Late';

                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPresensiKoreksi.fromModel(
                                            pegawai: pegawai,
                                            tanggal:
                                                currentTanggal.labelTanggal,
                                          ),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(14),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          // Avatar
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(64),
                                            child: Image.network(
                                              pegawai.photoUrl,
                                              width: 45,
                                              height: 45,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                width: 45,
                                                height: 45,
                                                color: const Color(0xFF2B86C3),
                                                child: const Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),

                                          // Detail Pegawai & Status
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  pegawai.nama,
                                                  style: const TextStyle(
                                                    color: Color(0xFF293241),
                                                    fontSize: 13,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  'Presensi : ${pegawai.lokasi}',
                                                  style: const TextStyle(
                                                    color: Color(0xFF5F6570),
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),

                                                // Row Badges
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 6,
                                                    vertical: 3,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: isLate
                                                        ? const Color(
                                                            0x19FFAC2F)
                                                        : const Color(
                                                            0x194AAF57),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    spacing: 8,
                                                    runSpacing: 4,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            width: 7,
                                                            height: 7,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isLate
                                                                  ? const Color(
                                                                      0xFFFFAC2F)
                                                                  : const Color(
                                                                      0xFF18C079),
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 4),
                                                          Text(
                                                            pegawai.status,
                                                            style: TextStyle(
                                                              color: isLate
                                                                  ? const Color(
                                                                      0xFFFFAC2F)
                                                                  : const Color(
                                                                      0xFF18C079),
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  'Nunito',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        'Masuk : ${pegawai.masuk}',
                                                        style: TextStyle(
                                                          color: isLate
                                                              ? const Color(
                                                                  0xFFFFAC2F)
                                                              : const Color(
                                                                  0xFF18C079),
                                                          fontSize: 10,
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Pulang : ${pegawai.pulang}',
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFFFFAC2F),
                                                          fontSize: 10,
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.chevron_right_rounded,
                                            color: Color(0xFF8B9098),
                                            size: 20,
                                          ),
                                        ],
                                      ),
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
        ],
      ),
    );
  }
}
