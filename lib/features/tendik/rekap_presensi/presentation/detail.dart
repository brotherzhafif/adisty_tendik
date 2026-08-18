import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';
import 'koreksi_form.dart';
import 'koreksi_list.dart';
import 'widgets/lokasi_presensi_card.dart';
import 'widgets/presensi_log_model.dart';
import 'widgets/detail_info_row.dart';
import 'widgets/info_disclaimer_banner.dart';
import 'widgets/shift_block.dart';

// ============================================================
// HALAMAN DETAIL: REKAP PRESENSI DETAIL
// Mendukung single shift & double shift
// ============================================================
class RekapPresensiDetailPage extends StatelessWidget {
  final PresensiLog log;

  const RekapPresensiDetailPage({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color statusBgColor;
    switch (log.status.toLowerCase()) {
      case 'on time':
        statusColor = const Color(0xFF4AAF57);
        statusBgColor = const Color(0x1E18C079);
        break;
      case 'terlambat':
        statusColor = const Color(0xFFFFAC2F);
        statusBgColor = const Color(0x1EFFAC2F);
        break;
      default:
        statusColor = const Color(0xFFE65768);
        statusBgColor = const Color(0x1EE65768);
        break;
    }

    final bool isDoubleShift = log.badges.any(
      (b) => b.toLowerCase().contains('double shift'),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      body: Column(
        children: [
          // --- Header Biru (AppBar Statis) ---
          Container(
            width: double.infinity,
            color: const Color(0xFF2B86C3),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).maybePop(),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Detail Presensi',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.headingXl,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
            ),
          ),

          // --- Konten Utama (Rounded Top Container) ---
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── 1. Header Card: Tanggal + Status + Badges ──
                      Container(
                        width: double.infinity,
                        height: 72,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19,
                          vertical: 8,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: ShapeDecoration(
                                color: const Color(0x1E0067AD),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                color: Color(0xFF0067AD),
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    log.date,
                                    style: const TextStyle(
                                      color: Color(0xFF293241),
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.27,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: statusBgColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          log.status,
                                          style: TextStyle(
                                            color: statusColor,
                                            fontSize: 12,
                                            fontFamily: 'Nunito Sans',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.18,
                                          ),
                                        ),
                                      ),
                                      if (isDoubleShift)
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFE8F1F9),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          child: const Text(
                                            'Double Shift',
                                            style: TextStyle(
                                              color: Color(0xFF016EB8),
                                              fontSize: 12,
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.18,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // ── 2. Card: Informasi Presensi ──
                      _buildCard(
                        title: 'Informasi Presensi',
                        children: [
                          DetailInfoRow(
                            icon: Icons.location_on_outlined,
                            iconBgColor: const Color(0x1EE65768),
                            iconColor: const Color(0xFFE65768),
                            label: 'Lokasi',
                            value: log.location,
                          ),
                          if (isDoubleShift) ...[
                            const Divider(height: 24, color: Color(0xFFEEF2F3)),
                            const DetailInfoRow(
                              icon: Icons.schedule,
                              iconBgColor: Color(0x1E2B86C3),
                              iconColor: Color(0xFF2B86C3),
                              label: 'Shift Hari Ini',
                              value: 'Double Shift',
                            ),
                          ],
                          const Divider(height: 24, color: Color(0xFFEEF2F3)),
                          DetailInfoRow(
                            icon: Icons.directions_car_outlined,
                            iconBgColor: const Color(0x1E2B86C3),
                            iconColor: const Color(0xFF2B86C3),
                            label: 'Transport',
                            value: 'Rp ${log.transport}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // ── 3. Card: Detail Presensi / Detail Shift ──
                      _buildCard(
                        title: isDoubleShift
                            ? 'Detail Shift'
                            : 'Detail Presensi',
                        children: [
                          if (!isDoubleShift) ...[
                            ShiftBlock(
                              shiftName: 'Tepat Waktu',
                              tagBgColor: const Color(0x194AAF57),
                              tagTextColor: const Color(0xF54AAF57),
                              masuk: log.masuk,
                              pulang: log.pulang,
                              durasi: log.durasi,
                            ),
                          ] else ...[
                            ShiftBlock(
                              shiftName: 'Shift 1',
                              masuk: log.masuk,
                              pulang: '14:00',
                              durasi: '7 Jam 15 Menit',
                            ),
                            const Divider(height: 24, color: Color(0xFFEEF2F3)),
                            ShiftBlock(
                              shiftName: 'Shift 2',
                              masuk: '14:00',
                              pulang: log.pulang,
                              durasi: '8 Jam 00 Menit',
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 14),

                      // ── 4. Card: Total Durasi Kerja (Blue Box Container) ──
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE8F1F9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Durasi Kerja',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.17,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              log.durasi,
                              style: const TextStyle(
                                color: Color(0xFF0067AD),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.34,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Sudah termasuk istirahat',
                              style: TextStyle(
                                color: Color(0xFF7A8089),
                                fontSize: 12,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // ── 5. Card: Lokasi Presensi (Interactive Map) ──
                      LokasiPresensiCard(
                        namaLokasi: log.location.isNotEmpty
                            ? log.location
                            : 'Kampus 4 - Universitas Ahmad Dahlan',
                        latitude: log.latitude,
                        longitude: log.longitude,
                      ),
                      const SizedBox(height: 14),

                      // ── 6. Disclaimer Koreksi ──
                      const InfoDisclaimerBanner(
                        message:
                            'Jika terdapat kesalahan pada data presensi, Anda dapat mengajukan koreksi presensi maksimal 3 hari setelah tanggal presensi.',
                      ),
                      const SizedBox(height: 20),

                      // ── 7. Tombol Aksi ──
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FormKoreksiPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B86C3),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Ajukan Koreksi Presensi',
                          style: AppTextStyle.headingLg.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RiwayatKoreksiPage(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1.5,
                                color: Color(0xFF0067AD),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Lihat Riwayat Pengajuan',
                              style: TextStyle(
                                color: Color(0xFF0067AD),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 1.50,
                                letterSpacing: -0.18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
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

  /// Helper untuk membuat card section dengan judul dan list children.
  Widget _buildCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 1.50,
              letterSpacing: -0.27,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
