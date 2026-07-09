import 'package:flutter/material.dart';

// ============================================================
// WIDGET: AppBar SKP
// Header biru dengan tombol back dan judul "SKP Pegawai".
// ============================================================
class SkpAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const SkpAppBar({
    super.key,
    this.title = 'SKP Pegawai',
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF2B86C3),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // --- Tombol Kembali ---
              InkWell(
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),

              // --- Judul ---
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.40,
                    letterSpacing: -0.34,
                  ),
                ),
              ),

              // --- Placeholder kanan ---
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }
}
