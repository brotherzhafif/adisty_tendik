import 'package:equatable/equatable.dart';
import '../data/models/logbook_model.dart';

abstract class LogbookState extends Equatable {
  const LogbookState();

  @override
  List<Object?> get props => [];
}

/// State awal BLoC
class LogbookInitial extends LogbookState {
  const LogbookInitial();
}

/// State ketika data Logbook sedang dimuat (loading)
class LogbookLoading extends LogbookState {
  const LogbookLoading();
}

/// State ketika data Logbook berhasil dimuat
class LogbookLoaded extends LogbookState {
  final LogbookProfileModel profile;
  final List<LogbookBulanDataModel> dataBulan;
  final int bulanIndex;

  const LogbookLoaded({
    required this.profile,
    required this.dataBulan,
    required this.bulanIndex,
  });

  /// Getter penolong untuk mengambil data bulan yang sedang aktif dipilih pengguna
  LogbookBulanDataModel get currentBulanData {
    if (dataBulan.isEmpty || bulanIndex < 0 || bulanIndex >= dataBulan.length) {
      return const LogbookBulanDataModel(labelBulan: '', aktivitas: []);
    }
    return dataBulan[bulanIndex];
  }

  LogbookLoaded copyWith({
    LogbookProfileModel? profile,
    List<LogbookBulanDataModel>? dataBulan,
    int? bulanIndex,
  }) {
    return LogbookLoaded(
      profile: profile ?? this.profile,
      dataBulan: dataBulan ?? this.dataBulan,
      bulanIndex: bulanIndex ?? this.bulanIndex,
    );
  }

  @override
  List<Object?> get props => [profile, dataBulan, bulanIndex];
}

/// State ketika terjadi error saat memuat data Logbook
class LogbookError extends LogbookState {
  final String message;

  const LogbookError(this.message);

  @override
  List<Object?> get props => [message];
}
