import 'package:flutter/material.dart';

class BatasKoreksiInfo extends StatelessWidget {
  final int maxHari;

  const BatasKoreksiInfo({super.key, this.maxHari = 3});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: ShapeDecoration(
        color: const Color(0xFFE8F1F9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF016EB8), size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Batas pengajuan koreksi presensi adalah maksimal ',
                    style: TextStyle(
                      color: Color(0xFF293241),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                      height: 1.33,
                    ),
                  ),
                  TextSpan(
                    text: '$maxHari hari',
                    style: const TextStyle(
                      color: Color(0xFF016EB8),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                    ),
                  ),
                  const TextSpan(
                    text: ' setelah tanggal presensi.',
                    style: TextStyle(
                      color: Color(0xFF293241),
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
