import 'package:equatable/equatable.dart';
import '../data/models/rekap_presensi_model.dart';

abstract class RekapPresensiState extends Equatable {
  const RekapPresensiState();

  @override
  List<Object?> get props => [];
}

/// State awal BLoC
class RekapPresensiInitial extends RekapPresensiState {
  const RekapPresensiInitial();
}

/// State ketika data sedang dalam proses pengambilan (loading)
class RekapPresensiLoading extends RekapPresensiState {
  const RekapPresensiLoading();
}

/// State ketika data berhasil diambil
class RekapPresensiLoaded extends RekapPresensiState {
  final String totalTransport;
  final String totalJam;
  final List<PresensiLogModel> logs;

  const RekapPresensiLoaded({
    required this.totalTransport,
    required this.totalJam,
    required this.logs,
  });

  @override
  List<Object?> get props => [totalTransport, totalJam, logs];
}

/// State ketika terjadi error
class RekapPresensiError extends RekapPresensiState {
  final String message;

  const RekapPresensiError(this.message);

  @override
  List<Object?> get props => [message];
}
