import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/monitoring_presensi_model.dart';

class MonitoringPresensiProvider {
  Future<List<MonitoringTanggalModel>> getMonitoringData() async {
    try {
      // Simulasi delay jaringan agar loading state di UI terlihat smooth
      await Future.delayed(const Duration(milliseconds: 600));

      final String response = await rootBundle
          .loadString('assets/data/monitoring_presensi.json')
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException(
              'Koneksi timeout — server tidak merespons dalam 10 detik',
            ),
          );
      final Map<String, dynamic> data = json.decode(response);
      final List<dynamic> listTanggal = data['data_tanggal'] ?? [];
      return listTanggal
          .map((json) => MonitoringTanggalModel.fromJson(json))
          .toList();
    } on TimeoutException catch (e) {
      throw Exception(e.message ?? 'Request timeout');
    }
  }
}
