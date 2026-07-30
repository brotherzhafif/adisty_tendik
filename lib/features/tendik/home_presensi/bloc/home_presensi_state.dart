import 'package:equatable/equatable.dart';
import '../data/models/device_context_model.dart';
import '../data/models/home_presensi_model.dart';
import '../presentation/widgets/presensi_state.dart';

abstract class HomePresensiState extends Equatable {
  const HomePresensiState();

  @override
  List<Object?> get props => [];
}

/// State awal BLoC
class HomePresensiInitial extends HomePresensiState {
  const HomePresensiInitial();
}

/// State ketika data sedang dimuat (loading)
class HomePresensiLoading extends HomePresensiState {
  const HomePresensiLoading();
}

/// State ketika data Home Presensi berhasil dimuat
class HomePresensiLoaded extends HomePresensiState {
  final HomeProfileModel profile;
  final HomePresensiTodayModel presensiToday;
  final PresensiState presensiState;
  final DeviceContextModel? deviceContext;
  final String? deviceContextError;

  const HomePresensiLoaded({
    required this.profile,
    required this.presensiToday,
    this.presensiState = PresensiState.belumPresensi,
    this.deviceContext,
    this.deviceContextError,
  });

  HomePresensiLoaded copyWith({
    HomeProfileModel? profile,
    HomePresensiTodayModel? presensiToday,
    PresensiState? presensiState,
    DeviceContextModel? deviceContext,
    String? deviceContextError,
  }) {
    return HomePresensiLoaded(
      profile: profile ?? this.profile,
      presensiToday: presensiToday ?? this.presensiToday,
      presensiState: presensiState ?? this.presensiState,
      deviceContext: deviceContext ?? this.deviceContext,
      deviceContextError: deviceContextError ?? this.deviceContextError,
    );
  }

  @override
  List<Object?> get props => [
        profile,
        presensiToday,
        presensiState,
        deviceContext,
        deviceContextError,
      ];
}

/// State ketika terjadi error saat memuat data utama
class HomePresensiError extends HomePresensiState {
  final String message;

  const HomePresensiError(this.message);

  @override
  List<Object?> get props => [message];
}
