import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Header Section Aktivitas Logbook
// Menampilkan label jumlah aktivitas di kiri dan tombol
// tambah aktivitas (+) di kanan.
// ============================================================
class LogbookSectionHeader extends StatelessWidget {
  final int jumlahAktivitas;
  final VoidCallback? onTambah;

  const LogbookSectionHeader({
    super.key,
    required this.jumlahAktivitas,
    this.onTambah,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // --- Label Jumlah Aktivitas ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Aktivitas (${jumlahAktivitas.toString().padLeft(2, '0')})',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 1.43,
              letterSpacing: -0.17,
            ),
          ),
        ),

        // --- Tombol Tambah (+) ---
        InkWell(
          onTap: onTambah,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: ShapeDecoration(
              color: const Color(0xFF2B86C3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded, color: Colors.white, size: 20),
                SizedBox(width: 4),
                Text(
                  'Tambah',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
