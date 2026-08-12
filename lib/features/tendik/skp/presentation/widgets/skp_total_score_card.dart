import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

// ============================================================
// WIDGET: Card Total Skor SKP
// Menampilkan ringkasan Total Skor SKP Pegawai di bagian paling bawah dashboard.
// ============================================================
class SkpTotalScoreCard extends StatelessWidget {
  final double score;

  const SkpTotalScoreCard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF0067AD)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'TOTAL SKOR SKP',
            textAlign: TextAlign.center,
            style: AppTextStyle.headingLg.copyWith(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            score.toStringAsFixed(2),
            textAlign: TextAlign.center,
            style: AppTextStyle.headingXxl.copyWith(
              color: const Color(0xFF0067AD),
              fontSize: 48,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.86,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
