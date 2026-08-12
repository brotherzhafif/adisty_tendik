import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/services/device_context_service.dart';
import '../domain/usecases/get_home_presensi_usecase.dart';
import '../presentation/widgets/presensi_state.dart';
import 'home_presensi_event.dart';
import 'home_presensi_state.dart';

class HomePresensiBloc extends Bloc<HomePresensiEvent, HomePresensiState> {
  final GetHomePresensiUseCase getHomePresensiUseCase;
  final DeviceContextService deviceContextService;

  HomePresensiBloc({
    required this.getHomePresensiUseCase,
    DeviceContextService? deviceContextService,
  })  : deviceContextService = deviceContextService ?? DeviceContextService(),
        super(const HomePresensiInitial()) {
    on<FetchHomePresensiEvent>(_onFetchHomePresensi);
    on<RefreshHomePresensiEvent>(_onRefreshHomePresensi);
    on<AdvancePresensiStateEvent>(_onAdvancePresensiState);
    on<ResetPresensiStateEvent>(_onResetPresensiState);
    on<FetchDeviceContextEvent>(_onFetchDeviceContext);
  }

  Future<void> _onFetchHomePresensi(
    FetchHomePresensiEvent event,
    Emitter<HomePresensiState> emit,
  ) async {
    emit(const HomePresensiLoading());
    try {
      final response = await getHomePresensiUseCase.execute();
      emit(
        HomePresensiLoaded(
          profile: response.profile,
          presensiToday: response.presensiToday,
          presensiState: PresensiState.belumPresensi,
        ),
      );
    } catch (e) {
      emit(HomePresensiError(e.toString()));
    }
  }

  Future<void> _onRefreshHomePresensi(
    RefreshHomePresensiEvent event,
    Emitter<HomePresensiState> emit,
  ) async {
    try {
      final response = await getHomePresensiUseCase.execute();
      final currentState = state is HomePresensiLoaded
          ? (state as HomePresensiLoaded)
          : null;
      emit(
        HomePresensiLoaded(
          profile: response.profile,
          presensiToday: response.presensiToday,
          presensiState: currentState?.presensiState ?? PresensiState.belumPresensi,
          deviceContext: currentState?.deviceContext,
          deviceContextError: currentState?.deviceContextError,
        ),
      );
    } catch (e) {
      emit(HomePresensiError(e.toString()));
    }
  }

  void _onAdvancePresensiState(
    AdvancePresensiStateEvent event,
    Emitter<HomePresensiState> emit,
  ) {
    if (state is HomePresensiLoaded) {
      final currentState = state as HomePresensiLoaded;
      PresensiState nextState = currentState.presensiState;

      switch (currentState.presensiState) {
        case PresensiState.belumPresensi:
          nextState = PresensiState.pulang;
          break;
        case PresensiState.pulang:
          break;
      }

      emit(currentState.copyWith(presensiState: nextState));
    }
  }

  void _onResetPresensiState(
    ResetPresensiStateEvent event,
    Emitter<HomePresensiState> emit,
  ) {
    if (state is HomePresensiLoaded) {
      final currentState = state as HomePresensiLoaded;
      emit(currentState.copyWith(presensiState: PresensiState.belumPresensi));
    }
  }

  Future<void> _onFetchDeviceContext(
    FetchDeviceContextEvent event,
    Emitter<HomePresensiState> emit,
  ) async {
    if (state is HomePresensiLoaded) {
      final currentState = state as HomePresensiLoaded;
      try {
        final deviceContext = await deviceContextService.getDeviceContext();
        emit(currentState.copyWith(
          deviceContext: deviceContext,
          deviceContextError: null,
        ));
      } catch (e) {
        emit(currentState.copyWith(
          deviceContextError: e.toString(),
        ));
      }
    }
  }
}
