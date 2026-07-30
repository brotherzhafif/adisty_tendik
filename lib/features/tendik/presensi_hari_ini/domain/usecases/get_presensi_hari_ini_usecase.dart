import '../../data/models/presensi_hari_ini_model.dart';
import '../../data/repositories/presensi_hari_ini_repository.dart';

class GetPresensiHariIniUseCase {
  final IPresensiHariIniRepository repository;

  const GetPresensiHariIniUseCase({required this.repository});

  Future<PresensiHariIniResponseModel> execute() async {
    return await repository.getPresensiHariIniData();
  }
}
