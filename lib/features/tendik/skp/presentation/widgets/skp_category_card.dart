import 'package:flutter/material.dart';

// ============================================================
// MODEL: Data Indikator SKP
// ============================================================
class SkpIndicatorData {
  final String name;
  final double score;

  const SkpIndicatorData({required this.name, required this.score});
}

// ============================================================
// WIDGET: Card Kategori SKP (AIK / Tugas Umum / Penunjang)
// Menampilkan tabel indikator nilai dan ringkasan skor akhir.
// ============================================================
class SkpCategoryCard extends StatelessWidget {
  final String title;
  final String weight;
  final String subTitle;
  final List<SkpIndicatorData> indicators;
  final double totalScore;
  final String summaryTitle;
  final Color themeColor;
  final Color bannerBgColor;
  final Color summaryBorderColor;

  const SkpCategoryCard({
    super.key,
    required this.title,
    required this.weight,
    required this.subTitle,
    required this.indicators,
    required this.totalScore,
    required this.summaryTitle,
    required this.themeColor,
    required this.bannerBgColor,
    required this.summaryBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadows: const [
          BoxShadow(
            color: Color(0x087281DF),
            blurRadius: 4.11,
            offset: Offset(0, 0.52),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0C7281DF),
            blurRadius: 6.99,
            offset: Offset(0, 1.78),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x0F7281DF),
            blurRadius: 10.20,
            offset: Offset(0, 4.11),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Category Header & Subtext Banner ---
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and weight row
                Container(
                  width: double.infinity,
                  height: 24,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(color: bannerBgColor),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 1.33,
                        ),
                      ),
                      Text(
                        weight,
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 10,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w500,
                          height: 1.20,
                        ),
                      ),
                    ],
                  ),
                ),
                // Subtext description row
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(color: bannerBgColor),
                  child: Text(
                    subTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // --- Table Column ---
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Indikator & Skor (0-100)
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 10, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Indikator',
                      style: TextStyle(
                        color: Color(0xFF0A0A0A),
                        fontSize: 10,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w500,
                        height: 1.20,
                      ),
                    ),
                    Text(
                      'Skor (0-100)',
                      style: TextStyle(
                        color: Color(0xFF0A0A0A),
                        fontSize: 10,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w500,
                        height: 1.20,
                      ),
                    ),
                  ],
                ),
              ),

              // Rows Container with rounded light color background
              Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: bannerBgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  children: indicators.map((indicator) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              child: Text(
                                indicator.name,
                                style: const TextStyle(
                                  color: Color(0xFF4A5565),
                                  fontSize: 10,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w500,
                                  height: 1.20,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            alignment: Alignment.centerRight,
                            child: Text(
                              indicator.score.toStringAsFixed(2),
                              style: TextStyle(
                                color: themeColor,
                                fontSize: 12,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                height: 1.33,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // --- Score Summary Box at the Bottom ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            decoration: ShapeDecoration(
              color: bannerBgColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: summaryBorderColor),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  summaryTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                  ),
                ),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: totalScore.toStringAsFixed(2),
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 24,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 1.08,
                          letterSpacing: -0.43,
                        ),
                      ),
                      const TextSpan(
                        text: '/100',
                        style: TextStyle(
                          color: Color(0xFF8B9098),
                          fontSize: 12,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 1.33,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
