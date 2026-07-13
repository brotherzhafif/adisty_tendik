import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

// ============================================================
// WIDGET: RIWAYAT BERAS ITEM
// Card item yang menampilkan satu entri riwayat pengambilan beras.
// Gunakan [isDisabled] untuk tampilan item yang belum aktif (abu-abu).
// Gunakan [onTap] untuk navigasi saat item ditekan.
// ============================================================
class RiwayatBerasItem extends StatelessWidget {
  final String tanggal;
  final String lokasi;
  final String beratKg;
  final bool isDisabled;
  final VoidCallback? onTap;

  const RiwayatBerasItem({
    super.key,
    required this.tanggal,
    required this.lokasi,
    required this.beratKg,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isDisabled ? const Color(0xFFE5E6E8) : Colors.white;
    final Color tanggalColor = isDisabled
        ? const Color(0xFF8B9098)
        : const Color(0xFF293241);
    final Color lokasiColor = const Color(0xFF7A8089);
    final Color berasLabelColor = isDisabled
        ? const Color(0xFF8B9098)
        : const Color(0xFF293241);
    final Color berasValueColor = isDisabled
        ? const Color(0xFFAEB1B7)
        : const Color(0xFF2B86C3);
    final Color borderColor = isDisabled
        ? const Color(0xFFB8BBC1)
        : const Color(0xFFEEF1F3);

    return InkWell(
      onTap: isDisabled ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDisabled
              ? null
              : const [
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
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Info utama (tanggal & lokasi) ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 4,
                    children: [
                      Text(
                        tanggal,
                        style: TextStyle(
                          color: tanggalColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 1.50,
                          letterSpacing: -0.18,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Color(0xFF7A8089),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              lokasi,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: lokasiColor,
                                fontSize: 13,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                                letterSpacing: -0.17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ── Kolom berat (kanan) ──
              Container(
                width: 72,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(width: 1, color: borderColor),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Beras',
                      style: AppTextStyle.bodySm.copyWith(
                        color: berasLabelColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      beratKg,
                      style: AppTextStyle.headingLg.copyWith(
                        color: berasValueColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
