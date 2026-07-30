import '../../data/models/logbook_model.dart';
import '../../data/repositories/logbook_repository.dart';

class GetLogbookUseCase {
  final ILogbookRepository repository;

  const GetLogbookUseCase({required this.repository});

  Future<LogbookResponseModel> execute() async {
    return await repository.getLogbookData();
  }
}
