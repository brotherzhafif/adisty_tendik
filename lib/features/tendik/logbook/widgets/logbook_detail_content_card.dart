import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Kartu Detail Konten Logbook
// Menampilkan judul aktivitas dan deskripsi/detail laporan kerja.
// ============================================================
class LogbookDetailContentCard extends StatelessWidget {
  final String judulAktivitas;
  final String deskripsiAktivitas;

  const LogbookDetailContentCard({
    super.key,
    required this.judulAktivitas,
    required this.deskripsiAktivitas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label "Aktivitas"
          const Text(
            'Aktivitas',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 1.43,
              letterSpacing: -0.17,
            ),
          ),
          
          const SizedBox(height: 10),

          // Judul Aktivitas
          Text(
            judulAktivitas,
            style: const TextStyle(
              color: Color(0xFF2B86C3),
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 1.43,
              letterSpacing: -0.17,
            ),
          ),

          const SizedBox(height: 12),

          // Divider
          Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xFFF6F7F7),
          ),

          const SizedBox(height: 12),

          // Deskripsi / Detail Pekerjaan
          Text(
            deskripsiAktivitas,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
