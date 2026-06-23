import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';

import '../models/device_context_model.dart';

/// Service non-UI yang bertanggung jawab mengumpulkan data konteks perangkat
/// secara asynchronous.
///
/// Semua data bersifat **wajib**. Jika salah satu gagal diambil (izin
/// ditolak, GPS mati, IP tidak valid, dll.), method [getDeviceContext] akan
/// melempar [Exception] dengan pesan yang spesifik agar dapat ditangkap
/// oleh BLoC sebagai error state.
///
/// Cara pakai di BLoC:
/// ```dart
/// try {
///   final context = await DeviceContextService().getDeviceContext();
///   emit(DeviceContextLoaded(context));
/// } catch (e) {
///   emit(DeviceContextError(e.toString()));
/// }
/// ```
class DeviceContextService {
  final DeviceInfoPlugin _deviceInfo;
  final NetworkInfo _networkInfo;

  DeviceContextService({
    DeviceInfoPlugin? deviceInfo,
    NetworkInfo? networkInfo,
  })  : _deviceInfo = deviceInfo ?? DeviceInfoPlugin(),
        _networkInfo = networkInfo ?? NetworkInfo();

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// Mengumpulkan seluruh data konteks perangkat dan mengembalikannya sebagai
  /// [DeviceContextModel].
  ///
  /// Throws [Exception] dengan pesan spesifik jika salah satu data gagal
  /// diambil. Semua exception diteruskan (rethrown) agar BLoC dapat
  /// menangkapnya sebagai error state.
  Future<DeviceContextModel> getDeviceContext() async {
    try {
      // Jalankan pengambilan data device & IP secara paralel untuk efisiensi,
      // sedangkan GPS memerlukan izin yang dicek secara berurutan.
      final results = await Future.wait([
        _getDeviceInfo(),
        _getValidatedIpAddress(),
      ]);

      final deviceData = results[0] as _DeviceData;
      final ipAddress = results[1] as String;

      final position = await _getValidatedPosition();

      return DeviceContextModel(
        deviceModel: deviceData.model,
        ipAddress: ipAddress,
        latitude: position.latitude,
        longitude: position.longitude,
        deviceId: deviceData.id,
      );
    } catch (e) {
      // Rethrow agar BLoC menangkap pesan error yang sudah spesifik.
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Membaca informasi perangkat sesuai platform (Android / iOS).
  Future<_DeviceData> _getDeviceInfo() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;

      final model = androidInfo.model;
      final id = androidInfo.id;

      if (id.isEmpty) {
        throw Exception('Device ID Android tidak terdeteksi');
      }

      return _DeviceData(model: model, id: id);
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;

      final model = iosInfo.utsname.machine;
      final id = iosInfo.identifierForVendor;

      if (id == null || id.isEmpty) {
        throw Exception('Device ID iOS tidak terdeteksi');
      }

      return _DeviceData(model: model, id: id);
    } else {
      throw Exception(
        'Platform tidak didukung. Hanya Android dan iOS yang tersedia.',
      );
    }
  }

  /// Mengambil IP Wi-Fi dan memvalidasi bahwa formatnya adalah IPv4.
  Future<String> _getValidatedIpAddress() async {
    final rawIp = await _networkInfo.getWifiIP();

    // Null atau string kosong → tidak ada koneksi Wi-Fi
    if (rawIp == null || rawIp.isEmpty) {
      throw Exception(
        'Koneksi internet Wi-Fi tidak valid atau IP tidak terdeteksi',
      );
    }

    // IPv6 tidak mengandung titik '.' — tolak jika format bukan IPv4
    final isIPv4 = rawIp.contains('.');
    if (!isIPv4) {
      throw Exception(
        'Koneksi internet Wi-Fi tidak valid atau IP tidak terdeteksi',
      );
    }

    return rawIp;
  }

  /// Memvalidasi izin dan layanan GPS, lalu mengambil koordinat saat ini.
  Future<Position> _getValidatedPosition() async {
    // 1. Cek apakah layanan GPS aktif di perangkat
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw Exception('Layanan GPS perangkat belum aktif');
    }

    // 2. Cek status izin lokasi dari pengguna
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Izin akses lokasi ditolak oleh pengguna');
    }

    // 3. Ambil posisi dengan akurasi tinggi dan batas waktu 5 detik
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 5),
      ),
    );

    // 4. Validasi hasil koordinat (guard terhadap nilai tidak terduga)
    // ignore: unnecessary_null_comparison
    if (position.latitude == null || position.longitude == null) {
      throw Exception('Gagal mendapatkan koordinat lokasi yang akurat');
    }

    return position;
  }
}

// ---------------------------------------------------------------------------
// Internal DTO
// ---------------------------------------------------------------------------

/// Data Transfer Object internal untuk membawa hasil [_getDeviceInfo].
class _DeviceData {
  final String model;
  final String id;

  const _DeviceData({required this.model, required this.id});
}
