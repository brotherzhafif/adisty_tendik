import 'package:flutter/material.dart';

// ============================================================
// ENUM: TIPE ERROR APLIKASI
// ============================================================
enum AppErrorType {
  /// Tidak ada akses internet sama sekali (WiFi/data)
  noInternet,

  /// Tidak terhubung ke WiFi atau tidak ada IP Address (untuk presensi)
  noWifi,

  /// GPS mati atau izin lokasi ditolak (untuk presensi)
  noLocation,

  /// Gagal membaca Device ID (untuk presensi)
  noDeviceId,
}

// ============================================================
// HALAMAN: ERROR SCREEN
// Ditampilkan saat terjadi error global atau validasi presensi.
// Gunakan AppErrorScreen.withMessage(...) untuk error fetch data
// dengan pesan error bebas + tombol Kembali.
// ============================================================
class AppErrorScreen extends StatelessWidget {
  // ── Mode 1: enum-based (existing) ────────────────────────────
  final AppErrorType? errorType;
  final VoidCallback? onAction;

  // ── Mode 2: free-message (baru) ──────────────────────────────
  final String? _title;
  final String? _errorMessage;
  final VoidCallback? _onRetry;
  final bool _isMessageMode;

  // Konstruktor lama (enum-based)
  const AppErrorScreen({
    super.key,
    required this.errorType,
    this.onAction,
  })  : _title = null,
        _errorMessage = null,
        _onRetry = null,
        _isMessageMode = false;

  // Konstruktor baru: pesan error bebas + tombol Kembali
  const AppErrorScreen.withMessage({
    super.key,
    String? title,
    required String errorMessage,
    VoidCallback? onRetry,
  })  : errorType = null,
        onAction = null,
        _title = title,
        _errorMessage = errorMessage,
        _onRetry = onRetry,
        _isMessageMode = true;

  @override
  Widget build(BuildContext context) {
    if (_isMessageMode) {
      return _buildMessageMode(context);
    }
    return _buildEnumMode(context);
  }

  // ── Mode 1: Enum-based (unchanged) ───────────────────────────
  Widget _buildEnumMode(BuildContext context) {
    final config = _errorConfig[errorType!]!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Ilustrasi error
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 260),
                  child: Image.asset(
                    'assets/images/(error)_kucing_error.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),

                // Ikon status (lingkaran besar)
                Container(
                  width: 64,
                  height: 64,
                  decoration: ShapeDecoration(
                    color: config.iconBg,
                    shape: const CircleBorder(),
                  ),
                  child: Icon(config.icon, color: config.iconColor, size: 32),
                ),
                const SizedBox(height: 20),

                // Judul
                Text(
                  config.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF293241),
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    letterSpacing: -0.46,
                  ),
                ),
                const SizedBox(height: 10),

                // Deskripsi
                Text(
                  config.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF5F6570),
                    fontSize: 15,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 36),

                // Tombol aksi
                ElevatedButton.icon(
                  onPressed: onAction ?? () => Navigator.pop(context),
                  icon: Icon(config.buttonIcon, color: Colors.white, size: 18),
                  label: Text(
                    config.buttonLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0067AD),
                    minimumSize: const Size(160, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Mode 2: Free-message (baru) ──────────────────────────────
  Widget _buildMessageMode(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Ilustrasi
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 220),
                  child: Image.asset(
                    'assets/images/(error)_kucing_error.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),

                // Ikon error
                Container(
                  width: 60,
                  height: 60,
                  decoration: const ShapeDecoration(
                    color: Color(0x1EE65768),
                    shape: CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.cloud_off_rounded,
                    color: Color(0xFFE65768),
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),

                // Judul
                Text(
                  _title ?? 'Gagal Memuat Data',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF293241),
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    letterSpacing: -0.40,
                  ),
                ),
                const SizedBox(height: 8),

                const Text(
                  'Terjadi kesalahan saat mengambil data.\nSilakan coba lagi atau hubungi admin.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF5F6570),
                    fontSize: 14,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Detail error (scrollable)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 120),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F7F9),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _errorMessage ?? '',
                        style: const TextStyle(
                          color: Color(0xFF5F6570),
                          fontSize: 12,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Tombol Kembali (selalu ada)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 18,
                          color: Color(0xFF0067AD),
                        ),
                        label: const Text(
                          'Kembali',
                          style: TextStyle(
                            color: Color(0xFF0067AD),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          side: const BorderSide(color: Color(0xFF0067AD)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                      ),
                    ),
                    if (_onRetry != null) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _onRetry,
                          icon: const Icon(
                            Icons.refresh_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: const Text(
                            'Coba Lagi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0067AD),
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// KONFIGURASI PER TIPE ERROR
// ============================================================
class _ErrorConfig {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String buttonLabel;
  final IconData buttonIcon;

  const _ErrorConfig({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.buttonLabel,
    required this.buttonIcon,
  });
}

const Map<AppErrorType, _ErrorConfig> _errorConfig = {
  AppErrorType.noInternet: _ErrorConfig(
    title: 'Tidak Ada Koneksi',
    description:
        'Perangkat Anda tidak terhubung ke internet.\nPastikan WiFi atau data seluler aktif.',
    icon: Icons.wifi_off_rounded,
    iconColor: Color(0xFFE65768),
    iconBg: Color(0x1EE65768),
    buttonLabel: 'Coba Lagi',
    buttonIcon: Icons.refresh_rounded,
  ),
  AppErrorType.noWifi: _ErrorConfig(
    title: 'WiFi Tidak Aktif',
    description:
        'Presensi memerlukan koneksi WiFi dengan IP Address.\nSilakan sambungkan ke jaringan WiFi kampus.',
    icon: Icons.signal_wifi_off_rounded,
    iconColor: Color(0xFFFFAC2F),
    iconBg: Color(0x1EFFAC2F),
    buttonLabel: 'Kembali',
    buttonIcon: Icons.arrow_back_rounded,
  ),
  AppErrorType.noLocation: _ErrorConfig(
    title: 'Lokasi Tidak Aktif',
    description:
        'Presensi memerlukan akses lokasi GPS.\nAktifkan lokasi pada pengaturan perangkat Anda.',
    icon: Icons.location_off_rounded,
    iconColor: Color(0xFFFFAC2F),
    iconBg: Color(0x1EFFAC2F),
    buttonLabel: 'Kembali',
    buttonIcon: Icons.arrow_back_rounded,
  ),
  AppErrorType.noDeviceId: _ErrorConfig(
    title: 'Perangkat Tidak Dikenali',
    description:
        'Gagal membaca identitas perangkat.\nCoba restart aplikasi atau hubungi admin.',
    icon: Icons.phonelink_erase_rounded,
    iconColor: Color(0xFFE65768),
    iconBg: Color(0x1EE65768),
    buttonLabel: 'Kembali',
    buttonIcon: Icons.arrow_back_rounded,
  ),
};

// ============================================================
// ALIAS BACKWARD-COMPATIBLE
// ============================================================
/// Alias untuk backward-compatibility. Gunakan [AppErrorScreen] untuk kode baru.
typedef SistemErrorApi = AppErrorScreen;
