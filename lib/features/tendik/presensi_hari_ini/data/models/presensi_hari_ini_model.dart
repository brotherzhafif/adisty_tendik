import 'package:equatable/equatable.dart';

// ============================================================
// DATA MODEL: PRESENSI HARI INI DETAIL MODEL
// ============================================================
class PresensiHariIniDetailModel extends Equatable {
  final String date;
  final String statusPresensi;
  final String location;
  final double latitude;
  final double longitude;
  final String transport;
  final String jamMasuk;
  final String jamPulang;
  final int maxHariKoreksi;

  const PresensiHariIniDetailModel({
    required this.date,
    required this.statusPresensi,
    required this.location,
    this.latitude = -7.8331,
    this.longitude = 110.3831,
    required this.transport,
    required this.jamMasuk,
    required this.jamPulang,
    this.maxHariKoreksi = 3,
  });

  const PresensiHariIniDetailModel.empty()
    : date = '',
      statusPresensi = '',
      location = '',
      latitude = -7.8331,
      longitude = 110.3831,
      transport = '',
      jamMasuk = '',
      jamPulang = '',
      maxHariKoreksi = 3;

  factory PresensiHariIniDetailModel.fromJson(Map<String, dynamic> json) {
    return PresensiHariIniDetailModel(
      date: json['date'] as String? ?? '',
      statusPresensi: json['status_presensi'] as String? ?? '',
      location: json['location'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? -7.8331,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 110.3831,
      transport: json['transport'] as String? ?? '',
      jamMasuk: json['jam_masuk'] as String? ?? '',
      jamPulang: json['jam_pulang'] as String? ?? '',
      maxHariKoreksi: json['max_hari_koreksi'] as int? ?? 3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'status_presensi': statusPresensi,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'transport': transport,
      'jam_masuk': jamMasuk,
      'jam_pulang': jamPulang,
      'max_hari_koreksi': maxHariKoreksi,
    };
  }

  @override
  List<Object?> get props => [
    date,
    statusPresensi,
    location,
    latitude,
    longitude,
    transport,
    jamMasuk,
    jamPulang,
    maxHariKoreksi,
  ];
}

// ============================================================
// DATA MODEL: KOREKSI PENGAJUAN MODEL
// ============================================================
class KoreksiPengajuanModel extends Equatable {
  final String id;
  final String status;
  final String date;
  final String type;
  final String diajukan;
  final String perubahanLabel;
  final String oldValue;
  final String newValue;
  final String? alasan;
  final String? catatanVerifikator;

  const KoreksiPengajuanModel({
    required this.id,
    required this.status,
    required this.date,
    required this.type,
    required this.diajukan,
    required this.perubahanLabel,
    required this.oldValue,
    required this.newValue,
    this.alasan,
    this.catatanVerifikator,
  });

  factory KoreksiPengajuanModel.fromJson(Map<String, dynamic> json) {
    return KoreksiPengajuanModel(
      id: json['id'] as String? ?? '',
      status: json['status'] as String? ?? 'menunggu',
      date: json['date'] as String? ?? '',
      type: json['type'] as String? ?? 'Presensi',
      diajukan: json['diajukan'] as String? ?? '',
      perubahanLabel: json['perubahan_label'] as String? ?? '',
      oldValue: json['old_value'] as String? ?? '-',
      newValue: json['new_value'] as String? ?? '-',
      alasan: json['alasan'] as String?,
      catatanVerifikator: json['catatan_verifikator'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'date': date,
      'type': type,
      'diajukan': diajukan,
      'perubahan_label': perubahanLabel,
      'old_value': oldValue,
      'new_value': newValue,
      'alasan': alasan,
      'catatan_verifikator': catatanVerifikator,
    };
  }

  @override
  List<Object?> get props => [
    id,
    status,
    date,
    type,
    diajukan,
    perubahanLabel,
    oldValue,
    newValue,
    alasan,
    catatanVerifikator,
  ];
}

// ============================================================
// DATA MODEL: PRESENSI HARI INI RESPONSE MODEL
// ============================================================
class PresensiHariIniResponseModel extends Equatable {
  final String status;
  final String message;
  final PresensiHariIniDetailModel detail;
  final List<KoreksiPengajuanModel> riwayatKoreksi;

  const PresensiHariIniResponseModel({
    required this.status,
    required this.message,
    required this.detail,
    required this.riwayatKoreksi,
  });

  factory PresensiHariIniResponseModel.fromJson(Map<String, dynamic> json) {
    return PresensiHariIniResponseModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      detail: json['detail'] != null
          ? PresensiHariIniDetailModel.fromJson(
              json['detail'] as Map<String, dynamic>,
            )
          : const PresensiHariIniDetailModel.empty(),
      riwayatKoreksi:
          (json['riwayat_koreksi'] as List<dynamic>?)
              ?.map(
                (e) =>
                    KoreksiPengajuanModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'detail': detail.toJson(),
      'riwayat_koreksi': riwayatKoreksi.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [status, message, detail, riwayatKoreksi];
}
