import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/get_skp_usecase.dart';
import 'skp_event.dart';
import 'skp_state.dart';

class SkpBloc extends Bloc<SkpEvent, SkpState> {
  final GetSkpUseCase getSkpUseCase;

  SkpBloc({required this.getSkpUseCase}) : super(const SkpInitial()) {
    on<FetchSkpEvent>(_onFetchSkp);
    on<RefreshSkpEvent>(_onRefreshSkp);
    on<ChangeYearSkpEvent>(_onChangeYear);
  }

  Future<void> _onFetchSkp(FetchSkpEvent event, Emitter<SkpState> emit) async {
    emit(const SkpLoading());
    try {
      final response = await getSkpUseCase.execute();
      int defaultIndex = 1; // Default ke tahun 2026 jika tersedia
      if (response.years.length <= defaultIndex) {
        defaultIndex = 0;
      }
      emit(
        SkpLoaded(
          profile: response.profile,
          years: response.years,
          activeYearIndex: defaultIndex,
          skpData: response.skpData,
        ),
      );
    } catch (e) {
      emit(SkpError(e.toString()));
    }
  }

  Future<void> _onRefreshSkp(
    RefreshSkpEvent event,
    Emitter<SkpState> emit,
  ) async {
    try {
      final response = await getSkpUseCase.execute();
      final currentIndex = state is SkpLoaded
          ? (state as SkpLoaded).activeYearIndex
          : 1;
      emit(
        SkpLoaded(
          profile: response.profile,
          years: response.years,
          activeYearIndex: currentIndex < response.years.length
              ? currentIndex
              : 0,
          skpData: response.skpData,
        ),
      );
    } catch (e) {
      emit(SkpError(e.toString()));
    }
  }

  void _onChangeYear(ChangeYearSkpEvent event, Emitter<SkpState> emit) {
    if (state is SkpLoaded) {
      final currentState = state as SkpLoaded;
      emit(currentState.copyWith(activeYearIndex: event.activeYearIndex));
    }
  }
}
