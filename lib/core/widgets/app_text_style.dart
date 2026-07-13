import 'package:flutter/material.dart';

// ============================================================
// TYPOGRAPHY SYSTEM — AppTextStyle
// Skala font yang dipakai di seluruh aplikasi Adisty.
// Gunakan class ini untuk semua TextStyle agar ukuran font
// dan family konsisten di semua halaman.
//
// Skala:
//   xs  = 10  → caption, badge kecil
//   sm  = 12  → helper text, label sekunder, link kecil
//   md  = 14  → label form, body sekunder, subheading kecil
//   lg  = 16  → body utama, nilai form, teks kartu
//   xl  = 20  → judul halaman (appbar)
//   xxl = 24  → greeting / judul besar
// ============================================================

abstract class AppTextStyle {
  AppTextStyle._();

  // --- Font Families ---
  static const String _poppins   = 'Poppins';
  static const String _nunito    = 'Nunito';
  static const String _nunitoSans = 'Nunito Sans';

  // ==========================================================
  // HEADING / JUDUL
  // ==========================================================

  /// xxl/24 — Greeting atau judul hero ("Hi Agung")
  static const TextStyle headingXxl = TextStyle(
    fontSize: 24,
    fontFamily: _poppins,
    fontWeight: FontWeight.w600,
    color: Color(0xFF293241),
    height: 1.33,
    letterSpacing: -0.46,
  );

  /// xl/20 — Judul halaman di AppBar
  static const TextStyle headingXl = TextStyle(
    fontSize: 20,
    fontFamily: _poppins,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.40,
    letterSpacing: -0.34,
  );

  /// lg/16 — Judul card / section header
  static const TextStyle headingLg = TextStyle(
    fontSize: 16,
    fontFamily: _nunito,
    fontWeight: FontWeight.w700,
    color: Color(0xFF293241),
    height: 1.50,
    letterSpacing: -0.27,
  );

  // ==========================================================
  // BODY
  // ==========================================================

  /// lg/16 — Nilai utama (jam, tanggal besar, angka penting)
  static const TextStyle bodyLg = TextStyle(
    fontSize: 16,
    fontFamily: _nunito,
    fontWeight: FontWeight.w600,
    color: Color(0xFF293241),
    height: 1.50,
  );

  /// md/14 — Label form, body standar, deskripsi kartu
  static const TextStyle bodyMd = TextStyle(
    fontSize: 14,
    fontFamily: _poppins,
    fontWeight: FontWeight.w400,
    color: Color(0xFF5F6570),
    height: 1.43,
    letterSpacing: -0.08,
  );

  /// sm/12 — Teks sekunder, helper, caption, link kecil
  static const TextStyle bodySm = TextStyle(
    fontSize: 12,
    fontFamily: _nunito,
    fontWeight: FontWeight.w500,
    color: Color(0xFF5F6570),
    height: 1.33,
  );

  /// xs/10 — Badge sangat kecil, caption tersier
  static const TextStyle bodyXs = TextStyle(
    fontSize: 10,
    fontFamily: _nunito,
    fontWeight: FontWeight.w500,
    color: Color(0xFFAEB1B7),
    height: 1.50,
  );

  // ==========================================================
  // LABEL / BADGE
  // ==========================================================

  /// sm/12 Bold — Badge status (Menunggu, Disetujui, dsb)
  static const TextStyle badgeSm = TextStyle(
    fontSize: 12,
    fontFamily: _nunitoSans,
    fontWeight: FontWeight.w700,
    height: 1.33,
  );

  /// sm/12 — Link teks kecil ("Lihat Detail", "Kembali")
  static const TextStyle linkSm = TextStyle(
    fontSize: 12,
    fontFamily: _nunito,
    fontWeight: FontWeight.w600,
    color: Color(0xFF016EB8),
    height: 1.33,
  );

  // ==========================================================
  // FORM / INPUT
  // ==========================================================

  /// md/14 — Label field input (Tanggal, Jabatan, dll)
  static const TextStyle inputLabel = TextStyle(
    fontSize: 14,
    fontFamily: _poppins,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    height: 1.43,
  );

  /// md/14 — Nilai/teks di dalam field input
  static const TextStyle inputValue = TextStyle(
    fontSize: 14,
    fontFamily: _nunito,
    fontWeight: FontWeight.w500,
    color: Color(0xFF293241),
    height: 1.43,
  );

  /// md/14 — Placeholder / hint text
  static const TextStyle inputHint = TextStyle(
    fontSize: 14,
    fontFamily: _nunito,
    fontWeight: FontWeight.w400,
    color: Color(0xFFAEB1B7),
    height: 1.43,
  );

  // ==========================================================
  // TOMBOL / BUTTON
  // ==========================================================

  /// md/14 — Label tombol utama
  static const TextStyle buttonMd = TextStyle(
    fontSize: 14,
    fontFamily: _poppins,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  /// lg/16 — Label tombol besar / CTA
  static const TextStyle buttonLg = TextStyle(
    fontSize: 16,
    fontFamily: _poppins,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
