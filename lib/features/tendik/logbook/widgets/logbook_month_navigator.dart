import 'package:flutter/material.dart';

// ============================================================
// WIDGET: Navigasi Bulan Logbook
// Menampilkan nama bulan + tahun dengan tombol panah kiri/kanan.
// Dot indicator di bawah menunjukkan posisi bulan aktif.
// ============================================================
class LogbookMonthNavigator extends StatelessWidget {
  final String labelBulan;        // e.g. 'Juli 2026'
  final int totalDots;            // Jumlah dot indicator
  final int activeDotIndex;       // Index dot aktif (0-based)
  final VoidCallback? onPrevious; // Navigasi bulan sebelumnya
  final VoidCallback? onNext;     // Navigasi bulan berikutnya

  const LogbookMonthNavigator({
    super.key,
    required this.labelBulan,
    this.totalDots = 3,
    this.activeDotIndex = 1,
    this.onPrevious,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // --- Row: Panah kiri + Bulan + Panah kanan ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Panah Kiri
            _NavArrowButton(
              icon: Icons.chevron_left_rounded,
              onTap: onPrevious,
            ),

            // Label Bulan
            Text(
              labelBulan,
              style: const TextStyle(
                color: Color(0xFF293241),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.50,
                letterSpacing: -0.18,
              ),
            ),

            // Panah Kanan
            _NavArrowButton(
              icon: Icons.chevron_right_rounded,
              onTap: onNext,
            ),
          ],
        ),

        const SizedBox(height: 8),

        // --- Dot Indicator ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(totalDots, (index) {
            final isActive = index == activeDotIndex;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isActive ? 8 : 7,
                height: isActive ? 8 : 7,
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFF2B86C3)
                      : const Color(0xFFF6F7F7),
                  borderRadius: BorderRadius.circular(49),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ============================================================
// WIDGET PRIVAT: Tombol panah navigasi bulan
// ============================================================
class _NavArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _NavArrowButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(
          icon,
          size: 22,
          color: onTap != null
              ? const Color(0xFF293241)
              : const Color(0xFFCCCED1),
        ),
      ),
    );
  }
}
