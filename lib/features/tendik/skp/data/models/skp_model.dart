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
// DATA MODEL: SKP CATEGORY MODEL (DYNAMIC CATEGORY)
// ============================================================
class SkpCategoryModel extends Equatable {
  final String title;
  final String weight;
  final String subTitle;
  final double score;
  final String summaryTitle;
  final List<SkpIndicatorModel> indicators;

  const SkpCategoryModel({
    required this.title,
    required this.weight,
    required this.subTitle,
    required this.score,
    required this.summaryTitle,
    required this.indicators,
  });

  factory SkpCategoryModel.fromJson(Map<String, dynamic> json) {
    return SkpCategoryModel(
      title: json['title'] as String? ?? json['name'] as String? ?? '',
      weight: json['weight'] as String? ?? '',
      subTitle:
          json['sub_title'] as String? ?? json['description'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      summaryTitle:
          json['summary_title'] as String? ??
          'SKOR ${json['title'] ?? json['name'] ?? ''}',
      indicators:
          (json['indicators'] as List<dynamic>?)
              ?.map(
                (e) => SkpIndicatorModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'weight': weight,
      'sub_title': subTitle,
      'score': score,
      'summary_title': summaryTitle,
      'indicators': indicators.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
    title,
    weight,
    subTitle,
    score,
    summaryTitle,
    indicators,
  ];
}

// ============================================================
// DATA MODEL: SKP YEAR DATA MODEL
// ============================================================
class SkpYearDataModel extends Equatable {
  final List<SkpCategoryModel> categories;
  final String? dinilaiOlehNama;
  final String? dinilaiOlehPosisi;

  // Legacy compatibility getters
  double get aikScore => categories.isNotEmpty ? categories[0].score : 0.0;
  double get tugasUmumScore => categories.length > 1 ? categories[1].score : 0.0;
  double get penunjangScore => categories.length > 2 ? categories[2].score : 0.0;
  List<SkpIndicatorModel> get aikIndicators =>
      categories.isNotEmpty ? categories[0].indicators : const [];
  List<SkpIndicatorModel> get tugasUmumIndicators =>
      categories.length > 1 ? categories[1].indicators : const [];
  List<SkpIndicatorModel> get penunjangIndicators =>
      categories.length > 2 ? categories[2].indicators : const [];

  int get jumlahKategori => categories.length;

  double get totalSkpScore {
    if (categories.isEmpty) return 0.0;
    double weightedSum = 0.0;
    double totalWeight = 0.0;

    for (final cat in categories) {
      final regex = RegExp(r'(\d+(?:\.\d+)?)');
      final match = regex.firstMatch(cat.weight);
      if (match != null) {
        final val = double.tryParse(match.group(1)!) ?? 0.0;
        weightedSum += cat.score * (val / 100.0);
        totalWeight += val;
      }
    }

    if (totalWeight > 0) {
      return weightedSum * (100.0 / totalWeight);
    }

    final sum = categories.fold<double>(0.0, (prev, c) => prev + c.score);
    return sum / categories.length;
  }

  bool get hasData => categories.isNotEmpty;

  const SkpYearDataModel({
    required this.categories,
    this.dinilaiOlehNama,
    this.dinilaiOlehPosisi,
  });

  const SkpYearDataModel.empty()
    : categories = const [],
      dinilaiOlehNama = null,
      dinilaiOlehPosisi = null;

  factory SkpYearDataModel.fromJson(Map<String, dynamic> json) {
    final List<SkpCategoryModel> parsedCategories = [];

    if (json['categories'] != null && json['categories'] is List) {
      for (final item in json['categories'] as List<dynamic>) {
        if (item is Map<String, dynamic>) {
          parsedCategories.add(SkpCategoryModel.fromJson(item));
        }
      }
    } else {
      // Fallback for legacy format (aik_indicators, tugas_umum_indicators, penunjang_indicators)
      if (json['aik_indicators'] != null || json['aik_score'] != null) {
        parsedCategories.add(
          SkpCategoryModel(
            title: 'Pengamalan AIK',
            weight: ' (35%)',
            subTitle: 'Pengamalan Al Islam dan Kemuhammadiyahan',
            score: (json['aik_score'] as num?)?.toDouble() ?? 0.0,
            summaryTitle: 'SKOR Pengamalan AIK',
            indicators:
                (json['aik_indicators'] as List<dynamic>?)
                    ?.map(
                      (e) =>
                          SkpIndicatorModel.fromJson(e as Map<String, dynamic>),
                    )
                    .toList() ??
                const [],
          ),
        );
      }

      if (json['tugas_umum_indicators'] != null ||
          json['tugas_umum_score'] != null) {
        parsedCategories.add(
          SkpCategoryModel(
            title: 'Tugas Utama',
            weight: ' (40%)',
            subTitle: 'Melaksanakan Tugas Utama Tenaga Kependidikan',
            score: (json['tugas_umum_score'] as num?)?.toDouble() ?? 0.0,
            summaryTitle: 'SKOR Tugas Utama',
            indicators:
                (json['tugas_umum_indicators'] as List<dynamic>?)
                    ?.map(
                      (e) =>
                          SkpIndicatorModel.fromJson(e as Map<String, dynamic>),
                    )
                    .toList() ??
                const [],
          ),
        );
      }

      if (json['penunjang_indicators'] != null ||
          json['penunjang_score'] != null) {
        parsedCategories.add(
          SkpCategoryModel(
            title: 'Penunjang',
            weight: ' (25%)',
            subTitle: 'Melaksanakan Aktivitas Penunjang Tenaga Kependidikan',
            score: (json['penunjang_score'] as num?)?.toDouble() ?? 0.0,
            summaryTitle: 'SKOR Penunjang',
            indicators:
                (json['penunjang_indicators'] as List<dynamic>?)
                    ?.map(
                      (e) =>
                          SkpIndicatorModel.fromJson(e as Map<String, dynamic>),
                    )
                    .toList() ??
                const [],
          ),
        );
      }
    }

    return SkpYearDataModel(
      categories: parsedCategories,
      dinilaiOlehNama: json['dinilai_oleh'] != null
          ? json['dinilai_oleh']['nama'] as String?
          : null,
      dinilaiOlehPosisi: json['dinilai_oleh'] != null
          ? json['dinilai_oleh']['posisi'] as String?
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((e) => e.toJson()).toList(),
      if (dinilaiOlehNama != null || dinilaiOlehPosisi != null)
        'dinilai_oleh': {'nama': dinilaiOlehNama, 'posisi': dinilaiOlehPosisi},
    };
  }

  @override
  List<Object?> get props => [categories, dinilaiOlehNama, dinilaiOlehPosisi];
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
