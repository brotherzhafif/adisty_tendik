import 'package:equatable/equatable.dart';
import '../data/models/presensi_hari_ini_model.dart';

abstract class PresensiHariIniState extends Equatable {
  const PresensiHariIniState();

  @override
  List<Object?> get props => [];
}

/// State awal BLoC
class PresensiHariIniInitial extends PresensiHariIniState {
  const PresensiHariIniInitial();
}

/// State ketika data sedang dimuat (loading)
class PresensiHariIniLoading extends PresensiHariIniState {
  const PresensiHariIniLoading();
}

/// State ketika data presensi hari ini berhasil dimuat
class PresensiHariIniLoaded extends PresensiHariIniState {
  final PresensiHariIniDetailModel detail;
  final List<KoreksiPengajuanModel> riwayatKoreksi;

  const PresensiHariIniLoaded({
    required this.detail,
    required this.riwayatKoreksi,
  });

  @override
  List<Object?> get props => [detail, riwayatKoreksi];
}

/// State ketika terjadi error
class PresensiHariIniError extends PresensiHariIniState {
  final String message;

  const PresensiHariIniError(this.message);

  @override
  List<Object?> get props => [message];
}
