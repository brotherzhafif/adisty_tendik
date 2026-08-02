import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Header Section Aktivitas Logbook
// Menampilkan label jumlah aktivitas di kiri dan tombol
// tambah aktivitas (+) di kanan.
// ============================================================
class LogbookSectionHeader extends StatelessWidget {
  final int jumlahAktivitas;
  final VoidCallback? onTambah;
  final bool showTambah;

  const LogbookSectionHeader({
    super.key,
    required this.jumlahAktivitas,
    this.onTambah,
    this.showTambah = true,
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
            ),
          ),
        ),

        // --- Tombol Tambah (+) Pill Style ---
        if (showTambah)
          InkWell(
            onTap: onTambah,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: ShapeDecoration(
                color: const Color(0xFF2B86C3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Tambah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                      letterSpacing: -0.08,
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
