import '../../data/models/home_presensi_model.dart';
import '../../data/repositories/home_presensi_repository.dart';

class GetHomePresensiUseCase {
  final IHomePresensiRepository repository;

  const GetHomePresensiUseCase({required this.repository});

  Future<HomePresensiResponseModel> execute() async {
    return await repository.getHomePresensiData();
  }
}
