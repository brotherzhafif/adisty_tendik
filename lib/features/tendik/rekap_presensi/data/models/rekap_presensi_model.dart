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
      badges: (json['badges'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      location: json['location'] as String? ?? '',
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
        transport,
        masuk,
        pulang,
        durasi,
        catatan,
      ];
}

// ============================================================
// DATA MODEL: REKAP PRESENSI RESPONSE MODEL
// ============================================================
class RekapPresensiResponseModel extends Equatable {
  final String status;
  final String message;
  final String totalTransport;
  final String totalJam;
  final List<PresensiLogModel> logs;

  const RekapPresensiResponseModel({
    required this.status,
    required this.message,
    required this.totalTransport,
    required this.totalJam,
    required this.logs,
  });

  factory RekapPresensiResponseModel.fromJson(Map<String, dynamic> json) {
    return RekapPresensiResponseModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      totalTransport: json['total_transport'] as String? ?? '0',
      totalJam: json['total_jam'] as String? ?? '00:00',
      logs: (json['logs'] as List<dynamic>?)
              ?.map((e) => PresensiLogModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'total_transport': totalTransport,
      'total_jam': totalJam,
      'logs': logs.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [status, message, totalTransport, totalJam, logs];
}
