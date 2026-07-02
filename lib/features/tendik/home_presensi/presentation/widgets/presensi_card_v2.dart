import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'presensi_state.dart';

class PresensiCardV2 extends StatelessWidget {
  final PresensiState state;

  const PresensiCardV2({super.key, this.state = PresensiState.belumPresensi});

  @override
  Widget build(BuildContext context) {
    // --- Variabel berdasarkan state ---
    String leftLabel;
    String leftJam;
    Color leftLabelColor = const Color(0xFF18C079);

    String rightLabel;
    String rightJam;
    Color rightLabelColor;

    bool showTransport;

    switch (state) {
      case PresensiState.belumPresensi:
        leftLabel = 'Masuk';
        leftJam = '06:45 - 14.00';
        rightLabel = 'Pulang';
        rightLabelColor = const Color(0xFF5F6570);
        rightJam = '--.--';
        showTransport = false;
        break;

      case PresensiState.shift1Selesai:
        leftLabel = 'Shift 1 (Selesai)';
        leftJam = '06:45 - 14.00';
        rightLabel = 'Shift 2 (Berikutnya)';
        rightLabelColor = const Color(0xFF0067AD);
        rightJam = '14.00 - 19.00';
        showTransport = false;
        break;

      case PresensiState.pulang:
        leftLabel = 'Masuk';
        leftJam = '06:45';
        rightLabel = 'Pulang';
        rightLabelColor = const Color(0xFFFFAC2F);
        rightJam = '14.00';
        showTransport = true;
        break;
    }

    return Container(
      width: 378,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(0xFF2B86C3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Header: label & tanggal
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 40,
            children: [
              Container(
                width: 139,
                padding: const EdgeInsets.only(right: 10, bottom: 6),
                child: const Opacity(
                  opacity: 0.96,
                  child: Text(
                    'Presensi Hari ini',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.43,
                      letterSpacing: -0.08,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 6),
                child: const Opacity(
                  opacity: 0.96,
                  child: Text(
                    'Selasa, 30 Desember 2025',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Body: kotak masuk & pulang berdampingan
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 13,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  // Kotak Masuk (kiri)
                  PresensiBox(
                    label: leftLabel,
                    labelColor: leftLabelColor,
                    jam: leftJam,
                    iconPath: 'assets/icons/(home_page)_masuk-icon.svg',
                  ),

                  // Separator lingkaran biru
                  Container(
                    width: 23,
                    height: 23,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2B86C3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48),
                      ),
                    ),
                    child: const Stack(),
                  ),

                  // Kotak Pulang (kanan)
                  PresensiBox(
                    label: rightLabel,
                    labelColor: rightLabelColor,
                    jam: rightJam,
                    iconPath: 'assets/icons/(home_page)_keluar-icon.svg',
                  ),
                ],
              ),
            ],
          ),

          // Lokasi & Transportasi
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LokasiTransportasiRowV2(),
              if (showTransport) const TransportasiRowV2(),
            ],
          ),
        ],
      ),
    );
  }
}

class PresensiBox extends StatelessWidget {
  final String label;
  final Color labelColor;
  final String jam;
  final String iconPath;

  const PresensiBox({
    super.key,
    required this.label,
    required this.labelColor,
    required this.jam,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label (Masuk / Pulang / Shift)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12,
              children: [
                Icon(Icons.check_circle, size: 20, color: labelColor),
                Expanded(
                  child: Opacity(
                    opacity: 0.96,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: labelColor,
                        fontSize: 12,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500,
                        height: 1.33,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Jam
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 4, left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 10,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(labelColor, BlendMode.srcIn),
                ),
                Text(
                  jam,
                  style: const TextStyle(
                    color: Color(0xFF293241),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                    letterSpacing: -0.18,
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

class LokasiTransportasiRowV2 extends StatelessWidget {
  const LokasiTransportasiRowV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Container(
            width: double.infinity,
            height: 26,
            child: Container(
              width: 342,
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 2,
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.white),
                  Opacity(
                    opacity: 0.96,
                    child: const Text(
                      'Kampus 4 - Gedung Kedokteran',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
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

class TransportasiRowV2 extends StatelessWidget {
  const TransportasiRowV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFFB7F54)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 34,
        children: [
          Opacity(
            opacity: 0.80,
            child: Container(
              width: 194,
              padding: const EdgeInsets.only(top: 4, left: 11, right: 46, bottom: 4),
              child: const Opacity(
                opacity: 0.96,
                child: Text(
                  'Transportasi Hari Ini',
                  style: TextStyle(
                    color: Color(0xFF303B4C),
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 93,
            height: 24,
            padding: const EdgeInsets.only(right: 10, bottom: 4),
            child: const Opacity(
              opacity: 0.96,
              child: Text(
                'Rp20.000',
                style: TextStyle(
                  color: Color(0xFFFB7F54),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.50,
                  letterSpacing: -0.18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
