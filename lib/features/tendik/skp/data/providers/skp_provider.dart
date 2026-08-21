import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../exceptions/skp_exception.dart';
import '../models/skp_model.dart';

abstract class ISkpProvider {
  Future<SkpResponseModel> fetchSkpData();
}

class SkpProvider implements ISkpProvider {
  final String assetPath;

  const SkpProvider({this.assetPath = 'assets/data/skp.json'});

  @override
  Future<SkpResponseModel> fetchSkpData() async {
    try {
      // Simulasi delay jaringan agar loading state di UI terlihat smooth
      await Future.delayed(const Duration(milliseconds: 600));

      final jsonString = await rootBundle
          .loadString(assetPath)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException(
              'Koneksi timeout — server tidak merespons dalam 10 detik',
            ),
          );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      return SkpResponseModel.fromJson(jsonMap);
    } on TimeoutException catch (e) {
      throw SkpException(e.message ?? 'Request timeout');
    } catch (e) {
      throw SkpException('Gagal membaca data SKP: ${e.toString()}');
    }
  }
}
