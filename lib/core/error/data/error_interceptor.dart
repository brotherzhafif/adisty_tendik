import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Interceptor khusus Dio yang berfungsi sebagai gateway pengalihan
/// jika terjadi error jaringan kritis (RTO, Koneksi Terputus, atau Server 500).
class ErrorGatewayInterceptor extends Interceptor {
  /// GlobalKey Navigator milik aplikasi utama agar bisa berpindah
  /// halaman secara global tanpa membutuhkan BuildContext lokal.
  final GlobalKey<NavigatorState> navigatorKey;

  ErrorGatewayInterceptor({required this.navigatorKey});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Cek apakah jenis error termasuk masalah koneksi atau server internal down (500)
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response != null && err.response!.statusCode == 500)) {
      // Mengalihkan rute secara paksa ke Global Error Page
      navigatorKey.currentState?.pushNamed(
        '/global-error',
        arguments: {
          'errorMessage': err.message ?? 'Koneksi ke server Adisty terputus.',
          'statusCode': err.response?.statusCode ?? 500,
          'onRetry': () async {
            // Skema mekanis retry: Mengulang kembali request yang sempat gagal tadi
            final response = await Dio().fetch(err.requestOptions);
            return handler.resolve(response);
          },
        },
      );
      return;
    }

    // Jika bukan error jaringan kritis, teruskan ke handler normal/BLoC lokal
    super.onError(err, handler);
  }
}
