import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Kartu Header Detail Logbook
// Menampilkan tanggal aktivitas, waktu pembuatan, dan status.
// ============================================================
class LogbookDetailHeaderCard extends StatelessWidget {
  final String tanggalLengkap; // e.g. 'Jumat, 03 Juli 2026'
  final String waktuDibuat;     // e.g. 'Dibuat pada 03 Juli 2026, 10:25 WIB'
  final String status;          // e.g. 'Tersimpan'

  const LogbookDetailHeaderCard({
    super.key,
    required this.tanggalLengkap,
    required this.waktuDibuat,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
          BoxShadow(
            color: Color(0x0F7281DF),
            blurRadius: 10.20,
            offset: Offset(0, 4.11),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Icon Container Bulat ---
          Container(
            width: 52,
            height: 52,
            decoration: const ShapeDecoration(
              color: Color(0x192B86C3),
              shape: CircleBorder(),
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              color: Color(0xFF2B86C3),
              size: 24,
            ),
          ),
          
          const SizedBox(width: 12),

          // --- Kolom Info Teks ---
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tanggalLengkap,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  waktuDibuat,
                  style: const TextStyle(
                    color: Color(0xFFCCCED1),
                    fontSize: 10,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // --- Badge Status ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: ShapeDecoration(
              color: const Color(0x194AAF57),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xF54AAF57),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Color(0xF54AAF57),
                fontSize: 10,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
