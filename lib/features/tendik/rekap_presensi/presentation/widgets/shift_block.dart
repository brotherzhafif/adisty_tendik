import 'package:flutter/material.dart';

// ============================================================
// KOMPONEN: SHIFT BLOCK (untuk halaman detail)
// ============================================================
class ShiftBlock extends StatelessWidget {
  final String shiftName;
  final String masuk;
  final String pulang;
  final String durasi;

  const ShiftBlock({
    super.key,
    required this.shiftName,
    required this.masuk,
    required this.pulang,
    required this.durasi,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label Shift
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: ShapeDecoration(
            color: const Color(0xFFE8F1F9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Text(
            shiftName,
            style: const TextStyle(
              color: Color(0xFF016EB8),
              fontSize: 12,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Jam Masuk & Jam Pulang
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const ShapeDecoration(
                      color: Color(0x1E4AAF57),
                      shape: CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.login,
                      color: Color(0xFF4AAF57),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jam Masuk',
                        style: TextStyle(
                          color: Color(0xFF5F6570),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        masuk,
                        style: const TextStyle(
                          color: Color(0xFF293241),
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const ShapeDecoration(
                      color: Color(0x1EFFA426),
                      shape: CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.logout,
                      color: Color(0xFFFFA426),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Jam Pulang',
                        style: TextStyle(
                          color: Color(0xFF5F6570),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        pulang,
                        style: const TextStyle(
                          color: Color(0xFF293241),
                          fontSize: 16,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Durasi Shift
        Row(
          children: [
            const Icon(
              Icons.timer_outlined,
              color: Color(0xFF5F6570),
              size: 20,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Durasi shift',
                  style: TextStyle(color: Color(0xFF5F6570), fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  durasi,
                  style: const TextStyle(
                    color: Color(0xFF293241),
                    fontSize: 14,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
