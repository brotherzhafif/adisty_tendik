import '../models/monitoring_presensi_model.dart';
import '../providers/monitoring_presensi_provider.dart';

class MonitoringPresensiRepository {
  final MonitoringPresensiProvider provider;

  MonitoringPresensiRepository({required this.provider});

  Future<List<MonitoringTanggalModel>> getMonitoringData() async {
    return await provider.getMonitoringData();
  }
}
