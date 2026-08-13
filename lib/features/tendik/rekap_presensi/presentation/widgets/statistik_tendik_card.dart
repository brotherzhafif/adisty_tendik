import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';
import '../../data/models/rekap_presensi_model.dart';
import 'package:adisty_tendik_module/core/widgets/searchable_picker_modal.dart';

// ============================================================
// KOMPONEN: CARD STATISTIK TENDIK (dengan swipe & tombol ganti bulan)
// ============================================================
class StatistikTendikCard extends StatefulWidget {
  final List<RekapBulanDataModel> dataBulan;
  final int bulanIndex;
  final ValueChanged<int> onBulanChanged;

  const StatistikTendikCard({
    super.key,
    required this.dataBulan,
    required this.bulanIndex,
    required this.onBulanChanged,
  });

  @override
  State<StatistikTendikCard> createState() => _StatistikTendikCardState();
}

class _StatistikTendikCardState extends State<StatistikTendikCard>
    with SingleTickerProviderStateMixin {
  bool _slideLeft = true;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
  }

  @override
  void didUpdateWidget(covariant StatistikTendikCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.bulanIndex != oldWidget.bulanIndex) {
      _slideLeft = widget.bulanIndex < oldWidget.bulanIndex;
      _animController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  bool _canGoNext() {
    return widget.bulanIndex < widget.dataBulan.length - 1;
  }

  bool _canGoPrev() {
    return widget.bulanIndex > 0;
  }

  @override
  Widget build(BuildContext context) {
    final bulanAktif =
        widget.dataBulan.isNotEmpty &&
            widget.bulanIndex >= 0 &&
            widget.bulanIndex < widget.dataBulan.length
        ? widget.dataBulan[widget.bulanIndex]
        : const RekapBulanDataModel(
            labelBulan: 'Oktober 2026',
            month: 10,
            year: 2026,
            totalHariKerja: 0,
            persentase: 0,
            onTime: 0,
            late: 0,
            absen: 0,
            totalTransport: '0',
            totalJam: '00:00',
            logs: [],
          );

    final bool canGoNext = _canGoNext();
    final bool canGoPrev = _canGoPrev();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (details) {
        final dx = details.velocity.pixelsPerSecond.dx;
        if (dx < -300) {
          if (canGoNext) {
            widget.onBulanChanged(widget.bulanIndex + 1);
          }
        } else if (dx > 300) {
          if (canGoPrev) {
            widget.onBulanChanged(widget.bulanIndex - 1);
          }
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
              const Text(
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
                    icon: const Icon(Icons.chevron_left, size: 28),
                    color: canGoPrev ? Colors.white : const Color(0x66FFFFFF),
                    onPressed: canGoPrev
                        ? () => widget.onBulanChanged(widget.bulanIndex - 1)
                        : null,
                  ),

                  // Label bulan dengan animasi slide & tap untuk buka picker modal searchable
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final listBulanLabels = widget.dataBulan
                            .map((b) => b.labelBulan)
                            .toList();
                        final selectedIndex = await SearchablePickerModal.show(
                          context,
                          items: listBulanLabels,
                          selectedItem: bulanAktif.labelBulan,
                          title: 'Pilih Bulan Rekap Presensi',
                          hintText: 'Cari bulan dan tahun...',
                        );
                        if (selectedIndex != null && selectedIndex != -1) {
                          widget.onBulanChanged(selectedIndex);
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 36,
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
                                color: Color(0xFFF6F7F7),
                                fontSize: 22,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.46,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Tombol kanan
                  IconButton(
                    icon: const Icon(Icons.chevron_right, size: 28),
                    color: canGoNext ? Colors.white : const Color(0x66FFFFFF),
                    onPressed: canGoNext
                        ? () => widget.onBulanChanged(widget.bulanIndex + 1)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 4),

              // ---- Hint swipe ----
              const Row(
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
                child: _buildStats(
                  bulanAktif,
                  key: ValueKey(bulanAktif.labelBulan),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStats(RekapBulanDataModel data, {Key? key}) {
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
                const Text(
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
