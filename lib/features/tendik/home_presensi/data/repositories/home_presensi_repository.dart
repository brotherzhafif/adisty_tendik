import '../models/home_presensi_model.dart';
import '../providers/home_presensi_provider.dart';

abstract class IHomePresensiRepository {
  Future<HomePresensiResponseModel> getHomePresensiData();
}

class HomePresensiRepository implements IHomePresensiRepository {
  final IHomePresensiProvider provider;

  const HomePresensiRepository({required this.provider});

  @override
  Future<HomePresensiResponseModel> getHomePresensiData() async {
    return await provider.fetchHomePresensiData();
  }
}
