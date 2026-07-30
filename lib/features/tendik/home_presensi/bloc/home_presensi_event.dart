import 'package:equatable/equatable.dart';

abstract class HomePresensiEvent extends Equatable {
  const HomePresensiEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk mengambil data awal Home Presensi
class FetchHomePresensiEvent extends HomePresensiEvent {
  const FetchHomePresensiEvent();
}

/// Event untuk memperbarui / pull-to-refresh data Home Presensi
class RefreshHomePresensiEvent extends HomePresensiEvent {
  const RefreshHomePresensiEvent();
}

/// Event untuk memajukan alur status presensi (Belum Presensi -> Shift 1 Selesai -> Pulang)
class AdvancePresensiStateEvent extends HomePresensiEvent {
  const AdvancePresensiStateEvent();
}

/// Event untuk mereset status presensi kembali ke Belum Presensi
class ResetPresensiStateEvent extends HomePresensiEvent {
  const ResetPresensiStateEvent();
}

/// Event untuk mengumpulkan konteks data perangkat (GPS, IP, Device ID)
class FetchDeviceContextEvent extends HomePresensiEvent {
  const FetchDeviceContextEvent();
}
