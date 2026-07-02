import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'presensi_state.dart';

class PresensiCardV1 extends StatelessWidget {
  final PresensiState state;

  const PresensiCardV1({super.key, this.state = PresensiState.belumPresensi});

  @override
  Widget build(BuildContext context) {
    // --- Variabel berdasarkan state ---
    String masukLabel;
    String masukJam;
    String masukBadgeText;
    Color masukBadgeBg;
    Color masukBadgeTextColor;
    Color masukIconColor;

    String pulangLabel;
    String pulangJam;
    String pulangBadgeText;
    Color pulangBadgeBg;
    Color pulangBadgeTextColor;
    Color pulangIconColor;

    bool showTransport;

    switch (state) {
      case PresensiState.belumPresensi:
        masukLabel = 'Masuk';
        masukJam = '06:45';
        masukBadgeText = 'Terkonfirmasi';
        masukBadgeBg = const Color(0x1E4AAF57);
        masukBadgeTextColor = const Color(0xFF18C079);
        masukIconColor = const Color(0xFF18C079);

        pulangLabel = 'Pulang';
        pulangJam = '--:--';
        pulangBadgeText = 'Belum presensi';
        pulangBadgeBg = const Color(0xFFF0F1F2);
        pulangBadgeTextColor = const Color(0xFF5F6570);
        pulangIconColor = const Color(0xFF5F6570);

        showTransport = false;
        break;

      case PresensiState.shift1Selesai:
        masukLabel = 'Shift 1 (Selesai)';
        masukJam = '06:45 - 14:00';
        masukBadgeText = 'Terkonfirmasi';
        masukBadgeBg = const Color(0x1E4AAF57);
        masukBadgeTextColor = const Color(0xFF18C079);
        masukIconColor = const Color(0xFF18C079);

        pulangLabel = 'Shift 2 (Berikutnya)';
        pulangJam = '14:00 - 20.00';
        pulangBadgeText = 'Belum presensi';
        pulangBadgeBg = const Color(0xFFF0F1F2);
        pulangBadgeTextColor = const Color(0xFF5F6570);
        pulangIconColor = const Color(0xFF5F6570);

        showTransport = false;
        break;

      case PresensiState.pulang:
        masukLabel = 'Masuk';
        masukJam = '06:45';
        masukBadgeText = 'Terkonfirmasi';
        masukBadgeBg = const Color(0x1E4AAF57);
        masukBadgeTextColor = const Color(0xFF18C079);
        masukIconColor = const Color(0xFF18C079);

        pulangLabel = 'Pulang';
        pulangJam = '16:00';
        pulangBadgeText = 'Terkonfirmasi';
        pulangBadgeBg = const Color(0x1EFFAC2F);
        pulangBadgeTextColor = const Color(0xFFFFAC2F);
        pulangIconColor = const Color(0xFFFFAC2F);

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
                padding: const EdgeInsets.all(10),
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
                padding: const EdgeInsets.all(10),
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

          // Body
          SizedBox(
            width: 345,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 11,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 14,
                    children: [
                      // Baris Masuk
                      PresensiRow(
                        iconColor: masukIconColor,
                        label: masukLabel,
                        labelColor: const Color(0xFF18C079),
                        jam: masukJam,
                        statusText: masukBadgeText,
                        statusColor: masukBadgeTextColor,
                        statusBgColor: masukBadgeBg,
                        exitIconColor: masukIconColor,
                        exitBgColor: masukBadgeBg,
                        actionIconPath: 'assets/icons/(home_page)_masuk-icon.svg',
                      ),

                      // Baris Pulang
                      PresensiRow(
                        iconColor: pulangIconColor,
                        label: pulangLabel,
                        labelColor: const Color(0xFF293241),
                        jam: pulangJam,
                        statusText: pulangBadgeText,
                        statusColor: pulangBadgeTextColor,
                        statusBgColor: pulangBadgeBg,
                        exitIconColor: pulangIconColor,
                        exitBgColor: pulangBadgeBg,
                        actionIconPath: 'assets/icons/(home_page)_keluar-icon.svg',
                      ),
                    ],
                  ),
                ),

                // Baris Transportasi Hari Ini (conditional)
                if (showTransport) const TransportasiRow(),

                // Baris Lokasi Kampus
                const LokasiRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PresensiRow extends StatelessWidget {
  final Color iconColor;
  final String label;
  final Color labelColor;
  final String jam;
  final String statusText;
  final Color statusColor;
  final Color statusBgColor;
  final Color exitIconColor;
  final Color exitBgColor;
  final String actionIconPath;

  const PresensiRow({
    super.key,
    required this.iconColor,
    required this.label,
    required this.labelColor,
    required this.jam,
    required this.statusText,
    required this.statusColor,
    required this.statusBgColor,
    required this.exitIconColor,
    required this.exitBgColor,
    required this.actionIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 5),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 60,
        children: [
          // Kiri: ikon check + label + jam + status
          Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Ikon check circle
                Container(
                  width: 33,
                  height: 33,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Icon(Icons.check_circle, size: 33, color: iconColor),
                ),

                // Teks: label, jam, status
                Container(
                  width: 194,
                  padding: const EdgeInsets.only(
                    left: 11,
                    right: 46,
                    bottom: 8,
                  ),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label (Masuk / Pulang / Shift)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 4, right: 10),
                        child: Opacity(
                          opacity: 0.96,
                          child: Text(
                            label,
                            style: TextStyle(
                              color: labelColor,
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              height: 1.33,
                            ),
                          ),
                        ),
                      ),

                      // Jam
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(right: 10, bottom: 4),
                        child: Text(
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
                      ),

                      // Badge status
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: ShapeDecoration(
                          color: statusBgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: Opacity(
                          opacity: 0.96,
                          child: Text(
                            statusText,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                              height: 1.50,
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

          // Kanan: tombol exit/logout
          Container(
            width: 33,
            height: 33,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: exitBgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              actionIconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(exitIconColor, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}

class TransportasiRow extends StatelessWidget {
  const TransportasiRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, left: 15, right: 10, bottom: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFFB7F54)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Opacity(
                opacity: 0.96,
                child: const Text(
                  'Transportasi Hari Ini',
                  style: TextStyle(
                    color: Color(0xFF293241),
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 1.33,
                  ),
                ),
              ),
              Opacity(
                opacity: 0.96,
                child: const Text(
                  'Anda mendapatkan',
                  style: TextStyle(
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
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Opacity(
              opacity: 0.96,
              child: const Text(
                'Rp20.000',
                style: TextStyle(
                  color: Color(0xFFFB7F54),
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.44,
                  letterSpacing: -0.25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LokasiRow extends StatelessWidget {
  const LokasiRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: Icon(
              Icons.location_on,
              size: 16,
              color: Color(0xFF0067AD),
            ),
          ),
          Opacity(
            opacity: 0.96,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Kampus 4 ',
                    style: const TextStyle(
                      color: Color(0xFF0067AD),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                    ),
                  ),
                  TextSpan(
                    text: '- Gedung Kedokteran',
                    style: const TextStyle(
                      color: Color(0xFF0067AD),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
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
