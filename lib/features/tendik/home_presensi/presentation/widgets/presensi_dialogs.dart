import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/widgets/app_text_style.dart';

class DialogKonfirmasiPulang extends StatelessWidget {
  final VoidCallback? onConfirmed;
  final VoidCallback? onLanjutShift;

  const DialogKonfirmasiPulang({
    super.key,
    this.onConfirmed,
    this.onLanjutShift,
  });

  @override
  Widget build(BuildContext context) {
    return DialogPilihanPulang(
      onPulang: onConfirmed,
      onLanjutShift: onLanjutShift,
    );
  }
}

// ============================================================
// DIALOG: PILIHAN TINDAKAN SEBELUM PULANG (LANJUT SHIFT / PULANG / BATAL)
// ============================================================
class DialogPilihanPulang extends StatelessWidget {
  final VoidCallback? onPulang;
  final VoidCallback? onLanjutShift;

  const DialogPilihanPulang({super.key, this.onPulang, this.onLanjutShift});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 428),
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Judul ---
            const Text(
              'Yakin dengan pilihan mu?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                height: 1.44,
                letterSpacing: -0.32,
              ),
            ),
            const SizedBox(height: 6),

            // --- Subjudul ---
            const Text(
              'Pilih tindakan yang ingin kamu lakukan sekarang.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w500,
                height: 1.50,
                letterSpacing: -0.27,
              ),
            ),
            const SizedBox(height: 20),

            // --- Row 2 Tombol: Lanjut Shift & Pulang (Responsif) ---
            Row(
              children: [
                // Tombol Lanjut Shift
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      onLanjutShift?.call();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF0067AD),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.schedule_rounded,
                            color: Color(0xFF0067AD),
                            size: 20,
                          ),
                          SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'Lanjut Shift',
                              style: TextStyle(
                                color: Color(0xFF0067AD),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 1.30,
                                letterSpacing: -0.18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Tombol Pulang
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) =>
                            DialogPresensiBerhasil(onConfirmed: onPulang),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFE65768),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: Color(0xFFE65768),
                            size: 20,
                          ),
                          SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'Pulang',
                              style: TextStyle(
                                color: Color(0xFFE65768),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 1.30,
                                letterSpacing: -0.18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // --- Tombol Batal ---
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: ShapeDecoration(
                  color: const Color(0x1E2B86C3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Batal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2B86C3),
                    fontSize: 16,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w700,
                    height: 1.50,
                    letterSpacing: -0.27,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogPresensiBerhasil extends StatelessWidget {
  final VoidCallback? onConfirmed;
  const DialogPresensiBerhasil({super.key, this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 296,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 174,
                        height: 184,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/(presensi)_kucing_presensi_berhasil.png',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 9,
                          children: [
                            SizedBox(
                              width: 280,
                              child: Text(
                                'Presensi Pulang Berhasil!', // Saya sesuaikan ke Pulang karena konteksnya Pulang
                                textAlign: TextAlign.center,
                                style: AppTextStyle.headingLg.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 234,
                              child: Text(
                                'Terima kasih atas kerja keras hari ini. Hati-hati di jalan pulang!', // Sesuaikan deskripsi
                                textAlign: TextAlign.center,
                                style: AppTextStyle.bodySm.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onConfirmed?.call();
                  },
                  child: SizedBox(
                    width: 235,
                    height: 48,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 9,
                      children: [
                        Container(
                          width: 224,
                          height: 48,
                          padding: const EdgeInsets.all(6),
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.50, 1.00),
                              end: Alignment(0.50, 0.00),
                              colors: [Color(0xFF4AAF57), Color(0xFF49C95A)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              SizedBox(
                                width: 212,
                                child: Text(
                                  'Ok',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.44,
                                    letterSpacing: -0.25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DIALOG: PRESENSI MASUK BERHASIL
// ============================================================
class DialogPresensiMasukBerhasil extends StatelessWidget {
  final VoidCallback? onConfirmed;
  const DialogPresensiMasukBerhasil({super.key, this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 296,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                Container(
                  width: 260,
                  height: 173,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/(presensi)_presensi_masuk_berhasil.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 9,
                          children: [
                            const SizedBox(
                              width: 280,
                              child: Text(
                                'Presensi Masuk Berhasil!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 1.50,
                                  letterSpacing: -0.18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 234,
                              child: Text(
                                'Semangat bekerja hari ini, Semoga aktivitasmu berjalan lancar dan produktif.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onConfirmed?.call();
                  },
                  child: SizedBox(
                    width: 235,
                    height: 48,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 9,
                      children: [
                        Container(
                          width: 224,
                          height: 48,
                          padding: const EdgeInsets.all(6),
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(0.50, 1.00),
                              end: Alignment(0.50, 0.00),
                              colors: [Color(0xFF4AAF57), Color(0xFF49C95A)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              SizedBox(
                                width: 212,
                                child: Text(
                                  'Ok',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 1.44,
                                    letterSpacing: -0.25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
