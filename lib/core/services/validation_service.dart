import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:adisty_tendik_module/features/global_error/presentation/index.dart';

// ============================================================
// SERVICE: VALIDASI KONEKSI & PERANGKAT
// Digunakan untuk validasi presensi dan cek internet global
// ============================================================
class ValidationService {
  ValidationService._();
  static final ValidationService instance = ValidationService._();

  final _connectivity = Connectivity();
  final _networkInfo = NetworkInfo();
  final _deviceInfo = DeviceInfoPlugin();

  // ----------------------------------------------------------
  // CEK INTERNET (WiFi atau data seluler)
  // ----------------------------------------------------------
  Future<bool> hasInternet() async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (results.contains(ConnectivityResult.none)) return false;
      // Double-check dengan DNS lookup
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Stream perubahan konektivitas (untuk InternetGuard)
  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  // ----------------------------------------------------------
  // CEK WIFI + IPv4
  // ----------------------------------------------------------
  Future<({bool ok, String? ipAddress})> checkWifi() async {
    try {
      final results = await _connectivity.checkConnectivity();
      if (!results.contains(ConnectivityResult.wifi)) {
        return (ok: false, ipAddress: null);
      }
      final ip = await _networkInfo.getWifiIP();
      if (ip == null || ip.isEmpty) {
        return (ok: false, ipAddress: null);
      }
      return (ok: true, ipAddress: ip);
    } catch (_) {
      return (ok: false, ipAddress: null);
    }
  }

  // ----------------------------------------------------------
  // CEK LOKASI GPS (lat, long)
  // ----------------------------------------------------------
  Future<({bool ok, double? lat, double? long})> checkLocation() async {
    try {
      // Cek apakah GPS service aktif
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return (ok: false, lat: null, long: null);

      // Cek dan minta izin
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return (ok: false, lat: null, long: null);
      }

      // Ambil posisi
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      return (ok: true, lat: position.latitude, long: position.longitude);
    } catch (_) {
      return (ok: false, lat: null, long: null);
    }
  }

  // ----------------------------------------------------------
  // AMBIL DEVICE ID (iOS & Android)
  // ----------------------------------------------------------
  Future<String?> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        final info = await _deviceInfo.androidInfo;
        return info.id; // Android Hardware Serial / Build.ID
      } else if (Platform.isIOS) {
        final info = await _deviceInfo.iosInfo;
        return info.identifierForVendor;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  // ----------------------------------------------------------
  // VALIDASI LENGKAP UNTUK PRESENSI
  // Urutan: WiFi → IPv4 → Lokasi → DeviceID
  // Return null jika semua OK, atau AppErrorType jika ada yang gagal
  // ----------------------------------------------------------
  Future<AppErrorType?> validateForPresensi() async {
    // 1. Cek WiFi + IPv4
    final wifi = await checkWifi();
    if (!wifi.ok) return AppErrorType.noWifi;

    // 2. Cek Lokasi GPS
    final location = await checkLocation();
    if (!location.ok) return AppErrorType.noLocation;

    // 3. Cek Device ID
    final deviceId = await getDeviceId();
    if (deviceId == null || deviceId.isEmpty) return AppErrorType.noDeviceId;

    return null; // Semua OK
  }
}
