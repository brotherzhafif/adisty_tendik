import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

// ============================================================
// MODEL: Data item aktivitas logbook
// ============================================================
class LogbookActivityData {
  final String tanggal; // e.g. '03'
  final String bulan; // e.g. 'JULI'
  final String hariNama; // e.g. 'Jumat'
  final String judul; // Judul kegiatan
  final String deskripsi; // Deskripsi singkat

  const LogbookActivityData({
    required this.tanggal,
    required this.bulan,
    required this.hariNama,
    required this.judul,
    required this.deskripsi,
  });
}

// ============================================================
// WIDGET: Item Aktivitas Logbook (Reusable)
// Menampilkan satu baris aktivitas dengan tanggal di kiri
// dan judul + deskripsi di kanan, plus ikon chevron.
// ============================================================
class LogbookActivityItem extends StatelessWidget {
  final LogbookActivityData data;
  final VoidCallback? onTap;

  const LogbookActivityItem({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFFAFAFA)),
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x067281DF),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Kolom Tanggal ---
            _DateColumn(
              tanggal: data.tanggal,
              bulan: data.bulan,
              hariNama: data.hariNama,
            ),

            const SizedBox(width: 10),

            // --- Divider Vertikal ---
            Container(width: 1, height: 50, color: const Color(0xFFF6F7F7)),

            const SizedBox(width: 10),

            // --- Konten Aktivitas ---
            Expanded(
              child: _ActivityContent(
                judul: data.judul,
                deskripsi: data.deskripsi,
              ),
            ),

            // --- Ikon Chevron ---
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFCCCED1),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Kolom tanggal (kiri item)
// ============================================================
class _DateColumn extends StatelessWidget {
  final String tanggal;
  final String bulan;
  final String hariNama;

  const _DateColumn({
    required this.tanggal,
    required this.bulan,
    required this.hariNama,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tanggal,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              height: 1.3,
              letterSpacing: -0.27,
            ),
          ),
          Text(
            bulan,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          Text(
            hariNama,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFCCCED1),
              fontSize: 10,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Konten aktivitas (judul + deskripsi)
// ============================================================
class _ActivityContent extends StatelessWidget {
  final String judul;
  final String deskripsi;

  const _ActivityContent({required this.judul, required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          judul,
          style: AppTextStyle.bodySm.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          deskripsi,
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
