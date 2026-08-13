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
  final List<RekapBulanDataModel> dataBulan;
  final int bulanIndex;

  const RekapPresensiLoaded({required this.dataBulan, this.bulanIndex = 0});

  RekapBulanDataModel get currentBulanData =>
      dataBulan.isNotEmpty && bulanIndex >= 0 && bulanIndex < dataBulan.length
      ? dataBulan[bulanIndex]
      : const RekapBulanDataModel(
          labelBulan: 'Oktober 2026',
          month: 10,
          year: 2026,
          totalHariKerja: 0,
          persentase: 0,
          onTime: 0,
          late: 0,
          absen: 0,
          totalTransport: '0',
          totalJam: '00:00',
          logs: [],
        );

  RekapPresensiLoaded copyWith({
    List<RekapBulanDataModel>? dataBulan,
    int? bulanIndex,
  }) {
    return RekapPresensiLoaded(
      dataBulan: dataBulan ?? this.dataBulan,
      bulanIndex: bulanIndex ?? this.bulanIndex,
    );
  }

  @override
  List<Object?> get props => [dataBulan, bulanIndex];
}

/// State ketika terjadi error
class RekapPresensiError extends RekapPresensiState {
  final String message;

  const RekapPresensiError(this.message);

  @override
  List<Object?> get props => [message];
}
