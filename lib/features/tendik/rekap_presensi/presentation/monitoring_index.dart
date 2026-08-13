import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/monitoring_presensi_bloc.dart';
import '../bloc/monitoring_presensi_event.dart';
import '../bloc/monitoring_presensi_state.dart';
import '../data/models/monitoring_presensi_model.dart';
import '../data/providers/monitoring_presensi_provider.dart';
import '../data/repositories/monitoring_presensi_repository.dart';
import '../domain/usecases/get_monitoring_presensi_usecase.dart';
import 'monitoring_detail.dart';
// import 'widgets/bulan_picker_modal.dart'; // diganti native date picker

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
                              // --- Date Info Card (Clickable to open native date picker) ---
                              InkWell(
                                onTap: () async {
                                  final newIndex =
                                      await _showDatePickerPlatform(
                                    context,
                                    listTanggal: state.listTanggal,
                                    currentTanggal: currentTanggal,
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
                                        Icons.calendar_month_rounded,
                                        color: Color(0xFF8B9098),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // --- Date Selector Card (Left/Right Arrow Navigation) ---
                              // Disembunyikan, navigasi tanggal kini via native date picker
                              // Container(
                              //   width: double.infinity,
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: 16,
                              //     vertical: 12,
                              //   ),
                              //   decoration: ShapeDecoration(
                              //     color: Colors.white,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20),
                              //     ),
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       IconButton(icon: Icon(Icons.chevron_left_rounded), onPressed: null),
                              //       Text(currentTanggal.tanggalLengkap),
                              //       IconButton(icon: Icon(Icons.chevron_right_rounded), onPressed: null),
                              //     ],
                              //   ),
                              // ),

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
                                              DetailPresensiKoreksi(
                                            listTanggal: state.listTanggal,
                                            initialTanggalIndex:
                                                state.selectedIndex,
                                            pegawaiId: pegawai.id,
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

// ============================================================
// HELPER: Native platform date picker
// Mengembalikan index dari listTanggal yang cocok dengan tanggal dipilih
// ============================================================
Future<int?> _showDatePickerPlatform(
  BuildContext context, {
  required List<MonitoringTanggalModel> listTanggal,
  required MonitoringTanggalModel currentTanggal,
}) async {
  // Konversi semua label ke DateTime untuk batas picker
  final dates = listTanggal
      .map((t) => _parseTanggalIndonesia(t.tanggalLengkap))
      .whereType<DateTime>()
      .toList();

  if (dates.isEmpty) return null;

  final initialDate =
      _parseTanggalIndonesia(currentTanggal.tanggalLengkap) ?? dates.first;
  final firstDate = dates.reduce((a, b) => a.isBefore(b) ? a : b);
  final lastDate = dates.reduce((a, b) => a.isAfter(b) ? a : b);

  DateTime? picked;

  if (Platform.isIOS) {
    // ── Cupertino (iOS) ──────────────────────────────────────
    picked = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (ctx) {
        DateTime temp = initialDate;
        return Container(
          height: 320,
          color: CupertinoColors.systemBackground.resolveFrom(ctx),
          child: Column(
            children: [
              // Toolbar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Batal'),
                    onPressed: () => Navigator.of(ctx).pop(null),
                  ),
                  CupertinoButton(
                    child: const Text(
                      'Pilih',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onPressed: () => Navigator.of(ctx).pop(temp),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  minimumDate: firstDate,
                  maximumDate: lastDate,
                  onDateTimeChanged: (dt) => temp = dt,
                ),
              ),
            ],
          ),
        );
      },
    );
  } else {
    // ── Material (Android & lainnya) ────────────────────────
    picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('id', 'ID'),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF2B86C3),
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Color(0xFF293241),
          ),
        ),
        child: child!,
      ),
    );
  }

  if (picked == null) return null;

  // Cari index yang paling mendekati tanggal yang dipilih
  for (int i = 0; i < listTanggal.length; i++) {
    final d = _parseTanggalIndonesia(listTanggal[i].tanggalLengkap);
    if (d != null &&
        d.year == picked.year &&
        d.month == picked.month &&
        d.day == picked.day) {
      return i;
    }
  }
  return null;
}

/// Parse format tanggal Indonesia: "9 September 2026" → DateTime
DateTime? _parseTanggalIndonesia(String label) {
  const bulanMap = {
    'Januari': 1,
    'Februari': 2,
    'Maret': 3,
    'April': 4,
    'Mei': 5,
    'Juni': 6,
    'Juli': 7,
    'Agustus': 8,
    'September': 9,
    'Oktober': 10,
    'November': 11,
    'Desember': 12,
  };
  // Hapus nama hari di depan jika ada, contoh: "Rabu, 9 September 2026"
  final cleaned = label.contains(',') ? label.split(',').last.trim() : label.trim();
  final parts = cleaned.split(' ');
  if (parts.length < 3) return null;
  final day = int.tryParse(parts[0]);
  final month = bulanMap[parts[1]];
  final year = int.tryParse(parts[2]);
  if (day == null || month == null || year == null) return null;
  return DateTime(year, month, day);
}
