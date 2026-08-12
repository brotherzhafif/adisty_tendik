class MonitoringPegawaiModel {
  final String id;
  final String nama;
  final String unit;
  final String jabatan;
  final String lokasi;
  final String status;
  final String masuk;
  final String pulang;
  final String photoUrl;
  final String? alasanKoreksi;

  const MonitoringPegawaiModel({
    required this.id,
    required this.nama,
    required this.unit,
    required this.jabatan,
    required this.lokasi,
    required this.status,
    required this.masuk,
    required this.pulang,
    required this.photoUrl,
    this.alasanKoreksi,
  });

  factory MonitoringPegawaiModel.fromJson(Map<String, dynamic> json) {
    return MonitoringPegawaiModel(
      id: json['id'] ?? '',
      nama: json['nama'] ?? '',
      unit: json['unit'] ?? '',
      jabatan: json['jabatan'] ?? '',
      lokasi: json['lokasi'] ?? '',
      status: json['status'] ?? 'On Time',
      masuk: json['masuk'] ?? '-.-',
      pulang: json['pulang'] ?? '-.-',
      photoUrl: json['photo_url'] ?? 'https://placehold.co/64x64',
      alasanKoreksi: json['alasan_koreksi'],
    );
  }
}

class MonitoringTanggalModel {
  final String id;
  final String hariNama;
  final String tanggalLengkap;
  final String labelTanggal;
  final List<MonitoringPegawaiModel> pegawai;

  const MonitoringTanggalModel({
    required this.id,
    required this.hariNama,
    required this.tanggalLengkap,
    required this.labelTanggal,
    required this.pegawai,
  });

  factory MonitoringTanggalModel.fromJson(Map<String, dynamic> json) {
    return MonitoringTanggalModel(
      id: json['id'] ?? '',
      hariNama: json['hari_nama'] ?? '',
      tanggalLengkap: json['tanggal_lengkap'] ?? '',
      labelTanggal: json['label_tanggal'] ?? '',
      pegawai: (json['pegawai'] as List<dynamic>?)
              ?.map((e) => MonitoringPegawaiModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
