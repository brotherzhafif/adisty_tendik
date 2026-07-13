import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'presensi_state.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

// ============================================================
// KOMPONEN: PRESENSI CARD
// Card biru yang menampilkan info jam masuk / pulang / shift
// sesuai state presensi yang sedang aktif.
// ============================================================
class PresensiCard extends StatelessWidget {
  final PresensiState state;

  const PresensiCard({super.key, this.state = PresensiState.belumPresensi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(0xFF2B86C3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header: label & tanggal ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Presensi Hari ini',
                style: AppTextStyle.bodyMd,
              ),
              Text(
                'Selasa, 30 Desember 2025',
                style: AppTextStyle.bodySm.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Body: dua kotak jam (kiri & kanan) ──
          _buildShiftRow(),
          const SizedBox(height: 10),

          // ── Lokasi & Transportasi ──
          _buildLokasiRow(),
        ],
      ),
    );
  }

  Widget _buildShiftRow() {
    switch (state) {
      // ── State: Belum Presensi ──────────────────────────────
      case PresensiState.belumPresensi:
        return Row(
          children: [
            Expanded(
              child: _PresensiBox(
                label: 'Masuk',
                labelColor: const Color(0xFF18C079),
                jam: '06:45 - 14.00',
                iconPath: 'assets/icons/(home_page)_masuk-icon.svg',
              ),
            ),
            _separator(),
            Expanded(
              child: _PresensiBox(
                label: 'Pulang',
                labelColor: const Color(0xFF5F6570),
                jam: '--.--',
                iconPath: 'assets/icons/(home_page)_keluar-icon.svg',
              ),
            ),
          ],
        );

      // ── State: Shift 1 Selesai ─────────────────────────────
      case PresensiState.shift1Selesai:
        return Row(
          children: [
            Expanded(
              child: _PresensiBox(
                label: 'Shift 1 (Selesai)',
                labelColor: const Color(0xFF18C079),
                jam: '06:45 - 14.00',
                iconPath: 'assets/icons/(home_page)_masuk-icon.svg',
              ),
            ),
            _separator(),
            Expanded(
              child: _PresensiBox(
                label: 'Shift 2 (Berikutnya)',
                labelColor: const Color(0xFF0067AD),
                jam: '14.00 - 19.00',
                iconPath: 'assets/icons/(home_page)_keluar-icon.svg',
              ),
            ),
          ],
        );

      // ── State: Pulang ──────────────────────────────────────
      case PresensiState.pulang:
        return Row(
          children: [
            Expanded(
              child: _PresensiBox(
                label: 'Masuk',
                labelColor: const Color(0xFF18C079),
                jam: '06:45',
                iconPath: 'assets/icons/(home_page)_masuk-icon.svg',
              ),
            ),
            _separator(),
            Expanded(
              child: _PresensiBox(
                label: 'Pulang',
                labelColor: const Color(0xFFFFAC2F),
                jam: '14.00',
                iconPath: 'assets/icons/(home_page)_keluar-icon.svg',
              ),
            ),
          ],
        );
    }
  }

  Widget _separator() {
    return Container(
      width: 23,
      height: 23,
      decoration: ShapeDecoration(
        color: const Color(0xFF2B86C3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
      ),
    );
  }

  Widget _buildLokasiRow() {
    final showTransport = state == PresensiState.pulang;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 16),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                'Kampus 4 - Gedung Kedokteran',
                style: AppTextStyle.bodySm.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (showTransport) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFFB7F54)),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                  child: Text(
                    'Transportasi Hari Ini',
                    style: AppTextStyle.bodySm.copyWith(
                      color: const Color(0xFF303B4C),
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'Rp20.000',
                  style: AppTextStyle.bodyLg.copyWith(
                    color: const Color(0xFFFB7F54),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ============================================================
// KOMPONEN: KOTAK JAM (kiri/kanan dalam PresensiCard)
// ============================================================
class _PresensiBox extends StatelessWidget {
  final String label;
  final Color labelColor;
  final String jam;
  final String iconPath;

  const _PresensiBox({
    required this.label,
    required this.labelColor,
    required this.jam,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label (Masuk / Pulang / Shift)
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 14, color: labelColor),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodySm.copyWith(color: labelColor),
                  ),
                ),
              ],
            ),
          ),

          // Jam
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(labelColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    jam,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodyMd.copyWith(
                      color: const Color(0xFF293241),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
