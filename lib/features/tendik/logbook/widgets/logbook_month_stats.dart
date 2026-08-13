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
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFFAFAFA)),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KOTAK KIRI: Total Skor
          Expanded(
            child: Container(
              height: 73,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFFAFAFA)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
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
                              fontSize: 20,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text.rich(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // KOTAK KANAN: Dinilai Oleh
          Expanded(
            child: Container(
              height: 73,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFFAFAFA)),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
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
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Space placeholder for avatar if needed
                        // Container(width: 29, height: 29, child: Stack()),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${dinilaiOlehNama ?? '-'}\n',
                                  style: const TextStyle(
                                    color: Color(0xFF2B86C3),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w500,
                                    height: 1.33,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      dinilaiOlehPosisi ?? 'Pejabat penilaian',
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
    );
  }
}
