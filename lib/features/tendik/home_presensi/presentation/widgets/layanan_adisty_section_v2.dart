import 'package:flutter/material.dart';

// ============================================================
// KOMPONEN: SECTION LAYANAN ADISTY VERSI 2
// Layout vertikal, full-width
// ============================================================
class LayananAdistySectionV2 extends StatelessWidget {
  const LayananAdistySectionV2({super.key});

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
              children: const [
                // Card Tunjangan Beras
                LayananCardV2(
                  title: 'Tunjangan Beras',
                  description: 'Tinjau informasi pengambilan tunjangan beras ',
                  imagePath: 'assets/images/tunjangan_beras_2.png',
                ),

                // Card Layanan Cuti
                LayananCardV2(
                  title: 'Layanan Cuti',
                  description: 'Tinjau informasi cuti anda',
                  imagePath: 'assets/images/layanan_cuti_2.png',
                ),

                // Card Penilaian Kerja
                LayananCardV2(
                  title: 'Penilaian Kerja',
                  description: 'Tinjau penilaian kinerja anda',
                  imagePath: 'assets/images/penilaian_kinerja_2.png',
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
// Card 380x171 dengan Stack layout: teks kanan, gambar kiri,
// dan tombol Selengkapnya biru solid di kanan bawah
// ============================================================
class LayananCardV2 extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const LayananCardV2({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
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
    return Container(
      width: 380,
      height: 171,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: _cardShadows,
      ),
      child: Stack(
        children: [
          // Teks: judul & deskripsi (kanan atas)
          Positioned(
            left: 131,
            top: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
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
                SizedBox(
                  width: 200,
                  child: Text(
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
                ),
              ],
            ),
          ),

          // Tombol Selengkapnya (kanan bawah)
          Positioned(
            left: 233,
            top: 111,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

          // Gambar utama (kiri)
          Positioned(
            left: 20,
            top: 22,
            child: Container(
              width: 99,
              height: 95,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
