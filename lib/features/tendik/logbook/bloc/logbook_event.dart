import 'package:equatable/equatable.dart';

abstract class LogbookEvent extends Equatable {
  const LogbookEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk mengambil data logbook pertama kali
class FetchLogbookEvent extends LogbookEvent {
  const FetchLogbookEvent();
}

/// Event untuk memperbarui / pull-to-refresh data logbook
class RefreshLogbookEvent extends LogbookEvent {
  const RefreshLogbookEvent();
}

/// Event ketika pengguna mengubah pilihan bulan logbook pada UI
class ChangeBulanLogbookEvent extends LogbookEvent {
  final int activeBulanIndex;

  const ChangeBulanLogbookEvent(this.activeBulanIndex);

  @override
  List<Object?> get props => [activeBulanIndex];
}
