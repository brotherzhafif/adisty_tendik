import 'package:flutter/material.dart';

// ============================================================
// KOMPONEN: BANNER DISCLAIMER INFO
// ============================================================
class InfoDisclaimerBanner extends StatelessWidget {
  final String message;

  const InfoDisclaimerBanner({
    super.key,
    this.message =
        'Data di atas merupakan rekap presensi yang sudah terverifikasi hingga tanggal 31 Oktober 2026.',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: const Color(0xFFE8F1F9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info, color: Color(0xFF016EB8), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF293241),
                fontSize: 12,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                height: 1.33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
