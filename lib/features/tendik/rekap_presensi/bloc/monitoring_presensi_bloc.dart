import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/get_monitoring_presensi_usecase.dart';
import 'monitoring_presensi_event.dart';
import 'monitoring_presensi_state.dart';

class MonitoringPresensiBloc
    extends Bloc<MonitoringPresensiEvent, MonitoringPresensiState> {
  final GetMonitoringPresensiUseCase getMonitoringPresensiUseCase;

  MonitoringPresensiBloc({required this.getMonitoringPresensiUseCase})
      : super(MonitoringPresensiInitial()) {
    on<FetchMonitoringPresensiEvent>(_onFetchMonitoringPresensi);
    on<ChangeIndexMonitoringEvent>(_onChangeIndexMonitoring);
  }

  Future<void> _onFetchMonitoringPresensi(
    FetchMonitoringPresensiEvent event,
    Emitter<MonitoringPresensiState> emit,
  ) async {
    emit(MonitoringPresensiLoading());
    try {
      final listTanggal = await getMonitoringPresensiUseCase.execute();
      emit(MonitoringPresensiLoaded(listTanggal: listTanggal));
    } catch (e) {
      emit(MonitoringPresensiError(e.toString()));
    }
  }

  void _onChangeIndexMonitoring(
    ChangeIndexMonitoringEvent event,
    Emitter<MonitoringPresensiState> emit,
  ) {
    if (state is MonitoringPresensiLoaded) {
      final currentState = state as MonitoringPresensiLoaded;
      if (event.index >= 0 && event.index < currentState.listTanggal.length) {
        emit(currentState.copyWith(selectedIndex: event.index));
      }
    }
  }
}
