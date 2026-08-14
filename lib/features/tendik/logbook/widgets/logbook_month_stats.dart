import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Baris Statistik Bulan Logbook
// Menampilkan Total Skor, dan Dinilai Oleh secara
// horizontal — hanya muncul jika bulan tersebut memiliki data skor.
// ============================================================
class LogbookMonthStats extends StatelessWidget {
  final int totalSkor;
  final int jumlahAktivitas;
  final String? dinilaiOlehNama;
  final String? dinilaiOlehPosisi;

  const LogbookMonthStats({
    super.key,
    required this.totalSkor,
    required this.jumlahAktivitas,
    this.dinilaiOlehNama,
    this.dinilaiOlehPosisi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const ShapeDecoration(shape: RoundedRectangleBorder()),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // KOTAK KIRI: Total Skor
            Expanded(
              flex: 45,
              child: Container(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Total Skor',
                            style: TextStyle(
                              color: Color(0xFF8E8E8E),
                              fontSize: 10,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              height: 1.60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              '$totalSkor',
                              style: const TextStyle(
                                color: Color(0xFF2B86C3),
                                fontSize: 22,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                                letterSpacing: -0.34,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      child: Text.rich(
                        textAlign: TextAlign.start,
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Diperoleh dari ',
                              style: TextStyle(
                                color: Color(0xFF8E8E8E),
                                fontSize: 10,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                                height: 1.60,
                              ),
                            ),
                            TextSpan(
                              text: '$jumlahAktivitas',
                              style: const TextStyle(
                                color: Color(0xFF2B86C3),
                                fontSize: 10,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                                height: 1.60,
                              ),
                            ),
                            const TextSpan(
                              text: ' Aktivitas',
                              style: TextStyle(
                                color: Color(0xFF8E8E8E),
                                fontSize: 10,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                                height: 1.60,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // KOTAK KANAN: Dinilai Oleh
            Expanded(
              flex: 55,
              child: Container(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Dinilai Oleh',
                            style: TextStyle(
                              color: Color(0xFF8E8E8E),
                              fontSize: 10,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              height: 1.60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.account_circle,
                                color: Color(0xFFCCCED1),
                                size: 32,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  dinilaiOlehNama ?? '-',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFF2B86C3),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w500,
                                    height: 1.33,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dinilaiOlehPosisi ?? 'Pejabat penilaian',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF8E8E8E),
                              fontSize: 10,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              height: 1.60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
