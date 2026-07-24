import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/get_rekap_presensi_usecase.dart';
import 'rekap_presensi_event.dart';
import 'rekap_presensi_state.dart';

class RekapPresensiBloc extends Bloc<RekapPresensiEvent, RekapPresensiState> {
  final GetRekapPresensiUseCase getRekapPresensiUseCase;

  RekapPresensiBloc({required this.getRekapPresensiUseCase})
    : super(const RekapPresensiInitial()) {
    on<FetchRekapPresensiEvent>(_onFetchRekapPresensi);
    on<RefreshRekapPresensiEvent>(_onRefreshRekapPresensi);
  }

  Future<void> _onFetchRekapPresensi(
    FetchRekapPresensiEvent event,
    Emitter<RekapPresensiState> emit,
  ) async {
    emit(const RekapPresensiLoading());
    try {
      final response = await getRekapPresensiUseCase.execute();
      emit(
        RekapPresensiLoaded(
          totalTransport: response.totalTransport,
          totalJam: response.totalJam,
          logs: response.logs,
        ),
      );
    } catch (e) {
      emit(RekapPresensiError(e.toString()));
    }
  }

  Future<void> _onRefreshRekapPresensi(
    RefreshRekapPresensiEvent event,
    Emitter<RekapPresensiState> emit,
  ) async {
    try {
      final response = await getRekapPresensiUseCase.execute();
      emit(
        RekapPresensiLoaded(
          totalTransport: response.totalTransport,
          totalJam: response.totalJam,
          logs: response.logs,
        ),
      );
    } catch (e) {
      emit(RekapPresensiError(e.toString()));
    }
  }
}
