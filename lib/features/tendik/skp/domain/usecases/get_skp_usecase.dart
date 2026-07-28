import '../../data/models/skp_model.dart';
import '../../data/repositories/skp_repository.dart';

class GetSkpUseCase {
  final ISkpRepository repository;

  const GetSkpUseCase({required this.repository});

  Future<SkpResponseModel> execute() async {
    return await repository.getSkpData();
  }
}
