import 'package:flutter/material.dart';

// ============================================================
// WIDGET: TUNJANGAN PAGE HEADER
// Header bagian atas (background biru) dengan judul halaman
// dan ikon back button. Dipakai di TunjanganBeras & TunjanganBerasScan.
// ============================================================
class TunjanganPageHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const TunjanganPageHeader({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF2B86C3),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        left: 16,
        right: 16,
        bottom: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button
          GestureDetector(
            onTap: onBack ?? () => Navigator.of(context).maybePop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Judul
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.33,
                letterSpacing: -0.20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
