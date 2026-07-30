import 'dart:convert';
import 'package:flutter/services.dart';
import '../exceptions/home_presensi_exception.dart';
import '../models/home_presensi_model.dart';

abstract class IHomePresensiProvider {
  Future<HomePresensiResponseModel> fetchHomePresensiData();
}

class HomePresensiProvider implements IHomePresensiProvider {
  final String assetPath;

  const HomePresensiProvider({
    this.assetPath = 'assets/data/home_presensi.json',
  });

  @override
  Future<HomePresensiResponseModel> fetchHomePresensiData() async {
    try {
      // Simulasi delay jaringan agar loading state di UI terlihat smooth
      await Future.delayed(const Duration(milliseconds: 600));

      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      return HomePresensiResponseModel.fromJson(jsonMap);
    } catch (e) {
      throw HomePresensiException(
          'Gagal membaca data home presensi: ${e.toString()}');
    }
  }
}
