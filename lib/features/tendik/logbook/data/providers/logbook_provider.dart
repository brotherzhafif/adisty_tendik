import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../exceptions/logbook_exception.dart';
import '../models/logbook_model.dart';

abstract class ILogbookProvider {
  Future<LogbookResponseModel> fetchLogbookData();
}

class LogbookProvider implements ILogbookProvider {
  final String assetPath;

  const LogbookProvider({this.assetPath = 'assets/data/logbook.json'});

  @override
  Future<LogbookResponseModel> fetchLogbookData() async {
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

      return LogbookResponseModel.fromJson(jsonMap);
    } on TimeoutException catch (e) {
      throw LogbookException(e.message ?? 'Request timeout');
    } catch (e) {
      throw LogbookException('Gagal membaca data logbook: ${e.toString()}');
    }
  }
}
