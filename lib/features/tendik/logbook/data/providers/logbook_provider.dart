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

      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      return LogbookResponseModel.fromJson(jsonMap);
    } catch (e) {
      throw LogbookException('Gagal membaca data logbook: ${e.toString()}');
    }
  }
}
