import 'package:equatable/equatable.dart';

abstract class SkpEvent extends Equatable {
  const SkpEvent();

  @override
  List<Object?> get props => [];
}

/// Event untuk mengambil data SKP pegawai pertama kali
class FetchSkpEvent extends SkpEvent {
  const FetchSkpEvent();
}

/// Event untuk memperbarui / pull-to-refresh data SKP
class RefreshSkpEvent extends SkpEvent {
  const RefreshSkpEvent();
}

/// Event ketika pengguna mengubah pilihan tahun evaluasi pada UI
class ChangeYearSkpEvent extends SkpEvent {
  final int activeYearIndex;

  const ChangeYearSkpEvent(this.activeYearIndex);

  @override
  List<Object?> get props => [activeYearIndex];
}
