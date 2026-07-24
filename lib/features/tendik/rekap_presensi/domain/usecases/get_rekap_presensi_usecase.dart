import '../../data/models/rekap_presensi_model.dart';
import '../../data/repositories/rekap_presensi_repository.dart';

class GetRekapPresensiUseCase {
  final IRekapPresensiRepository repository;

  const GetRekapPresensiUseCase({required this.repository});

  Future<RekapPresensiResponseModel> execute() async {
    return await repository.getRekapPresensi();
  }
}
