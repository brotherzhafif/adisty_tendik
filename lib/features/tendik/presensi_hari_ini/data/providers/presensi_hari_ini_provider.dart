import 'dart:convert';
import 'package:flutter/services.dart';
import '../exceptions/presensi_hari_ini_exception.dart';
import '../models/presensi_hari_ini_model.dart';

abstract class IPresensiHariIniProvider {
  Future<PresensiHariIniResponseModel> fetchPresensiHariIniData();
}

class PresensiHariIniProvider implements IPresensiHariIniProvider {
  final String assetPath;

  const PresensiHariIniProvider({
    this.assetPath = 'assets/data/presensi_hari_ini.json',
  });

  @override
  Future<PresensiHariIniResponseModel> fetchPresensiHariIniData() async {
    try {
      // Simulasi delay jaringan agar loading state di UI terlihat smooth
      await Future.delayed(const Duration(milliseconds: 600));

      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      return PresensiHariIniResponseModel.fromJson(jsonMap);
    } catch (e) {
      throw PresensiHariIniException(
        'Gagal membaca data presensi hari ini: ${e.toString()}',
      );
    }
  }
}
