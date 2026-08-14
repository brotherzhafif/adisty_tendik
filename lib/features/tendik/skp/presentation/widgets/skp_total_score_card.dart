import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Card Total Skor SKP
// Menampilkan ringkasan Total Skor SKP Pegawai dan Dinilai Oleh
// ============================================================
class SkpTotalScoreCard extends StatelessWidget {
  final double score;
  final int jumlahKategori;
  final String? dinilaiOlehNama;
  final String? dinilaiOlehPosisi;

  const SkpTotalScoreCard({
    super.key,
    required this.score,
    required this.jumlahKategori,
    this.dinilaiOlehNama,
    this.dinilaiOlehPosisi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // KOTAK KIRI: Total Skor SKP
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
                            'Total Skor SKP',
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
                              score.toStringAsFixed(2),
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
                              text: '$jumlahKategori',
                              style: const TextStyle(
                                color: Color(0xFF2B86C3),
                                fontSize: 10,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w500,
                                height: 1.60,
                              ),
                            ),
                            const TextSpan(
                              text: ' Kategori',
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
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_circle,
                            color: Color(0xFFCCCED1),
                            size: 32,
                          ),
                          const SizedBox(width: 8, height: 0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
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
                                Text(
                                  dinilaiOlehPosisi ?? 'Pejabat penilaian',
                                  maxLines: 1,
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
