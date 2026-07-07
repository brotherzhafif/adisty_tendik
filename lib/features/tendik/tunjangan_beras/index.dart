import 'package:flutter/material.dart';
import 'scan.dart';
import 'widgets/tunjangan_page_header.dart';
import 'widgets/riwayat_beras_item.dart';

// ============================================================
// HALAMAN: TUNJANGAN BERAS (INDEX)
// Menampilkan riwayat pengambilan beras oleh tendik.
// 3 item pertama = sudah diambil (aktif), sisa = belum tersedia (disabled).
// ============================================================
class TunjanganBeras extends StatelessWidget {
  const TunjanganBeras({super.key});

  // Data dummy riwayat beras
  static const List<Map<String, String>> _riwayatAktif = [
    {
      'tanggal': '15 Juni 2023',
      'lokasi': 'Biro Sistem Informasi, gedung kedokteran lantai 7',
      'berat': '5 kg',
    },
    {
      'tanggal': '15 Juni 2023',
      'lokasi': 'Biro Sistem Informasi, gedung kedokteran lantai 7',
      'berat': '5 kg',
    },
    {
      'tanggal': '15 Juni 2023',
      'lokasi': 'Biro Sistem Informasi, gedung kedokteran lantai 7',
      'berat': '5 kg',
    },
  ];

  static const List<Map<String, String>> _riwayatDisabled = [
    {
      'tanggal': '15 Juni 2023',
      'lokasi': 'Biro Sistem Informasi, gedung kedokteran lantai 7',
      'berat': '5 kg',
    },
    {
      'tanggal': '15 Juni 2023',
      'lokasi': 'Biro Sistem Informasi, gedung kedokteran lantai 7',
      'berat': '5 kg',
    },
    {
      'tanggal': '15 Juni 2023',
      'lokasi': 'Biro Sistem Informasi, gedung kedokteran lantai 7',
      'berat': '5 kg',
    },
    {
      'tanggal': '15 Juni 2023',
      'lokasi': 'Biro Sistem Informasi, gedung kedokteran lantai 7',
      'berat': '5 kg',
    },
    {
      'tanggal': '15 Juni 2023',
      'lokasi': 'Biro Sistem Informasi, gedung kedokteran lantai 7',
      'berat': '5 kg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: Column(
        children: [
          // ── Header biru ──
          TunjanganPageHeader(title: 'Tunjangan Beras'),

          // ── Konten daftar riwayat ──
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                // Item aktif
                ..._riwayatAktif.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RiwayatBerasItem(
                      tanggal: item['tanggal']!,
                      lokasi: item['lokasi']!,
                      beratKg: item['berat']!,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TunjanganBerasScan(),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Item disabled
                ..._riwayatDisabled.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RiwayatBerasItem(
                      tanggal: item['tanggal']!,
                      lokasi: item['lokasi']!,
                      beratKg: item['berat']!,
                      isDisabled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
