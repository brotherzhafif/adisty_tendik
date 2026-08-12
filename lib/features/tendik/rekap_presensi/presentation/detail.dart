import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';
import 'package:adisty_tendik_module/features/tendik/presensi_hari_ini/presentation/form.dart';
import 'widgets/lokasi_presensi_card.dart';
import 'widgets/presensi_log_model.dart';
import 'widgets/detail_info_row.dart';
import 'widgets/info_disclaimer_banner.dart';
import 'widgets/shift_block.dart';

// ============================================================
// HALAMAN DETAIL: REKAP PRESENSI DETAIL
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

    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      body: Column(
        children: [
          // --- Header Biru (AppBar Statis Menyatu dengan Blue Background) ---
          Container(
            width: double.infinity,
            color: const Color(0xFF2B86C3),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

          // --- Konten Utama (Rounded Top Container + ClipRRect) ---
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
                      // ── Header: Tanggal + Status + Badges ──
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19,
                          vertical: 16,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    log.date,
                                    style: const TextStyle(
                                      color: Color(0xFF293241),
                                      fontSize: 16,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
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
                                          style: AppTextStyle.bodySm.copyWith(
                                            color: statusColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      if (log.badges.isNotEmpty)
                                        ...log.badges.map(
                                          (badge) => Container(
                                            margin: const EdgeInsets.only(
                                              left: 8,
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
                                            child: Text(
                                              badge,
                                              style: const TextStyle(
                                                color: Color(0xFF016EB8),
                                                fontSize: 12,
                                                fontFamily: 'Nunito Sans',
                                                fontWeight: FontWeight.w700,
                                              ),
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

                      // ── Card: Informasi Presensi ──
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
                          const Divider(height: 24, color: Color(0xFFEEF2F3)),
                          DetailInfoRow(
                            icon: Icons.schedule,
                            iconBgColor: const Color(0x1E2B86C3),
                            iconColor: const Color(0xFF2B86C3),
                            label: 'Shift Hari Ini',
                            value: log.badges.contains('Double Shift')
                                ? 'Double Shift'
                                : 'Shift 1',
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // ── Card: Lokasi Presensi (Interactive Map) ──
                      LokasiPresensiCard(
                        namaLokasi: log.location.isNotEmpty
                            ? log.location
                            : 'Kampus 4 - Universitas Ahmad Dahlan',
                        latitude: log.latitude,
                        longitude: log.longitude,
                      ),
                      const SizedBox(height: 14),

                      // ── Card: Detail Shift ──
                      _buildCard(
                        title: 'Detail Shift',
                        children: [
                          ShiftBlock(
                            shiftName: 'Shift 1',
                            masuk: log.masuk,
                            pulang: log.badges.contains('Double Shift')
                                ? '14:00'
                                : log.pulang,
                            durasi: log.badges.contains('Double Shift')
                                ? '7 Jam 15 Menit'
                                : log.durasi,
                          ),
                          if (log.badges.contains('Double Shift')) ...[
                            const Divider(height: 32, color: Color(0xFFEEF2F3)),
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

                      // ── Card: Total Durasi Kerja ──
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
                            Text(
                              'Total Durasi Kerja',
                              style: AppTextStyle.bodyMd.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              log.durasi,
                              style: const TextStyle(
                                color: Color(0xFF0067AD),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
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

                      // ── Card: Informasi Lainnya ──
                      _buildCard(
                        title: 'Informasi Lainnya',
                        children: [
                          DetailInfoRow(
                            icon: Icons.directions_car_outlined,
                            iconBgColor: const Color(0x1E2B86C3),
                            iconColor: const Color(0xFF2B86C3),
                            label: 'Transport',
                            value: 'Rp ${log.transport}',
                          ),
                          const Divider(height: 24, color: Color(0xFFEEF2F3)),
                          DetailInfoRow(
                            icon: Icons.sticky_note_2_outlined,
                            iconBgColor: const Color(0x1E2B86C3),
                            iconColor: const Color(0xFF2B86C3),
                            label: 'Catatan',
                            value: log.catatan,
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // ── Disclaimer Koreksi ──
                      const InfoDisclaimerBanner(
                        message:
                            'Jika terdapat kesalahan pada data presensi, Anda dapat mengajukan koreksi presensi maksimal 3 hari setelah tanggal presensi.',
                      ),
                      const SizedBox(height: 20),

                      // ── Tombol Koreksi ──
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
            color: Color(0x0F7281DF),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.bodyLg.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
