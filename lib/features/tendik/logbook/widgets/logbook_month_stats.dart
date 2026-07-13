import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

// ============================================================
// WIDGET: Baris Statistik Bulan Logbook
// Menampilkan Total Skor, Kategori, dan Progress secara
// horizontal — hanya muncul jika bulan tersebut memiliki data.
// ============================================================
class LogbookMonthStats extends StatelessWidget {
  final int totalSkor;
  final int maxSkor;
  final String kategori;
  final Color kategoriColor;
  final int progressPersen;

  const LogbookMonthStats({
    super.key,
    required this.totalSkor,
    required this.maxSkor,
    required this.kategori,
    required this.kategoriColor,
    required this.progressPersen,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Total Skor ---
        _StatColumn(
          label: 'Total Skor',
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$totalSkor',
                  style: const TextStyle(
                    color: Color(0xFFE65768),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                    letterSpacing: -0.34,
                  ),
                ),
                TextSpan(
                  text: '/$maxSkor',
                  style: const TextStyle(
                    color: Color(0xFFE5E6E8),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                    letterSpacing: -0.08,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),

        // --- Kategori ---
        _StatColumn(
          label: 'Kategori',
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: ShapeDecoration(
              color: kategoriColor.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: kategoriColor),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: Text(
              kategori.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyXs.copyWith(
                color: kategoriColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // --- Progress ---
        _StatColumn(
          label: 'Progress',
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$progressPersen',
                  style: const TextStyle(
                    color: Color(0xFF2B86C3),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                    letterSpacing: -0.34,
                  ),
                ),
                const TextSpan(
                  text: '%',
                  style: TextStyle(
                    color: Color(0xFF2B86C3),
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Kolom statistik generik (label + nilai)
// ============================================================
class _StatColumn extends StatelessWidget {
  final String label;
  final Widget child;

  const _StatColumn({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1.43,
              letterSpacing: -0.08,
            ),
          ),
          const SizedBox(height: 6),
          // Nilai
          child,
        ],
      ),
    );
  }
}
