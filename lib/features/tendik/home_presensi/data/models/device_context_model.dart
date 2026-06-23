/// Model data yang merepresentasikan konteks perangkat.
///
/// Semua properti bersifat NON-NULLABLE karena seluruh data bersifat
/// wajib. Jika salah satu gagal diambil, [DeviceContextService] akan
/// melempar Exception sebelum objek ini terbentuk.
class DeviceContextModel {
  /// Model perangkat (contoh: "Samsung Galaxy S23", "iPhone 15 Pro")
  final String deviceModel;

  /// Alamat IP lokal dalam format IPv4 (contoh: "192.168.1.10")
  final String ipAddress;

  /// Koordinat lintang (latitude) dari GPS
  final double latitude;

  /// Koordinat bujur (longitude) dari GPS
  final double longitude;

  /// Identifier unik perangkat:
  /// - Android: `androidInfo.id`
  /// - iOS: `iosInfo.identifierForVendor`
  final String deviceId;

  const DeviceContextModel({
    required this.deviceModel,
    required this.ipAddress,
    required this.latitude,
    required this.longitude,
    required this.deviceId,
  });

  @override
  String toString() {
    return 'DeviceContextModel('
        'deviceModel: $deviceModel, '
        'ipAddress: $ipAddress, '
        'latitude: $latitude, '
        'longitude: $longitude, '
        'deviceId: $deviceId)';
  }
}
