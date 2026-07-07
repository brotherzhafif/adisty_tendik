import 'package:flutter/material.dart';

class AjukanKoreksiCard extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onRiwayatTap;

  const AjukanKoreksiCard({super.key, required this.onTap, this.onRiwayatTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x3DEBEBEB)),
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0xA3A5A5A5),
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 4,
              left: 9,
              right: 9,
              bottom: 15,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(6),
                        child: Text(
                          'Terdapat kesalahan data presensi?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            height: 1.43,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          'Jika ada kesalahan pada jam masuk/keluar atau data lainnya, ajukan koreksi sekarang.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                            letterSpacing: -0.17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 64,
                  height: 78,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      // Menggunakan placeholder jika gambar aslinya belum ada
                      image: NetworkImage("https://placehold.co/64x78"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 344,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: const Color(0xFF0067AD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(
                child: Text(
                  'Ajukan Koreksi Presensi',
                  style: TextStyle(
                    color: Colors.white,
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
          if (onRiwayatTap != null) ...[
            const SizedBox(height: 12),
            InkWell(
              onTap: onRiwayatTap,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 344,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF0067AD)),
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
          ],
        ],
      ),
    );
  }
}
