import 'package:equatable/equatable.dart';

abstract class PresensiHariIniEvent extends Equatable {
  const PresensiHariIniEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk mengambil data presensi hari ini pertama kali
class FetchPresensiHariIniEvent extends PresensiHariIniEvent {
  const FetchPresensiHariIniEvent();
}

/// Event untuk memperbarui / pull-to-refresh data presensi hari ini
class RefreshPresensiHariIniEvent extends PresensiHariIniEvent {
  const RefreshPresensiHariIniEvent();
}
