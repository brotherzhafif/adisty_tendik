import '../models/presensi_hari_ini_model.dart';
import '../providers/presensi_hari_ini_provider.dart';

abstract class IPresensiHariIniRepository {
  Future<PresensiHariIniResponseModel> getPresensiHariIniData();
}

class PresensiHariIniRepository implements IPresensiHariIniRepository {
  final IPresensiHariIniProvider provider;

  const PresensiHariIniRepository({required this.provider});

  @override
  Future<PresensiHariIniResponseModel> getPresensiHariIniData() async {
    return await provider.fetchPresensiHariIniData();
  }
}
