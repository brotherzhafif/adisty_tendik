import '../models/rekap_presensi_model.dart';
import '../providers/rekap_presensi_provider.dart';

abstract class IRekapPresensiRepository {
  Future<RekapPresensiResponseModel> getRekapPresensi();
}

class RekapPresensiRepository implements IRekapPresensiRepository {
  final IRekapPresensiProvider provider;

  const RekapPresensiRepository({required this.provider});

  @override
  Future<RekapPresensiResponseModel> getRekapPresensi() async {
    return await provider.fetchRekapPresensi();
  }
}
