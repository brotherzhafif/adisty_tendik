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

          const SizedBox(width: 12),

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
    return Container(
      width: 64,
      height: 64,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF6CE65), Color(0xFFDE7C28)],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(64),
        child: photoUrl != null
            ? Image.network(
                photoUrl!,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _AvatarPlaceholder(),
              )
            : _AvatarPlaceholder(),
      ),
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Placeholder avatar jika foto tidak tersedia
// ============================================================
class _AvatarPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.person_rounded, size: 36, color: Colors.white),
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
        Text(
          namaLengkap,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        // Unit Kerja
        Text(
          unitKerja,
          style: const TextStyle(
            color: Color(0xFFAEB1B7),
            fontSize: 10,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // Jabatan
        Text(
          jabatan,
          style: const TextStyle(
            color: Color(0xFFAEB1B7),
            fontSize: 10,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // Sub Unit
        Text(
          subUnit,
          style: const TextStyle(
            color: Color(0xFFAEB1B7),
            fontSize: 10,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
