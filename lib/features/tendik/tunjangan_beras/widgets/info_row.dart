import 'package:flutter/material.dart';

// ============================================================
// WIDGET: INFO ROW
// Satu baris info dengan ikon bulat berwarna, label, dan nilai.
// Dipakai di halaman scan untuk menampilkan Berat, Tanggal, Lokasi.
// ============================================================
class InfoRow extends StatelessWidget {
  final Color iconBgColor;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.iconBgColor,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        // Ikon bulat
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),

        // Label & Nilai
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF5F6570),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                  letterSpacing: -0.08,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF293241),
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  height: 1.50,
                  letterSpacing: -0.27,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
