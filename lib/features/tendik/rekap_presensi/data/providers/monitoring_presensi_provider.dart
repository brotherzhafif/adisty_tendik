import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/monitoring_presensi_model.dart';

class MonitoringPresensiProvider {
  Future<List<MonitoringTanggalModel>> getMonitoringData() async {
    final String response = await rootBundle.loadString(
      'assets/data/monitoring_presensi.json',
    );
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> listTanggal = data['data_tanggal'] ?? [];
    return listTanggal
        .map((json) => MonitoringTanggalModel.fromJson(json))
        .toList();
  }
}
