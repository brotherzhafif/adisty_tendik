import 'package:flutter/material.dart';

// ============================================================
// ENUM: TIPE DIALOG APLIKASI
// ============================================================
enum AppDialogType {
  /// Dialog notifikasi sukses (ikon hijau, kucing berhasil)
  success,

  /// Dialog notifikasi error atau peringatan (ikon merah, kucing error)
  error,

  /// Dialog notifikasi informasi/peringatan ringan (ikon kuning, kucing error)
  info,
}

// ============================================================
// HELPER: Tampilkan dialog bergaya AppErrorScreen
// Gunakan ini sebagai pengganti SnackBar di seluruh aplikasi.
// ============================================================
Future<void> showAppDialog(
  BuildContext context, {
  required AppDialogType type,
  required String title,
  required String message,
  String buttonLabel = 'Oke',
  VoidCallback? onClose,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _AppDialog(
      type: type,
      title: title,
      message: message,
      buttonLabel: buttonLabel,
      onClose: onClose,
    ),
  );
}

// ============================================================
// WIDGET PRIVAT: Dialog UI bergaya AppErrorScreen
// ============================================================
class _AppDialog extends StatelessWidget {
  final AppDialogType type;
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback? onClose;

  const _AppDialog({
    required this.type,
    required this.title,
    required this.message,
    required this.buttonLabel,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final config = _dialogConfig[type]!;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ilustrasi kucing
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 160),
              child: Image.asset(
                config.imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            // Ikon status (lingkaran)
            Container(
              width: 56,
              height: 56,
              decoration: ShapeDecoration(
                color: config.iconBg,
                shape: const CircleBorder(),
              ),
              child: Icon(config.icon, color: config.iconColor, size: 28),
            ),
            const SizedBox(height: 16),

            // Judul
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF293241),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.3,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),

            // Pesan
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF5F6570),
                fontSize: 14,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Tombol tutup
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onClose?.call();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: config.buttonColor,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                buttonLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// KONFIGURASI PER TIPE DIALOG
// ============================================================
class _DialogConfig {
  final String imagePath;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final Color buttonColor;

  const _DialogConfig({
    required this.imagePath,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.buttonColor,
  });
}

const Map<AppDialogType, _DialogConfig> _dialogConfig = {
  AppDialogType.success: _DialogConfig(
    imagePath: 'assets/images/(presensi)_kucing_presensi_berhasil.png',
    icon: Icons.check_rounded,
    iconColor: Color(0xFF4AAF57),
    iconBg: Color(0x1E4AAF57),
    buttonColor: Color(0xFF0067AD),
  ),
  AppDialogType.error: _DialogConfig(
    imagePath: 'assets/images/(error)_kucing_error.png',
    icon: Icons.close_rounded,
    iconColor: Color(0xFFE65768),
    iconBg: Color(0x1EE65768),
    buttonColor: Color(0xFF0067AD),
  ),
  AppDialogType.info: _DialogConfig(
    imagePath: 'assets/images/(error)_kucing_error.png',
    icon: Icons.info_outline_rounded,
    iconColor: Color(0xFFFFAC2F),
    iconBg: Color(0x1EFFAC2F),
    buttonColor: Color(0xFF0067AD),
  ),
};
