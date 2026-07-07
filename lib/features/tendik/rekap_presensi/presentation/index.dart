import 'package:flutter/material.dart';
import 'detail.dart';
import 'widgets/presensi_log_model.dart';
import 'widgets/statistik_tendik_card.dart';
import 'widgets/summary_mini_card.dart';
import 'widgets/info_disclaimer_banner.dart';
import 'widgets/rekap_log_item.dart';

// ============================================================
// HALAMAN UTAMA: REKAP PRESENSI LANDING
// ============================================================
class RekapPresensi extends StatefulWidget {
  const RekapPresensi({super.key});

  @override
  State<RekapPresensi> createState() => _RekapPresensiState();
}

class _RekapPresensiState extends State<RekapPresensi> {
  // Mock data untuk 7 hari log presensi
  final List<PresensiLog> logs = const [
    PresensiLog(
      date: 'Sabtu, 28 Oktober 2026',
      dayName: 'Sabtu',
      dayNum: '28',
      status: 'On time',
      badges: ['Koreksi'],
      location: 'Kampus 4',
      transport: '20.000',
      masuk: '06:45',
      pulang: '17:00',
      durasi: '7 Jam 15 Menit',
    ),
    PresensiLog(
      date: 'Jumat, 27 Oktober 2026',
      dayName: 'Jumat',
      dayNum: '27',
      status: 'On time',
      badges: ['Double Shift'],
      location: 'Kampus 4',
      transport: '40.000',
      masuk: '06:45',
      pulang: '21:00',
      durasi: '15 Jam 15 Menit',
    ),
    PresensiLog(
      date: 'Kamis, 26 Oktober 2026',
      dayName: 'Kamis',
      dayNum: '26',
      status: 'Terlambat',
      badges: [],
      location: 'Kampus 4',
      transport: '20.000',
      masuk: '07:30',
      pulang: '17:00',
      durasi: '6 Jam 30 Menit',
    ),
    PresensiLog(
      date: 'Rabu, 25 Oktober 2026',
      dayName: 'Rabu',
      dayNum: '25',
      status: 'On time',
      badges: [],
      location: 'Kampus 4',
      transport: '20.000',
      masuk: '06:45',
      pulang: '17:00',
      durasi: '7 Jam 15 Menit',
    ),
    PresensiLog(
      date: 'Selasa, 24 Oktober 2026',
      dayName: 'Selasa',
      dayNum: '24',
      status: 'On time',
      badges: [],
      location: 'Kampus 4',
      transport: '20.000',
      masuk: '06:45',
      pulang: '17:00',
      durasi: '7 Jam 15 Menit',
    ),
    PresensiLog(
      date: 'Senin, 23 Oktober 2026',
      dayName: 'Senin',
      dayNum: '23',
      status: 'On time',
      badges: [],
      location: 'Kampus 4',
      transport: '20.000',
      masuk: '06:45',
      pulang: '17:00',
      durasi: '7 Jam 15 Menit',
    ),
    PresensiLog(
      date: 'Sabtu, 21 Oktober 2026',
      dayName: 'Sabtu',
      dayNum: '21',
      status: 'On time',
      badges: [],
      location: 'Kampus 4',
      transport: '20.000',
      masuk: '06:45',
      pulang: '17:00',
      durasi: '7 Jam 15 Menit',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Rekap Presensi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 10),
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card Statistik Tendik
                      const StatistikTendikCard(),
                      const SizedBox(height: 14),

                      // Row mini summary
                      Row(
                        children: [
                          Expanded(
                            child: const SummaryMiniCard(
                              title: 'Transport',
                              value: '450.000',
                              unit: 'Rupiah',
                              iconBgColor: Color(0x142B86C3),
                              iconColor: Color(0xFF2B86C3),
                              icon: Icons.directions_car,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: const SummaryMiniCard(
                              title: 'Total jam',
                              value: '150:00',
                              unit: 'jam: menit',
                              iconBgColor: Color(0x142B86C3),
                              iconColor: Color(0xFF2B86C3),
                              icon: Icons.access_time_filled,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Section Header "Monitoring"
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B86C3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Monitoring',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // List rekap log presensi
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: logs.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final log = logs[index];
                          return RekapLogItem(
                            log: log,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RekapPresensiDetailPage(log: log),
                                ),
                              );
                            },
                          );
                        },
                      ),

                      // Info Disclaimer Banner
                      const InfoDisclaimerBanner(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
