import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

// ============================================================
// KOMPONEN: CARD STATISTIK TENDIK (dengan swipe & tombol ganti bulan)
// ============================================================
class StatistikTendikCard extends StatefulWidget {
  const StatistikTendikCard({super.key});

  @override
  State<StatistikTendikCard> createState() => _StatistikTendikCardState();
}

class _StatistikTendikCardState extends State<StatistikTendikCard>
    with SingleTickerProviderStateMixin {
  // Bulan & tahun aktif (default: Oktober 2026)
  int _month = 10;
  int _year = 2026;

  // Arah slide untuk AnimatedSwitcher
  bool _slideLeft = true;

  // AnimationController untuk micro-animation
  late AnimationController _animController;

  final List<String> _monthNames = const [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  // ---- Mock data per bulan (key: "mm-yyyy") ----
  // Dalam proyek nyata ini diambil dari BLoC/API
  Map<String, _MonthData> get _mockData => {
    '10-2026': const _MonthData(
      totalHariKerja: 20,
      persentase: 90,
      onTime: 12,
      late: 3,
      absen: 2,
    ),
    '09-2026': const _MonthData(
      totalHariKerja: 22,
      persentase: 86,
      onTime: 14,
      late: 4,
      absen: 3,
    ),
    '08-2026': const _MonthData(
      totalHariKerja: 21,
      persentase: 95,
      onTime: 18,
      late: 2,
      absen: 1,
    ),
    '11-2026': const _MonthData(
      totalHariKerja: 19,
      persentase: 78,
      onTime: 10,
      late: 5,
      absen: 4,
    ),
  };

  _MonthData get _currentData {
    final key = '$_month-$_year';
    return _mockData[key] ??
        _MonthData(
          totalHariKerja: 20,
          persentase: 0,
          onTime: 0,
          late: 0,
          absen: 0,
        );
  }

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _changeMonth(bool toPrev) {
    _slideLeft = toPrev;

    setState(() {
      if (toPrev) {
        _month--;
        if (_month < 1) {
          _month = 12;
          _year--;
        }
      } else {
        _month++;
        if (_month > 12) {
          _month = 1;
          _year++;
        }
      }
    });

    // Jalankan micro-animation
    _animController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final data = _currentData;
    final monthLabel = '${_monthNames[_month - 1]} $_year';

    return GestureDetector(
      // ---- Evaluasi saat drag selesai ----
      onHorizontalDragEnd: (details) {
        final dx = details.velocity.pixelsPerSecond.dx;
        // Prioritaskan velocity; fallback ke posisi delta
        if (dx < -300) {
          _changeMonth(false); // swipe kiri → bulan berikutnya
        } else if (dx > 300) {
          _changeMonth(true); // swipe kanan → bulan sebelumnya
        }
      },
      child: AnimatedBuilder(
        animation: _animController,
        builder: (context, child) {
          return child!;
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: ShapeDecoration(
            color: const Color(0xFF2B86C3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x0F7281DF),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ---- Judul ----
              Text(
                'Statistik Tendik',
                style: TextStyle(
                  color: Color(0xFFF6F7F7),
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.27,
                ),
              ),
              const SizedBox(height: 4),

              // ---- Navigasi bulan ----
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol kiri
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => _changeMonth(true),
                  ),

                  // Label bulan dengan animasi slide
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    transitionBuilder: (child, animation) {
                      final offset = _slideLeft
                          ? const Offset(-0.4, 0)
                          : const Offset(0.4, 0);
                      return SlideTransition(
                        position: Tween<Offset>(begin: offset, end: Offset.zero)
                            .animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Text(
                      monthLabel,
                      key: ValueKey(monthLabel),
                      style: const TextStyle(
                        color: Color(0xFFF6F7F7),
                        fontSize: 23,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.46,
                      ),
                    ),
                  ),

                  // Tombol kanan
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () => _changeMonth(false),
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // ---- Hint swipe ----
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFF6F7F7), size: 14),
                  SizedBox(width: 6),
                  Text(
                    'Geser kiri / kanan untuk ganti bulan',
                    style: TextStyle(
                      color: Color(0xFFF6F7F7),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ---- Statistik utama ----
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                child: _buildStats(data, key: ValueKey('$_month-$_year')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats(_MonthData data, {Key? key}) {
    final total = data.onTime + data.late + data.absen;

    return Column(
      key: key,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total hari kerja',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${data.totalHariKerja} hari',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Persentase kehadiran',
                  style: AppTextStyle.inputValue.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  '${data.persentase} %',
                  style: const TextStyle(
                    color: Color(0xFFF2F2F7),
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.59,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ---- Segmented Progress Bar ----
        Container(
          width: double.infinity,
          height: 20,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAlias,
          child: total == 0
              ? Container(color: Colors.white24)
              : Row(
                  children: [
                    if (data.onTime > 0)
                      Expanded(
                        flex: data.onTime,
                        child: Container(color: const Color(0xFF18C079)),
                      ),
                    if (data.late > 0)
                      Expanded(
                        flex: data.late,
                        child: Container(color: const Color(0xFFFFAC2F)),
                      ),
                    if (data.absen > 0)
                      Expanded(
                        flex: data.absen,
                        child: Container(color: const Color(0xFFE65768)),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: 16),

        // ---- Legend ----
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _buildLegendItem(
              const Color(0xFF18C079),
              'On Time = ${data.onTime}',
            ),
            _buildLegendItem(const Color(0xFFFFAC2F), 'Late = ${data.late}'),
            _buildLegendItem(const Color(0xFFE65768), 'Absen = ${data.absen}'),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: ShapeDecoration(
            color: color,
            shape: const CircleBorder(),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTextStyle.bodySm.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// ---- Model data per bulan ----
class _MonthData {
  final int totalHariKerja;
  final int persentase;
  final int onTime;
  final int late;
  final int absen;

  const _MonthData({
    required this.totalHariKerja,
    required this.persentase,
    required this.onTime,
    required this.late,
    required this.absen,
  });
}
