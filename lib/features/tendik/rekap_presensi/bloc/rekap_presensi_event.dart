import 'package:equatable/equatable.dart';

abstract class RekapPresensiEvent extends Equatable {
  const RekapPresensiEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk mengambil data rekap presensi pertama kali
class FetchRekapPresensiEvent extends RekapPresensiEvent {
  const FetchRekapPresensiEvent();
}

/// Event untuk memperbarui/refresh data rekap presensi (misal pull to refresh)
class RefreshRekapPresensiEvent extends RekapPresensiEvent {
  const RefreshRekapPresensiEvent();
}
