import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:adisty_tendik_module/core/services/validation_service.dart';
import 'package:adisty_tendik_module/features/global_error/presentation/index.dart';

// ============================================================
// WIDGET: INTERNET GUARD
// Membungkus seluruh aplikasi. Jika internet mati, tampilkan
// AppErrorScreen(noInternet). Otomatis kembali saat online.
// ============================================================
class InternetGuard extends StatefulWidget {
  final Widget child;

  const InternetGuard({super.key, required this.child});

  @override
  State<InternetGuard> createState() => _InternetGuardState();
}

class _InternetGuardState extends State<InternetGuard> {
  bool _isOnline = true;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    ValidationService.instance.connectivityStream.listen(_onConnectivityChanged);
  }

  Future<void> _checkInitialConnectivity() async {
    final online = await ValidationService.instance.hasInternet();
    if (mounted) setState(() => _isOnline = online);
  }

  Future<void> _onConnectivityChanged(List<ConnectivityResult> results) async {
    if (_isChecking) return;
    _isChecking = true;

    // Sedikit delay agar koneksi stabil sebelum dicek ulang
    await Future.delayed(const Duration(milliseconds: 800));
    final online = await ValidationService.instance.hasInternet();

    if (mounted) {
      setState(() {
        _isOnline = online;
        _isChecking = false;
      });
    } else {
      _isChecking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOnline) {
      return AppErrorScreen(
        errorType: AppErrorType.noInternet,
        onAction: _checkInitialConnectivity,
      );
    }
    return widget.child;
  }
}
