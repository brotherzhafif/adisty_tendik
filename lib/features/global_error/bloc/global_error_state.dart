import 'package:equatable/equatable.dart';

abstract class GlobalErrorState extends Equatable {
  const GlobalErrorState();

  @override
  List<Object?> get props => [];
}

/// State awal sebelum data error di-passing
class GlobalErrorInitial extends GlobalErrorState {}

/// State yang menampung detail error untuk ditampilkan di UI
class GlobalErrorDisplay extends GlobalErrorState {
  final String message;
  final int statusCode;
  final Future<void> Function() onRetry;

  const GlobalErrorDisplay({
    required this.message,
    required this.statusCode,
    required this.onRetry,
  });

  @override
  List<Object?> get props => [message, statusCode, onRetry];
}

/// State saat proses retry sedang berjalan (menampilkan loading ring)
class GlobalErrorRetryLoading extends GlobalErrorState {}

/// State jika proses retry berhasil (UI akan otomatis pop/kembali ke halaman sebelumnya)
class GlobalErrorRetrySuccess extends GlobalErrorState {}

/// State jika proses retry ternyata masih gagal lagi
class GlobalErrorRetryFailure extends GlobalErrorState {
  final String message;

  const GlobalErrorRetryFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
