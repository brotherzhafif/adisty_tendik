import 'package:flutter/material.dart';
import '../data/models/monitoring_presensi_model.dart';

// ============================================================
// HALAMAN / KOMPONEN: DETAIL PRESENSI & KOREKSI MONITORING
// ============================================================
class DetailPresensiKoreksi extends StatelessWidget {
  final String nama;
  final String jabatan;
  final String unit;
  final String tanggal;
  final String lokasi;
  final String jamMasuk;
  final String jamPulang;
  final String status;
  final String photoUrl;
  final String? alasanKoreksi;

  const DetailPresensiKoreksi({
    super.key,
    this.nama = 'Ahmad Luthfi Abdurrosyid, S.Kom.',
    this.jabatan = 'Programmer',
    this.unit = 'BSI - Staff urusan pengembangan',
    this.tanggal = 'Rabu, 9 September 2023',
    this.lokasi = 'Kampus 4 UAD',
    this.jamMasuk = '07.58',
    this.jamPulang = '16.00',
    this.status = 'On Time',
    this.photoUrl = 'https://placehold.co/64x64',
    this.alasanKoreksi,
  });

  factory DetailPresensiKoreksi.fromModel({
    required MonitoringPegawaiModel pegawai,
    required String tanggal,
  }) {
    return DetailPresensiKoreksi(
      nama: pegawai.nama,
      jabatan: pegawai.jabatan,
      unit: pegawai.unit,
      tanggal: tanggal,
      lokasi: pegawai.lokasi,
      jamMasuk: pegawai.masuk,
      jamPulang: pegawai.pulang,
      status: pegawai.status,
      photoUrl: pegawai.photoUrl,
      alasanKoreksi: pegawai.alasanKoreksi,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B86C3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B86C3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Detail Presensi & Koreksi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const ShapeDecoration(
                color: Color(0xFFF6F7F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(34),
                    topRight: Radius.circular(34),
                  ),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      // --- Date Header Card ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19,
                          vertical: 14,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x087281DF),
                              blurRadius: 4.11,
                              offset: Offset(0, 0.52),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: ShapeDecoration(
                                color: const Color(0x1E0067AD),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: const Icon(
                                Icons.calendar_month_rounded,
                                color: Color(0xFF0067AD),
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                tanggal,
                                style: const TextStyle(
                                  color: Color(0xFF293241),
                                  fontSize: 16,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.27,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // --- Profile & Status Card ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
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
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(64),
                              child: Image.network(
                                photoUrl,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 64,
                                  height: 64,
                                  color: const Color(0xFF2B86C3),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nama,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    unit,
                                    style: const TextStyle(
                                      color: Color(0xFFAEB1B7),
                                      fontSize: 11,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    jabatan,
                                    style: const TextStyle(
                                      color: Color(0xFFAEB1B7),
                                      fontSize: 11,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: const Color(0x1E18C079),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: Text(
                                      status,
                                      style: const TextStyle(
                                        color: Color(0xFF4AAF57),
                                        fontSize: 12,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),

                      // --- Informasi Presensi Card ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
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
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Informasi Presensi',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.27,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Row Lokasi
                            _buildInfoRow(
                              icon: Icons.location_on_rounded,
                              iconBgColor: const Color(0x1EE65768),
                              iconColor: const Color(0xFFE65768),
                              label: 'Lokasi',
                              value: lokasi,
                            ),

                            const Divider(height: 24, color: Color(0xFFEEEEEE)),

                            // Row Jam Masuk
                            _buildInfoRow(
                              icon: Icons.login_rounded,
                              iconBgColor: const Color(0x1E18C079),
                              iconColor: const Color(0xFF18C079),
                              label: 'Jam Masuk',
                              value: '$jamMasuk WIB',
                            ),

                            const Divider(height: 24, color: Color(0xFFEEEEEE)),

                            // Row Jam Pulang
                            _buildInfoRow(
                              icon: Icons.logout_rounded,
                              iconBgColor: const Color(0x1EFFAC2F),
                              iconColor: const Color(0xFFFFAC2F),
                              label: 'Jam Pulang',
                              value: '$jamPulang WIB',
                            ),
                          ],
                        ),
                      ),

                      if (alasanKoreksi != null &&
                          alasanKoreksi!.isNotEmpty) ...[
                        const SizedBox(height: 14),

                        // --- Alasan Koreksi Card ---
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x087281DF),
                                blurRadius: 4.11,
                                offset: Offset(0, 0.52),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Alasan Koreksi',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                alasanKoreksi!,
                                style: const TextStyle(
                                  color: Color(0xFF5F6570),
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: ShapeDecoration(
            color: iconBgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF5F6570),
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF293241),
                fontSize: 15,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
