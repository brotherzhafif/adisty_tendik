import 'package:equatable/equatable.dart';

abstract class GlobalErrorEvent extends Equatable {
  const GlobalErrorEvent();

  @override
  List<Object?> get props => [];
}

/// Event yang dipicu saat halaman error pertama kali dimuat dengan data dari interceptor
class InitGlobalError extends GlobalErrorEvent {
  final String message;
  final int statusCode;
  final Future<void> Function() onRetry;

  const InitGlobalError({
    required this.message,
    required this.statusCode,
    required this.onRetry,
  });

  @override
  List<Object?> get props => [message, statusCode, onRetry];
}

/// Event yang dipicu saat pengguna menekan tombol "Retry"
class ExecuteRetry extends GlobalErrorEvent {
  const ExecuteRetry();
}