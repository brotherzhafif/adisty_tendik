import '../../data/models/monitoring_presensi_model.dart';
import '../../data/repositories/monitoring_presensi_repository.dart';

class GetMonitoringPresensiUseCase {
  final MonitoringPresensiRepository repository;

  GetMonitoringPresensiUseCase({required this.repository});

  Future<List<MonitoringTanggalModel>> execute() async {
    return await repository.getMonitoringData();
  }
}
