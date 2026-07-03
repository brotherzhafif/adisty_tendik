import 'package:flutter/material.dart';

class LayananAdistySectionV1 extends StatelessWidget {
  const LayananAdistySectionV1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 17,
        children: [
          // Garis pemisah abu-abu
          Container(
            width: double.infinity,
            height: 8,
            decoration: const BoxDecoration(color: Color(0xFFEEF1F3)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 17,
              children: [
                // Judul Section
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Layanan Adisty',
                          style: TextStyle(
                            color: Color(0xFF293241),
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.34,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Grid Card Layanan
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Baris pertama: Tunjangan Beras + Layanan Cuti
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: LayananCard(
                              imagePath: 'assets/images/tunjangan_beras.png',
                              title: 'Tunjangan Beras',
                              description:
                                  'Tinjau informasi pengambilan tunjangan beras ',
                              descWidth: double.infinity,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: LayananCard(
                              imagePath: 'assets/images/layanan_cuti.png',
                              title: 'Layanan Cuti',
                              description:
                                  'Pengajuan dan Informasi Layanan Cuti',
                              descWidth: double.infinity,
                            ),
                          ),
                        ],
                      ),

                      // Baris kedua: Penilaian Kinerja
                      Row(
                        children: [
                          Expanded(
                            child: LayananCard(
                              imagePath: 'assets/images/penilaian_kinerja.png',
                              title: 'Penilaian Kerja',
                              description: 'Tinjau Penilaian Kinerja anda',
                              descWidth: double.infinity,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Spacer(),
                        ],
                      ),
                    ],
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

class LayananCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final double descWidth;

  const LayananCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.descWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x3DEBEBEB)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 11,
        children: [
          // Gambar layanan
          Container(
            width: 96,
            height: 71,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Judul & deskripsi
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 4,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF293241),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.43,
                    letterSpacing: -0.08,
                  ),
                ),
                SizedBox(
                  width: descWidth,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF5F6570),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tombol selengkapnya
          Container(
            width: 144,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: ShapeDecoration(
              color: const Color(0x1E2B86C3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Selengkapnya',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2B86C3),
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: Color(0xFF2B86C3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
