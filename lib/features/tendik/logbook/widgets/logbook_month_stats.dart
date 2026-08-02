import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Baris Statistik Bulan Logbook
// Menampilkan Total Skor, Kategori, dan Progress secara
// horizontal — hanya muncul jika bulan tersebut memiliki data.
// ============================================================
class LogbookMonthStats extends StatelessWidget {
  final int totalSkor;
  final int maxSkor;

  const LogbookMonthStats({
    super.key,
    required this.totalSkor,
    this.maxSkor = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(
              'Total Skor',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.43,
                letterSpacing: -0.08,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(
              '$totalSkor',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFE65768),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1.40,
                letterSpacing: -0.34,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
