import 'dart:convert';
import 'package:flutter/services.dart';
import '../exceptions/rekap_presensi_exception.dart';
import '../models/rekap_presensi_model.dart';

abstract class IRekapPresensiProvider {
  Future<RekapPresensiResponseModel> fetchRekapPresensi();
}

class RekapPresensiProvider implements IRekapPresensiProvider {
  final String assetPath;

  const RekapPresensiProvider({
    this.assetPath = 'assets/data/rekap_presensi.json',
  });

  @override
  Future<RekapPresensiResponseModel> fetchRekapPresensi() async {
    try {
      // Simulasi delay jaringan agar loading state di UI dapat terlihat dengan smooth
      await Future.delayed(const Duration(milliseconds: 600));

      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      return RekapPresensiResponseModel.fromJson(jsonMap);
    } catch (e) {
      throw RekapPresensiException('Gagal membaca data presensi: ${e.toString()}');
    }
  }
}
