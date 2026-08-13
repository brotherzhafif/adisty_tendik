import 'package:equatable/equatable.dart';

// ============================================================
// DATA MODEL: PRESENSI LOG MODEL
// ============================================================
class PresensiLogModel extends Equatable {
  final String id;
  final String date;
  final String dayName;
  final String dayNum;
  final String status;
  final List<String> badges;
  final String location;
  final double latitude;
  final double longitude;
  final String transport;
  final String masuk;
  final String pulang;
  final String durasi;
  final String catatan;

  const PresensiLogModel({
    required this.id,
    required this.date,
    required this.dayName,
    required this.dayNum,
    required this.status,
    required this.badges,
    required this.location,
    this.latitude = -7.8331,
    this.longitude = 110.3831,
    required this.transport,
    required this.masuk,
    required this.pulang,
    required this.durasi,
    this.catatan = '-',
  });

  factory PresensiLogModel.fromJson(Map<String, dynamic> json) {
    return PresensiLogModel(
      id: json['id'] as String? ?? '',
      date: json['date'] as String? ?? '',
      dayName: json['day_name'] as String? ?? '',
      dayNum: json['day_num'] as String? ?? '',
      status: json['status'] as String? ?? '',
      badges:
          (json['badges'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      location: json['location'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? -7.8331,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 110.3831,
      transport: json['transport'] as String? ?? '',
      masuk: json['masuk'] as String? ?? '',
      pulang: json['pulang'] as String? ?? '',
      durasi: json['durasi'] as String? ?? '',
      catatan: json['catatan'] as String? ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'day_name': dayName,
      'day_num': dayNum,
      'status': status,
      'badges': badges,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'transport': transport,
      'masuk': masuk,
      'pulang': pulang,
      'durasi': durasi,
      'catatan': catatan,
    };
  }

  @override
  List<Object?> get props => [
    id,
    date,
    dayName,
    dayNum,
    status,
    badges,
    location,
    latitude,
    longitude,
    transport,
    masuk,
    pulang,
    durasi,
    catatan,
  ];
}

// ============================================================
// DATA MODEL: REKAP BULAN DATA MODEL
// ============================================================
class RekapBulanDataModel extends Equatable {
  final String labelBulan;
  final int month;
  final int year;
  final int totalHariKerja;
  final int persentase;
  final int onTime;
  final int late;
  final int absen;
  final String totalTransport;
  final String totalJam;
  final List<PresensiLogModel> logs;

  const RekapBulanDataModel({
    required this.labelBulan,
    required this.month,
    required this.year,
    required this.totalHariKerja,
    required this.persentase,
    required this.onTime,
    required this.late,
    required this.absen,
    required this.totalTransport,
    required this.totalJam,
    required this.logs,
  });

  bool isAfterDate(DateTime date) {
    if (year > date.year) return true;
    if (year == date.year && month > date.month) return true;
    return false;
  }

  factory RekapBulanDataModel.fromJson(Map<String, dynamic> json) {
    return RekapBulanDataModel(
      labelBulan: json['label_bulan'] as String? ?? '',
      month: (json['month'] as num?)?.toInt() ?? 10,
      year: (json['year'] as num?)?.toInt() ?? 2026,
      totalHariKerja: (json['total_hari_kerja'] as num?)?.toInt() ?? 20,
      persentase: (json['persentase'] as num?)?.toInt() ?? 90,
      onTime: (json['on_time'] as num?)?.toInt() ?? 12,
      late: (json['late'] as num?)?.toInt() ?? 3,
      absen: (json['absen'] as num?)?.toInt() ?? 2,
      totalTransport: json['total_transport'] as String? ?? '0',
      totalJam: json['total_jam'] as String? ?? '00:00',
      logs:
          (json['logs'] as List<dynamic>?)
              ?.map((e) => PresensiLogModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label_bulan': labelBulan,
      'month': month,
      'year': year,
      'total_hari_kerja': totalHariKerja,
      'persentase': persentase,
      'on_time': onTime,
      'late': late,
      'absen': absen,
      'total_transport': totalTransport,
      'total_jam': totalJam,
      'logs': logs.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
    labelBulan,
    month,
    year,
    totalHariKerja,
    persentase,
    onTime,
    late,
    absen,
    totalTransport,
    totalJam,
    logs,
  ];
}

// ============================================================
// DATA MODEL: REKAP PRESENSI RESPONSE MODEL
// ============================================================
class RekapPresensiResponseModel extends Equatable {
  final String status;
  final String message;
  final List<RekapBulanDataModel> dataBulan;

  const RekapPresensiResponseModel({
    required this.status,
    required this.message,
    required this.dataBulan,
  });

  factory RekapPresensiResponseModel.fromJson(Map<String, dynamic> json) {
    List<RekapBulanDataModel> parsedBulan = [];
    if (json.containsKey('data_bulan') && json['data_bulan'] is List) {
      parsedBulan = (json['data_bulan'] as List<dynamic>)
          .map((e) => RekapBulanDataModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      final logs =
          (json['logs'] as List<dynamic>?)
              ?.map((e) => PresensiLogModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [];
      parsedBulan = [
        RekapBulanDataModel(
          labelBulan: 'Oktober 2026',
          month: 10,
          year: 2026,
          totalHariKerja: 20,
          persentase: 90,
          onTime: 12,
          late: 3,
          absen: 2,
          totalTransport: json['total_transport'] as String? ?? '450.000',
          totalJam: json['total_jam'] as String? ?? '150:00',
          logs: logs,
        ),
      ];
    }

    return RekapPresensiResponseModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      dataBulan: parsedBulan,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data_bulan': dataBulan.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [status, message, dataBulan];
}
