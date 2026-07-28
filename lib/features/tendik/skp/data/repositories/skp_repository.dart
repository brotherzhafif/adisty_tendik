import '../models/skp_model.dart';
import '../providers/skp_provider.dart';

abstract class ISkpRepository {
  Future<SkpResponseModel> getSkpData();
}

class SkpRepository implements ISkpRepository {
  final ISkpProvider provider;

  const SkpRepository({required this.provider});

  @override
  Future<SkpResponseModel> getSkpData() async {
    return await provider.fetchSkpData();
  }
}
