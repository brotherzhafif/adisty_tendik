import 'package:equatable/equatable.dart';
import '../data/models/skp_model.dart';

abstract class SkpState extends Equatable {
  const SkpState();

  @override
  List<Object?> get props => [];
}

/// State awal BLoC
class SkpInitial extends SkpState {
  const SkpInitial();
}

/// State ketika data SKP sedang dimuat (loading)
class SkpLoading extends SkpState {
  const SkpLoading();
}

/// State ketika data SKP berhasil dimuat
class SkpLoaded extends SkpState {
  final SkpProfileModel profile;
  final List<String> years;
  final int activeYearIndex;
  final Map<String, SkpYearDataModel> skpData;

  const SkpLoaded({
    required this.profile,
    required this.years,
    required this.activeYearIndex,
    required this.skpData,
  });

  /// Getter penolong untuk mengambil data tahun yang sedang aktif dipiliih pengguna
  SkpYearDataModel get currentYearData {
    if (years.isEmpty || activeYearIndex < 0 || activeYearIndex >= years.length) {
      return const SkpYearDataModel.empty();
    }
    final year = years[activeYearIndex];
    return skpData[year] ?? const SkpYearDataModel.empty();
  }

  SkpLoaded copyWith({
    SkpProfileModel? profile,
    List<String>? years,
    int? activeYearIndex,
    Map<String, SkpYearDataModel>? skpData,
  }) {
    return SkpLoaded(
      profile: profile ?? this.profile,
      years: years ?? this.years,
      activeYearIndex: activeYearIndex ?? this.activeYearIndex,
      skpData: skpData ?? this.skpData,
    );
  }

  @override
  List<Object?> get props => [profile, years, activeYearIndex, skpData];
}

/// State ketika terjadi error saat memuat data SKP
class SkpError extends SkpState {
  final String message;

  const SkpError(this.message);

  @override
  List<Object?> get props => [message];
}
