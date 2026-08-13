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
    on<ChangeBulanRekapPresensiEvent>(_onChangeBulan);
  }

  Future<void> _onFetchRekapPresensi(
    FetchRekapPresensiEvent event,
    Emitter<RekapPresensiState> emit,
  ) async {
    emit(const RekapPresensiLoading());
    try {
      final response = await getRekapPresensiUseCase.execute();
      final dataBulan = response.dataBulan;
      final initialIndex = dataBulan.isNotEmpty ? dataBulan.length - 1 : 0;
      emit(RekapPresensiLoaded(dataBulan: dataBulan, bulanIndex: initialIndex));
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
      final dataBulan = response.dataBulan;
      int currentIndex = 0;
      if (state is RekapPresensiLoaded) {
        currentIndex = (state as RekapPresensiLoaded).bulanIndex;
      } else {
        currentIndex = dataBulan.isNotEmpty ? dataBulan.length - 1 : 0;
      }
      if (currentIndex >= dataBulan.length) {
        currentIndex = dataBulan.length - 1;
      }
      emit(RekapPresensiLoaded(dataBulan: dataBulan, bulanIndex: currentIndex));
    } catch (e) {
      emit(RekapPresensiError(e.toString()));
    }
  }

  void _onChangeBulan(
    ChangeBulanRekapPresensiEvent event,
    Emitter<RekapPresensiState> emit,
  ) {
    if (state is RekapPresensiLoaded) {
      final currentState = state as RekapPresensiLoaded;
      if (event.index >= 0 && event.index < currentState.dataBulan.length) {
        emit(currentState.copyWith(bulanIndex: event.index));
      }
    }
  }
}
