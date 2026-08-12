import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';
import 'kategori_aktivitas_picker_modal.dart';

// ============================================================
// WIDGET: Kartu Header Detail Logbook
// Menampilkan tanggal aktivitas, waktu pembuatan, dan status.
// ============================================================
class LogbookDetailHeaderCard extends StatelessWidget {
  final String tanggalLengkap; // e.g. 'Jumat, 03 Juli 2026'
  final String waktuDibuat; // e.g. 'Dibuat pada 03 Juli 2026, 10:25 WIB'
  final String status; // e.g. 'Tersimpan'
  final int totalKategori;
  final int currentKategoriIndex;
  final String? currentKategoriNama;
  final List<String>? listKategori;
  final ValueChanged<int>? onKategoriChanged;
  final ValueChanged<String>? onKategoriSelected;

  const LogbookDetailHeaderCard({
    super.key,
    required this.tanggalLengkap,
    required this.waktuDibuat,
    required this.status,
    this.totalKategori = 1,
    this.currentKategoriIndex = 1,
    this.currentKategoriNama,
    this.listKategori,
    this.onKategoriChanged,
    this.onKategoriSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
          BoxShadow(
            color: Color(0x0F7281DF),
            blurRadius: 10.20,
            offset: Offset(0, 4.11),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Icon Container Bulat ---
              Container(
                width: 52,
                height: 52,
                decoration: const ShapeDecoration(
                  color: Color(0x192B86C3),
                  shape: CircleBorder(),
                ),
                child: const Icon(
                  Icons.calendar_today_rounded,
                  color: Color(0xFF2B86C3),
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              // --- Kolom Info Teks ---
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tanggalLengkap,
                      style: AppTextStyle.bodyMd.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      waktuDibuat,
                      style: const TextStyle(
                        color: Color(0xFFCCCED1),
                        fontSize: 10,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // --- Badge Status ---
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0x194AAF57),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xF54AAF57)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Color(0xF54AAF57),
                    fontSize: 10,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // --- Row Selector Kategori Aktivitas ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Icons.chevron_left_rounded,
                  color: currentKategoriIndex > 1
                      ? const Color(0xFF293241)
                      : const Color(0xFFCCCED1),
                  size: 20,
                ),
                onPressed: currentKategoriIndex > 1
                    ? () => onKategoriChanged?.call(currentKategoriIndex - 1)
                    : null,
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () async {
                  final categories = listKategori != null && listKategori!.isNotEmpty
                      ? listKategori!
                      : [currentKategoriNama ?? 'Aktivitas Utama'];
                  final result = await KategoriAktivitasPickerModal.show(
                    context,
                    listKategori: categories,
                    selectedKategori: currentKategoriNama ?? '',
                  );
                  if (result != null && context.mounted) {
                    onKategoriSelected?.call(result);
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Kategori Aktivitas',
                        style: TextStyle(
                          color: Color(0xFF2B86C3),
                          fontSize: 12,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          height: 1.33,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0x192B86C3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          '$currentKategoriIndex',
                          style: const TextStyle(
                            color: Color(0xFF2B86C3),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 1.43,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Icons.chevron_right_rounded,
                  color: currentKategoriIndex < totalKategori
                      ? const Color(0xFF293241)
                      : const Color(0xFFCCCED1),
                  size: 20,
                ),
                onPressed: currentKategoriIndex < totalKategori
                    ? () => onKategoriChanged?.call(currentKategoriIndex + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
