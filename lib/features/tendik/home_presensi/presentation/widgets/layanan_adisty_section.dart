import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/features/tendik/rekap_presensi/presentation/index.dart';

// ============================================================
// KOMPONEN: SECTION LAYANAN ADISTY
// Layout vertikal, full-width
// ============================================================
class LayananAdistySection extends StatelessWidget {
  const LayananAdistySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          // Garis pemisah abu-abu
          Container(
            width: double.infinity,
            height: 8,
            decoration: const BoxDecoration(color: Color(0xFFEEF1F3)),
          ),

          // Judul Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
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

          // Daftar Card Layanan (vertikal, full-width)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                // Card Agenda → navigasi ke Rekap Presensi
                LayananCard(
                  title: 'Agenda',
                  description: 'Tinjau informasi agenda anda',
                  imagePath: 'assets/images/(layanan)_agenda.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RekapPresensi(),
                      ),
                    );
                  },
                ),

                // Card Logbook
                const LayananCard(
                  title: 'Logbook',
                  description: 'Tinjau informasi Logbook anda',
                  imagePath: 'assets/images/(layanan)_logbook.png',
                ),

                // Card SKP Pegawai
                const LayananCard(
                  title: 'SKP Pegawai',
                  description: 'Tinjau penilaian kinerja anda',
                  imagePath: 'assets/images/(layanan)_skp_pegawai.png',
                ),

                // Card Tunjangan Beras
                const LayananCard(
                  title: 'Tunjangan Beras',
                  description: 'Tinjau informasi pengambilan tunjangan beras',
                  imagePath: 'assets/images/(layanan_tunjangan_beras.png',
                ),
              ],
            ),
          ),

          // Padding bawah
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ============================================================
// KOMPONEN: CARD LAYANAN HORIZONTAL (reusable)
// Card full-width dengan gambar kiri, teks & tombol kanan.
// ============================================================
class LayananCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback? onTap;

  const LayananCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    this.onTap,
  });

  // Daftar shadow yang konsisten untuk semua card
  static const List<BoxShadow> _cardShadows = [
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
    BoxShadow(
      color: Color(0x127281DF),
      blurRadius: 17.75,
      offset: Offset(0, 8.10),
    ),
    BoxShadow(
      color: Color(0x157281DF),
      blurRadius: 42.88,
      offset: Offset(0, 15.25),
    ),
    BoxShadow(color: Color(0x1E7281DF), blurRadius: 210, offset: Offset(0, 33)),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: _cardShadows,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama (kiri)
            Container(
              width: 99,
              height: 95,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Teks: judul, deskripsi & tombol (kanan)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF293241),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF5F6570),
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: -0.17,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2B86C3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Selengkapnya',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                            letterSpacing: -0.08,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
