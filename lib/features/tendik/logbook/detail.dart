import 'package:flutter/material.dart';
import 'widgets/logbook_app_bar.dart';
import 'widgets/logbook_detail_header_card.dart';
import 'widgets/logbook_detail_content_card.dart';
import 'widgets/logbook_activity_item.dart';

// ============================================================
// HALAMAN: Detail Logbook Page
// Menampilkan detail tanggal, waktu dibuat, status,
// judul aktivitas, serta deskripsi lengkap dari logbook.
// ============================================================
class LogbookDetailPage extends StatelessWidget {
  final LogbookActivityData activity;

  const LogbookDetailPage({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    // Formatting a pretty date name
    final String tanggalLengkap = '${_getDayFullName(activity.hariNama)}, ${activity.tanggal} ${_capitalize(activity.bulan)} 2026';
    final String waktuDibuat = 'Dibuat pada ${activity.tanggal} ${_capitalize(activity.bulan)} 2026, 10:25 WIB';

    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      body: Column(
        children: [
          // --- AppBar Detail ---
          LogbookAppBar(
            title: 'Detail Logbook',
            onBack: () => Navigator.of(context).maybePop(),
          ),

          // --- Konten Utama ---
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const ShapeDecoration(
                color: Color(0xFFF6F7F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(34),
                    topRight: Radius.circular(34),
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      // --- Kartu Info Header ---
                      LogbookDetailHeaderCard(
                        tanggalLengkap: tanggalLengkap,
                        waktuDibuat: waktuDibuat,
                        status: 'Tersimpan',
                      ),

                      const SizedBox(height: 16),

                      // --- Kartu Detail Isi Laporan ---
                      LogbookDetailContentCard(
                        judulAktivitas: activity.judul,
                        deskripsiAktivitas: activity.deskripsi,
                      ),

                      const SizedBox(height: 24),

                      // --- Tombol Aksi di Bawah ---
                      _ActionButtonRow(
                        onHapus: () {
                          // TODO: Implement delete logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Fungsi Hapus belum diimplementasi')),
                          );
                        },
                        onEdit: () {
                          // TODO: Implement edit logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Fungsi Edit belum diimplementasi')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper to format day name if needed ---
  String _getDayFullName(String shortDay) {
    switch (shortDay.toLowerCase()) {
      case 'senin':
        return 'Senin';
      case 'selasa':
        return 'Selasa';
      case 'rabu':
        return 'Rabu';
      case 'kamis':
        return 'Kamis';
      case 'jumat':
        return 'Jumat';
      case 'sabtu':
        return 'Sabtu';
      case 'minggu':
        return 'Minggu';
      default:
        return shortDay;
    }
  }

  // --- Helper capitalization ---
  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}

// ============================================================
// KOMPONEN PRIVAT: Row tombol Hapus & Edit
// ============================================================
class _ActionButtonRow extends StatelessWidget {
  final VoidCallback onHapus;
  final VoidCallback onEdit;

  const _ActionButtonRow({
    required this.onHapus,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // --- Tombol Hapus ---
        Expanded(
          child: OutlinedButton(
            onPressed: onHapus,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFF2B86C3), width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Hapus',
              style: TextStyle(
                color: Color(0xFF2B86C3),
                fontSize: 14,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        // --- Tombol Edit ---
        Expanded(
          child: ElevatedButton(
            onPressed: onEdit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2B86C3),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_rounded, size: 16),
                SizedBox(width: 6),
                Text(
                  'Edit Logbook',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Open Sans',
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