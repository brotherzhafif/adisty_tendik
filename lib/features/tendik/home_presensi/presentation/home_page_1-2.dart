import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ============================================================
// HALAMAN UTAMA - HomePage1
// ============================================================
class HomePage1 extends StatelessWidget {
  const HomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- Header Profil ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: _ProfileHeader(),
              ),

              // --- Konten Informasi (Presensi + Layanan) ---
              _InformationSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// KOMPONEN: HEADER PROFIL
// Menampilkan foto, nama, sapaan, dan ikon notifikasi
// ============================================================
class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 100,
      children: [
        // --- Info Pengguna (Foto + Nama) ---
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            // Foto Profil
            Container(
              width: 64,
              height: 64,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.50, -0.00),
                  end: Alignment(0.50, 1.00),
                  colors: [Color(0xFFF6CE65), Color(0xFFDE7C28)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(64),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: NetworkImage('https://placehold.co/64x64'),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(64),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Nama & Sapaan
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Hi Agung',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFF293241),
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 1.33,
                        letterSpacing: -0.46,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Selamat datang di Adisty',
                  style: TextStyle(
                    color: Color(0xFF5F6570),
                    fontSize: 14,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                    letterSpacing: -0.17,
                  ),
                ),
              ],
            ),
          ],
        ),

        // --- Ikon Notifikasi dengan Badge ---
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/notification-icon.svg',
                width: 8,
                height: 8,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color(0xFFDE7C28),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// KOMPONEN: SECTION INFORMASI UTAMA
// Wrapper untuk semua section: presensi & layanan
// ============================================================
class _InformationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 18,
            children: [
              // --- Section Presensi ---
              Container(
                width: 378,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 11,
                        children: [
                          // Card Presensi (biru)
                          _PresensiCard(),

                          // Row Statistik (jumlah presensi + status)
                          _StatistikPresensi(),

                          // Tombol Pulang + hint
                          _TombolPulang(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // --- Section Layanan Adisty ---
              _LayananAdistySection(),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// KOMPONEN: CARD PRESENSI HARI INI
// Menampilkan header biru dengan info masuk, pulang,
// transportasi, dan lokasi kampus
// ============================================================
class _PresensiCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Opacity(
                      opacity: 0.96,
                      child: const Text(
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
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Opacity(
                      opacity: 0.96,
                      child: const Text(
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
                  ],
                ),
              ),
            ],
          ),

          // Body: baris masuk, pulang, transportasi, lokasi
          Container(
            width: 345,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 11,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 14,
                    children: [
                      // Baris Masuk
                      _PresensiRow(
                        iconColor: const Color(0xFF18C079),
                        label: 'Masuk',
                        labelColor: const Color(0xFF18C079),
                        jam: '06:45',
                        statusText: 'Terkonfirmasi',
                        statusColor: const Color(0xFF18C079),
                        statusBgColor: const Color(0x1E4AAF57),
                        exitIconColor: const Color(0xFF18C079),
                        exitBgColor: const Color(0x1E4AAF57),
                      ),

                      // Baris Pulang
                      _PresensiRow(
                        iconColor: const Color(0xFFFFAC2F),
                        label: 'Pulang',
                        labelColor: const Color(0xFF293241),
                        jam: '16:00',
                        statusText: 'Terkonfirmasi',
                        statusColor: const Color(0xFFFFAC2F),
                        statusBgColor: const Color(0x1EFFAC2F),
                        exitIconColor: const Color(0xFFFFAC2F),
                        exitBgColor: const Color(0x1EFFAC2F),
                      ),
                    ],
                  ),
                ),

                // Baris Transportasi Hari Ini
                _TransportasiRow(),

                // Baris Lokasi Kampus
                _LokasiRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// KOMPONEN: BARIS PRESENSI (Masuk / Pulang)
// Digunakan ulang untuk baris masuk dan baris pulang
// ============================================================
class _PresensiRow extends StatelessWidget {
  final Color iconColor;
  final String label;
  final Color labelColor;
  final String jam;
  final String statusText;
  final Color statusColor;
  final Color statusBgColor;
  final Color exitIconColor;
  final Color exitBgColor;

  const _PresensiRow({
    required this.iconColor,
    required this.label,
    required this.labelColor,
    required this.jam,
    required this.statusText,
    required this.statusColor,
    required this.statusBgColor,
    required this.exitIconColor,
    required this.exitBgColor,
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
                  child: Icon(
                    Icons.check_circle,
                    size: 33,
                    color: iconColor,
                  ),
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
                      // Label (Masuk / Pulang)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 4, right: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 12,
                          children: [
                            Opacity(
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
                          ],
                        ),
                      ),

                      // Jam
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(right: 10, bottom: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 10,
                          children: [
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

                      // Badge status
                      Container(
                        width: label == 'Masuk' ? 100 : 99,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: ShapeDecoration(
                          color: statusBgColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 12,
                          children: [
                            Opacity(
                              opacity: 0.96,
                              child: Text(
                                statusText,
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w500,
                                  height: label == 'Masuk' ? 1.50 : 1.33,
                                ),
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
              'assets/icons/keluar-icon.svg',
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

// ============================================================
// KOMPONEN: BARIS TRANSPORTASI HARI INI
// Menampilkan info tunjangan transportasi harian
// ============================================================
class _TransportasiRow extends StatelessWidget {
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
          // Kiri: label & subjudul
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

          // Kanan: nominal
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

// ============================================================
// KOMPONEN: BARIS LOKASI KAMPUS
// Menampilkan nama gedung/lokasi presensi
// ============================================================
class _LokasiRow extends StatelessWidget {
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
          // Ikon lokasi
          SizedBox(
            width: 16,
            height: 16,
            child: const Icon(
              Icons.location_on,
              size: 16,
              color: Color(0xFF0067AD),
            ),
          ),

          // Nama lokasi
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

// ============================================================
// KOMPONEN: STATISTIK PRESENSI
// Menampilkan jumlah presensi bulan ini & status kehadiran
// ============================================================
class _StatistikPresensi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 6,
        children: [
          // Jumlah Presensi bulan ini
          _StatistikItem(
            iconColor: const Color(0xFFFB7F54),
            bgColor: const Color(0x1EFB7F54),
            iconPath: 'assets/icons/people-icon.svg',
            label: 'Jumlah Presensi',
            value: '19',
            valueColor: const Color(0xFFFB7F54),
            subLabel: 'Bulan ini',
            subLabelColor: const Color(0xFFFB7F54),
          ),

          // Status Presensi
          _StatistikItem(
            iconColor: const Color(0xFF18C079),
            bgColor: const Color(0x1E4AAF57),
            iconPath: 'assets/icons/shield-icon.svg',
            label: 'Status Presensi',
            value: 'On Time',
            valueColor: const Color(0xFF18C079),
            subLabel: 'Excellent!',
            subLabelColor: const Color(0xFF18C079),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// KOMPONEN: ITEM STATISTIK (reusable)
// Digunakan untuk tiap card statistik di baris statistik
// ============================================================
class _StatistikItem extends StatelessWidget {
  final Color iconColor;
  final Color bgColor;
  final String iconPath;
  final String label;
  final String value;
  final Color valueColor;
  final String subLabel;
  final Color subLabelColor;

  const _StatistikItem({
    required this.iconColor,
    required this.bgColor,
    required this.iconPath,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.subLabel,
    required this.subLabelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 179,
      padding: const EdgeInsets.only(top: 8, left: 12, right: 6, bottom: 8),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          // Ikon bulat
          Container(
            width: 35,
            height: 35,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: SvgPicture.asset(
              iconPath,
              width: 22,
              height: 22,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),

          // Label, nilai, & sub-label
          SizedBox(
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label atas
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF293241),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                    ),
                  ),
                ),

                // Nilai utama
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    value,
                    style: TextStyle(
                      color: valueColor,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.40,
                      letterSpacing: -0.34,
                    ),
                  ),
                ),

                // Sub-label bawah
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    subLabel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: subLabelColor,
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
        ],
      ),
    );
  }
}

// ============================================================
// KOMPONEN: TOMBOL PULANG
// Tombol gradient kuning untuk aksi pulang + teks petunjuk
// ============================================================
class _TombolPulang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Tombol Pulang
        Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 9,
            children: [
              Container(
                width: 378,
                height: 48,
                padding: const EdgeInsets.all(6),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.50, 1.00),
                    end: Alignment(0.50, 0.00),
                    colors: [Color(0xFFFFAC2F), Color(0xFFFFC268)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    const SizedBox(
                      width: 366,
                      child: Text(
                        'Pulang',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1.44,
                          letterSpacing: -0.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 9),

        // Teks petunjuk
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
          decoration: ShapeDecoration(
            color: const Color(0xFFF6F7F7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Opacity(
                opacity: 0.96,
                child: const Text(
                  'Klik tombol diatas saat Anda ingin pulang',
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
        ),
      ],
    );
  }
}

// ============================================================
// KOMPONEN: SECTION LAYANAN ADISTY
// Wrapper untuk judul dan daftar card layanan horizontal
// ============================================================
class _LayananAdistySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
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
                // Card Tunjangan Beras
                _LayananCard(
                  title: 'Tunjangan Beras',
                  description: 'Tinjau informasi pengambilan tunjangan beras ',
                  imagePath: 'assets/images/tunjangan_beras_2.png',
                ),

                // Card Layanan Cuti
                _LayananCard(
                  title: 'Layanan Cuti',
                  description: 'Tinjau informasi cuti anda',
                  imagePath: 'assets/images/layanan_cuti_2.png',
                ),

                // Card Penilaian Kerja
                _LayananCard(
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
class _LayananCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const _LayananCard({
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
