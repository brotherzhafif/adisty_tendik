import 'package:flutter/material.dart';
import 'widgets/tunjangan_page_header.dart';
import 'widgets/info_row.dart';
import 'widgets/scan_success_dialog.dart';

// ============================================================
// HALAMAN: TUNJANGAN BERAS - SCAN
// Menampilkan detail pengambilan beras untuk satu sesi:
// QR/barcode area di atas, lalu info Berat, Tanggal, Lokasi.
// ============================================================
class TunjanganBerasScan extends StatelessWidget {
  const TunjanganBerasScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Header biru ──
          TunjanganPageHeader(title: 'Tunjangan Beras'),

          // ── Area QR / Scan ──
          _buildScanArea(context),

          // ── Divider tipis pemisah ──
          Container(
            width: double.infinity,
            height: 8,
            color: const Color(0xFFF1F2F4),
          ),

          // ── Detail Info ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: const [
                  InfoRow(
                    iconBgColor: Color(0x1E2B86C3),
                    icon: Icons.scale_outlined,
                    iconColor: Color(0xFF2B86C3),
                    label: 'Berat',
                    value: '5 Kilo gram',
                  ),
                  InfoRow(
                    iconBgColor: Color(0x1E4AAF57),
                    icon: Icons.calendar_today_outlined,
                    iconColor: Color(0xFF4AAF57),
                    label: 'Tanggal',
                    value: 'Rab, 9 Sep 2023',
                  ),
                  InfoRow(
                    iconBgColor: Color(0x1EE65768),
                    icon: Icons.location_on_outlined,
                    iconColor: Color(0xFFE65768),
                    label: 'Lokasi',
                    value: 'Biro Sistem Informasi, gedung kedokteran lantai 7',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanArea(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.black.withOpacity(0.5),
          builder: (_) => const ScanSuccessDialog(),
        );
      },
      child: AspectRatio(
        aspectRatio: 1.05,
        child: Container(
          color: Colors.white,
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFD4D5D6), width: 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 120,
                  color: Color(0xFFD4D5D6),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
