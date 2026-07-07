import 'package:flutter/material.dart';

// ============================================================
// KOMPONEN: CARD STATISTIK TENDIK
// ============================================================
class StatistikTendikCard extends StatelessWidget {
  const StatistikTendikCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: ShapeDecoration(
        color: const Color(0xFF2B86C3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {},
              ),
              const Text(
                'Oktober 2026',
                style: TextStyle(
                  color: Color(0xFFF6F7F7),
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.46,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.info_outline, color: Color(0xFFF6F7F7), size: 14),
              SizedBox(width: 6),
              Text(
                'Geser kiri untuk melihat bulan sebelumnya',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Total hari kerja',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '20 hari',
                    style: TextStyle(
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
                children: const [
                  Text(
                    'Persentase kehadiran',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.17,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '90 %',
                    style: TextStyle(
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

          // Segmented Progress Bar (On Time: 12, Late: 3, Absen: 2)
          Container(
            width: double.infinity,
            height: 20,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                Expanded(
                  flex: 12,
                  child: Container(color: const Color(0xFF18C079)),
                ),
                Expanded(
                  flex: 3,
                  child: Container(color: const Color(0xFFFFAC2F)),
                ),
                Expanded(
                  flex: 2,
                  child: Container(color: const Color(0xFFE65768)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Legend
          Wrap(
            spacing: 16,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildLegendItem(const Color(0xFF18C079), 'On Time = 12'),
              _buildLegendItem(const Color(0xFFFFAC2F), 'Late = 3'),
              _buildLegendItem(const Color(0xFFE65768), 'Absen = 2'),
            ],
          ),
        ],
      ),
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
