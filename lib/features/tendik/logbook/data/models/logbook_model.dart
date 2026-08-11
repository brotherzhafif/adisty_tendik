import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

// ============================================================
// DATA MODEL: LOGBOOK SUB ACTIVITY MODEL
// ============================================================
class LogbookSubActivityModel extends Equatable {
  final String id;
  final String judul;
  final String deskripsi;
  final String? kategoriNama;

  const LogbookSubActivityModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    this.kategoriNama,
  });

  factory LogbookSubActivityModel.fromJson(Map<String, dynamic> json) {
    return LogbookSubActivityModel(
      id: json['id'] as String? ?? '',
      judul: json['judul'] as String? ?? '',
      deskripsi: json['deskripsi'] as String? ?? '',
      kategoriNama: json['kategori_nama'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'kategori_nama': kategoriNama,
    };
  }

  @override
  List<Object?> get props => [id, judul, deskripsi, kategoriNama];
}

// ============================================================
// DATA MODEL: LOGBOOK ACTIVITY MODEL
// ============================================================
class LogbookActivityModel extends Equatable {
  final String id;
  final String tanggal;
  final String bulan;
  final String hariNama;
  final String judul;
  final String deskripsi;
  final List<LogbookSubActivityModel> subAktivitas;

  const LogbookActivityModel({
    this.id = '',
    required this.tanggal,
    required this.bulan,
    required this.hariNama,
    required this.judul,
    required this.deskripsi,
    this.subAktivitas = const [],
  });

  /// Mengambil daftar sub-aktivitas jika ada, atau fallback 1 item dari judul & deskripsi
  List<LogbookSubActivityModel> get daftarSubAktivitas {
    if (subAktivitas.isNotEmpty) {
      return subAktivitas;
    }
    return [
      LogbookSubActivityModel(
        id: id,
        judul: judul,
        deskripsi: deskripsi,
      ),
    ];
  }

  factory LogbookActivityModel.fromJson(Map<String, dynamic> json) {
    return LogbookActivityModel(
      id: json['id'] as String? ?? '',
      tanggal: json['tanggal'] as String? ?? '',
      bulan: json['bulan'] as String? ?? '',
      hariNama: json['hari_nama'] as String? ?? '',
      judul: json['judul'] as String? ?? '',
      deskripsi: json['deskripsi'] as String? ?? '',
      subAktivitas: (json['sub_aktivitas'] as List<dynamic>?)
              ?.map((e) =>
                  LogbookSubActivityModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tanggal': tanggal,
      'bulan': bulan,
      'hari_nama': hariNama,
      'judul': judul,
      'deskripsi': deskripsi,
      'sub_aktivitas': subAktivitas.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props =>
      [id, tanggal, bulan, hariNama, judul, deskripsi, subAktivitas];
}

// ============================================================
// DATA MODEL: LOGBOOK BULAN DATA MODEL
// ============================================================
class LogbookBulanDataModel extends Equatable {
  final String labelBulan;
  final List<LogbookActivityModel> aktivitas;
  final int? totalSkor;
  final int maxSkor;
  final String? _kategoriRaw;

  const LogbookBulanDataModel({
    required this.labelBulan,
    required this.aktivitas,
    this.totalSkor,
    this.maxSkor = 100,
    String? kategori,
  }) : _kategoriRaw = kategori;

  bool get hasSkor => totalSkor != null;

  /// Hitung persentase progress secara dinamis berdasarkan totalSkor dan maxSkor
  int? get progressPersen {
    if (totalSkor == null || maxSkor <= 0) return null;
    return ((totalSkor! / maxSkor) * 100).round();
  }

  /// Tentukan label kategori secara dinamis dari skor jika tidak dikirim dari API
  String? get kategori {
    if (_kategoriRaw != null && _kategoriRaw.isNotEmpty) {
      return _kategoriRaw;
    }
    if (totalSkor == null) return null;
    final score = totalSkor!;
    if (score >= 85) return 'Sangat Baik';
    if (score >= 70) return 'Baik';
    if (score >= 60) return 'Cukup';
    return 'Kurang';
  }

  /// Tentukan warna UI kategori secara dinamis dari nilai skor
  Color? get kategoriColor {
    if (totalSkor == null) return null;
    final score = totalSkor!;
    if (score >= 70) {
      return const Color(0xFF4AAF57); // Hijau untuk Baik / Sangat Baik
    } else if (score >= 60) {
      return const Color(0xFFFFAC2F); // Oranye/Kuning untuk Cukup
    } else {
      return const Color(0xFFE53935); // Merah untuk Kurang
    }
  }

  /// Parsing tahun dari labelBulan (misal: "Mei 2026")
  int get year {
    final parts = labelBulan.trim().split(' ');
    if (parts.length >= 2) {
      return int.tryParse(parts.last) ?? DateTime.now().year;
    }
    return DateTime.now().year;
  }

  /// Parsing bulan dari labelBulan (misal: "Mei 2026")
  int get month {
    final parts = labelBulan.trim().split(' ');
    if (parts.isNotEmpty) {
      switch (parts.first.toLowerCase()) {
        case 'januari':
        case 'jan':
          return 1;
        case 'februari':
        case 'feb':
          return 2;
        case 'maret':
        case 'mar':
          return 3;
        case 'april':
        case 'apr':
          return 4;
        case 'mei':
          return 5;
        case 'juni':
        case 'jun':
          return 6;
        case 'juli':
        case 'jul':
          return 7;
        case 'agustus':
        case 'agu':
        case 'agt':
          return 8;
        case 'september':
        case 'sep':
          return 9;
        case 'oktober':
        case 'okt':
          return 10;
        case 'november':
        case 'nov':
          return 11;
        case 'desember':
        case 'des':
          return 12;
      }
    }
    return 1;
  }

  /// Memeriksa apakah bulan/tahun data ini melebihi [date] (tanggal acuan)
  bool isAfterDate(DateTime date) {
    if (year > date.year) return true;
    if (year == date.year && month > date.month) return true;
    return false;
  }

  factory LogbookBulanDataModel.fromJson(Map<String, dynamic> json) {
    return LogbookBulanDataModel(
      labelBulan: json['label_bulan'] as String? ?? '',
      totalSkor: json['total_skor'] as int?,
      maxSkor: json['max_skor'] as int? ?? 100,
      kategori: json['kategori'] as String?,
      aktivitas: (json['aktivitas'] as List<dynamic>?)
              ?.map((e) =>
                  LogbookActivityModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label_bulan': labelBulan,
      'total_skor': totalSkor,
      'max_skor': maxSkor,
      'kategori': _kategoriRaw,
      'aktivitas': aktivitas.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        labelBulan,
        aktivitas,
        totalSkor,
        maxSkor,
        _kategoriRaw,
      ];
}

// ============================================================
// DATA MODEL: LOGBOOK PROFILE MODEL
// ============================================================
class LogbookProfileModel extends Equatable {
  final String namaLengkap;
  final String unitKerja;
  final String jabatan;
  final String subUnit;
  final String photoUrl;

  const LogbookProfileModel({
    required this.namaLengkap,
    required this.unitKerja,
    required this.jabatan,
    required this.subUnit,
    required this.photoUrl,
  });

  const LogbookProfileModel.empty()
      : namaLengkap = '',
        unitKerja = '',
        jabatan = '',
        subUnit = '',
        photoUrl = '';

  factory LogbookProfileModel.fromJson(Map<String, dynamic> json) {
    return LogbookProfileModel(
      namaLengkap: json['nama_lengkap'] as String? ?? '',
      unitKerja: json['unit_kerja'] as String? ?? '',
      jabatan: json['jabatan'] as String? ?? '',
      subUnit: json['sub_unit'] as String? ?? '',
      photoUrl: json['photo_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_lengkap': namaLengkap,
      'unit_kerja': unitKerja,
      'jabatan': jabatan,
      'sub_unit': subUnit,
      'photo_url': photoUrl,
    };
  }

  @override
  List<Object?> get props => [
        namaLengkap,
        unitKerja,
        jabatan,
        subUnit,
        photoUrl,
      ];
}

// ============================================================
// DATA MODEL: LOGBOOK RESPONSE MODEL
// ============================================================
class LogbookResponseModel extends Equatable {
  final String status;
  final String message;
  final LogbookProfileModel profile;
  final List<LogbookBulanDataModel> dataBulan;

  const LogbookResponseModel({
    required this.status,
    required this.message,
    required this.profile,
    required this.dataBulan,
  });

  factory LogbookResponseModel.fromJson(Map<String, dynamic> json) {
    return LogbookResponseModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      profile: json['profile'] != null
          ? LogbookProfileModel.fromJson(
              json['profile'] as Map<String, dynamic>)
          : const LogbookProfileModel.empty(),
      dataBulan: (json['data_bulan'] as List<dynamic>?)
              ?.map((e) =>
                  LogbookBulanDataModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'profile': profile.toJson(),
      'data_bulan': dataBulan.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [status, message, profile, dataBulan];
}
