import 'package:equatable/equatable.dart';

// ============================================================
// DATA MODEL: SKP INDICATOR MODEL
// ============================================================
class SkpIndicatorModel extends Equatable {
  final String name;
  final double score;

  const SkpIndicatorModel({required this.name, required this.score});

  factory SkpIndicatorModel.fromJson(Map<String, dynamic> json) {
    return SkpIndicatorModel(
      name: json['name'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'score': score};
  }

  @override
  List<Object?> get props => [name, score];
}

// ============================================================
// DATA MODEL: SKP YEAR DATA MODEL
// ============================================================
class SkpYearDataModel extends Equatable {
  final double aikScore;
  final double tugasUmumScore;
  final double penunjangScore;
  final List<SkpIndicatorModel> aikIndicators;
  final List<SkpIndicatorModel> tugasUmumIndicators;
  final List<SkpIndicatorModel> penunjangIndicators;
  final String? dinilaiOlehNama;
  final String? dinilaiOlehPosisi;

  double get totalSkpScore =>
      (aikScore * 0.35) + (tugasUmumScore * 0.40) + (penunjangScore * 0.25);

  const SkpYearDataModel({
    required this.aikScore,
    required this.tugasUmumScore,
    required this.penunjangScore,
    required this.aikIndicators,
    required this.tugasUmumIndicators,
    required this.penunjangIndicators,
    this.dinilaiOlehNama,
    this.dinilaiOlehPosisi,
  });

  const SkpYearDataModel.empty()
    : aikScore = 0.0,
      tugasUmumScore = 0.0,
      penunjangScore = 0.0,
      aikIndicators = const [],
      tugasUmumIndicators = const [],
      penunjangIndicators = const [],
      dinilaiOlehNama = null,
      dinilaiOlehPosisi = null;

  factory SkpYearDataModel.fromJson(Map<String, dynamic> json) {
    return SkpYearDataModel(
      aikScore: (json['aik_score'] as num?)?.toDouble() ?? 0.0,
      tugasUmumScore: (json['tugas_umum_score'] as num?)?.toDouble() ?? 0.0,
      penunjangScore: (json['penunjang_score'] as num?)?.toDouble() ?? 0.0,
      dinilaiOlehNama: json['dinilai_oleh'] != null
          ? json['dinilai_oleh']['nama'] as String?
          : null,
      dinilaiOlehPosisi: json['dinilai_oleh'] != null
          ? json['dinilai_oleh']['posisi'] as String?
          : null,
      aikIndicators:
          (json['aik_indicators'] as List<dynamic>?)
              ?.map(
                (e) => SkpIndicatorModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      tugasUmumIndicators:
          (json['tugas_umum_indicators'] as List<dynamic>?)
              ?.map(
                (e) => SkpIndicatorModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      penunjangIndicators:
          (json['penunjang_indicators'] as List<dynamic>?)
              ?.map(
                (e) => SkpIndicatorModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aik_score': aikScore,
      'tugas_umum_score': tugasUmumScore,
      'penunjang_score': penunjangScore,
      if (dinilaiOlehNama != null || dinilaiOlehPosisi != null)
        'dinilai_oleh': {'nama': dinilaiOlehNama, 'posisi': dinilaiOlehPosisi},
      'aik_indicators': aikIndicators.map((e) => e.toJson()).toList(),
      'tugas_umum_indicators': tugasUmumIndicators
          .map((e) => e.toJson())
          .toList(),
      'penunjang_indicators': penunjangIndicators
          .map((e) => e.toJson())
          .toList(),
    };
  }

  @override
  List<Object?> get props => [
    aikScore,
    tugasUmumScore,
    penunjangScore,
    aikIndicators,
    tugasUmumIndicators,
    penunjangIndicators,
    dinilaiOlehNama,
    dinilaiOlehPosisi,
  ];
}

// ============================================================
// DATA MODEL: SKP PROFILE MODEL
// ============================================================
class SkpProfileModel extends Equatable {
  final String name;
  final String department;
  final String role;
  final String avatarUrl;

  const SkpProfileModel({
    required this.name,
    required this.department,
    required this.role,
    required this.avatarUrl,
  });

  const SkpProfileModel.empty()
    : name = '',
      department = '',
      role = '',
      avatarUrl = '';

  factory SkpProfileModel.fromJson(Map<String, dynamic> json) {
    return SkpProfileModel(
      name: json['name'] as String? ?? '',
      department: json['department'] as String? ?? '',
      role: json['role'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'department': department,
      'role': role,
      'avatar_url': avatarUrl,
    };
  }

  @override
  List<Object?> get props => [name, department, role, avatarUrl];
}

// ============================================================
// DATA MODEL: SKP RESPONSE MODEL
// ============================================================
class SkpResponseModel extends Equatable {
  final String status;
  final String message;
  final SkpProfileModel profile;
  final List<String> years;
  final Map<String, SkpYearDataModel> skpData;

  const SkpResponseModel({
    required this.status,
    required this.message,
    required this.profile,
    required this.years,
    required this.skpData,
  });

  factory SkpResponseModel.fromJson(Map<String, dynamic> json) {
    final rawSkpData = json['skp_data'] as Map<String, dynamic>? ?? {};
    final Map<String, SkpYearDataModel> parsedSkpData = {};
    rawSkpData.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        parsedSkpData[key] = SkpYearDataModel.fromJson(value);
      }
    });

    return SkpResponseModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      profile: json['profile'] != null
          ? SkpProfileModel.fromJson(json['profile'] as Map<String, dynamic>)
          : const SkpProfileModel.empty(),
      years:
          (json['years'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      skpData: parsedSkpData,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonSkpData = {};
    skpData.forEach((key, value) {
      jsonSkpData[key] = value.toJson();
    });

    return {
      'status': status,
      'message': message,
      'profile': profile.toJson(),
      'years': years,
      'skp_data': jsonSkpData,
    };
  }

  @override
  List<Object?> get props => [status, message, profile, years, skpData];
}
