import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Kartu Profil Pegawai
// Menampilkan foto, nama, unit, dan jabatan pegawai.
// Responsif — menggunakan Flexible agar nama tidak overflow.
// ============================================================
class LogbookProfileCard extends StatelessWidget {
  final String namaLengkap;
  final String unitKerja;
  final String jabatan;
  final String subUnit;
  final String? photoUrl;

  const LogbookProfileCard({
    super.key,
    required this.namaLengkap,
    required this.unitKerja,
    required this.jabatan,
    required this.subUnit,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFFAFAFA)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Foto Profil ---
          _ProfileAvatar(photoUrl: photoUrl),

          const SizedBox(width: 6),

          // --- Info Pegawai ---
          Expanded(
            child: _ProfileInfo(
              namaLengkap: namaLengkap,
              unitKerja: unitKerja,
              jabatan: jabatan,
              subUnit: subUnit,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Avatar foto profil
// ============================================================
class _ProfileAvatar extends StatelessWidget {
  final String? photoUrl;

  const _ProfileAvatar({this.photoUrl});

  @override
  Widget build(BuildContext context) {
    final bool hasValidUrl = photoUrl != null &&
        photoUrl!.isNotEmpty &&
        !photoUrl!.contains('placehold.co');

    return Container(
      width: 64,
      height: 64,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(0.50, -0.00),
          end: Alignment(0.50, 1.00),
          colors: [Color(0xFFF6CE65), Color(0xFFDE7C28)],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(64),
        child: hasValidUrl
            ? Image.network(
                photoUrl!,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const _DefaultAvatarIcon(),
              )
            : const _DefaultAvatarIcon(),
      ),
    );
  }
}

class _DefaultAvatarIcon extends StatelessWidget {
  const _DefaultAvatarIcon();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.person_rounded,
        color: Colors.white,
        size: 38,
      ),
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Info teks profil pegawai
// ============================================================
class _ProfileInfo extends StatelessWidget {
  final String namaLengkap;
  final String unitKerja;
  final String jabatan;
  final String subUnit;

  const _ProfileInfo({
    required this.namaLengkap,
    required this.unitKerja,
    required this.jabatan,
    required this.subUnit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nama
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            namaLengkap,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 1.33,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Unit Kerja
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            unitKerja,
            style: const TextStyle(
              color: Color(0xFFAEB1B7),
              fontSize: 10,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w500,
              height: 1.60,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Jabatan
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            jabatan,
            style: const TextStyle(
              color: Color(0xFFAEB1B7),
              fontSize: 10,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w500,
              height: 1.60,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // Sub Unit
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Text(
            subUnit,
            style: const TextStyle(
              color: Color(0xFFAEB1B7),
              fontSize: 10,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w500,
              height: 1.60,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
