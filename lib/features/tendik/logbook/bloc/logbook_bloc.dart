import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/get_logbook_usecase.dart';
import 'logbook_event.dart';
import 'logbook_state.dart';

class LogbookBloc extends Bloc<LogbookEvent, LogbookState> {
  final GetLogbookUseCase getLogbookUseCase;

  LogbookBloc({required this.getLogbookUseCase})
    : super(const LogbookInitial()) {
    on<FetchLogbookEvent>(_onFetchLogbook);
    on<RefreshLogbookEvent>(_onRefreshLogbook);
    on<ChangeBulanLogbookEvent>(_onChangeBulan);
  }

  Future<void> _onFetchLogbook(
    FetchLogbookEvent event,
    Emitter<LogbookState> emit,
  ) async {
    emit(const LogbookLoading());
    try {
      final response = await getLogbookUseCase.execute();
      final now = DateTime.now();
      int defaultIndex = response.dataBulan.indexWhere(
        (b) => b.year == now.year && b.month == now.month,
      );
      if (defaultIndex == -1) {
        defaultIndex = response.dataBulan.lastIndexWhere(
          (b) => !b.isAfterDate(now),
        );
      }
      if (defaultIndex == -1) {
        defaultIndex = response.dataBulan.isNotEmpty ? 0 : 0;
      }
      emit(
        LogbookLoaded(
          profile: response.profile,
          dataBulan: response.dataBulan,
          bulanIndex: defaultIndex,
        ),
      );
    } catch (e) {
      emit(LogbookError(e.toString()));
    }
  }

  Future<void> _onRefreshLogbook(
    RefreshLogbookEvent event,
    Emitter<LogbookState> emit,
  ) async {
    try {
      final response = await getLogbookUseCase.execute();
      final currentIndex = state is LogbookLoaded
          ? (state as LogbookLoaded).bulanIndex
          : 2;
      emit(
        LogbookLoaded(
          profile: response.profile,
          dataBulan: response.dataBulan,
          bulanIndex: currentIndex < response.dataBulan.length
              ? currentIndex
              : 0,
        ),
      );
    } catch (e) {
      emit(LogbookError(e.toString()));
    }
  }

  void _onChangeBulan(
    ChangeBulanLogbookEvent event,
    Emitter<LogbookState> emit,
  ) {
    if (state is LogbookLoaded) {
      final currentState = state as LogbookLoaded;
      if (event.activeBulanIndex >= 0 &&
          event.activeBulanIndex < currentState.dataBulan.length) {
        emit(currentState.copyWith(bulanIndex: event.activeBulanIndex));
      }
    }
  }
}
