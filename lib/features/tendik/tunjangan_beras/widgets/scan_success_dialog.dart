import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

// ============================================================
// WIDGET: SCAN SUCCESS DIALOG
// Notifikasi berhasil setelah QR code ter-scan.
// Tampilkan dengan showDialog() atau showGeneralDialog().
// ============================================================
class ScanSuccessDialog extends StatelessWidget {
  final VoidCallback? onOk;

  const ScanSuccessDialog({super.key, this.onOk});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 311,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 48,
            children: [
              // ── Ikon & Teks ──
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 24,
                children: [
                  // Ikon centang hijau
                  Container(
                    width: 120,
                    height: 120,
                    decoration: ShapeDecoration(
                      color: const Color(0x1E18C07A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_rounded,
                        size: 56,
                        color: Color(0xFF18C07A),
                      ),
                    ),
                  ),

                  // Judul & deskripsi
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Text(
                        'Anda Bisa Ambil Beras',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF293241),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                          letterSpacing: -0.34,
                        ),
                      ),
                      SizedBox(
                        width: 217,
                        child: Text(
                          'QR Code telah ter scan untuk pengambilan beras',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF9D9D9D),
                            fontSize: 14,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // ── Tombol Ok ──
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: onOk ?? () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 12,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2B86C3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Ok',
                        style: AppTextStyle.headingLg.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
