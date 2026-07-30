import '../models/logbook_model.dart';
import '../providers/logbook_provider.dart';

abstract class ILogbookRepository {
  Future<LogbookResponseModel> getLogbookData();
}

class LogbookRepository implements ILogbookRepository {
  final ILogbookProvider provider;

  const LogbookRepository({required this.provider});

  @override
  Future<LogbookResponseModel> getLogbookData() async {
    return await provider.fetchLogbookData();
  }
}
