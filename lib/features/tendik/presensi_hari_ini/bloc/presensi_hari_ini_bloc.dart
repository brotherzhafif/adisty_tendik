import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/get_presensi_hari_ini_usecase.dart';
import 'presensi_hari_ini_event.dart';
import 'presensi_hari_ini_state.dart';

class PresensiHariIniBloc
    extends Bloc<PresensiHariIniEvent, PresensiHariIniState> {
  final GetPresensiHariIniUseCase getPresensiHariIniUseCase;

  PresensiHariIniBloc({required this.getPresensiHariIniUseCase})
      : super(const PresensiHariIniInitial()) {
    on<FetchPresensiHariIniEvent>(_onFetchPresensiHariIni);
    on<RefreshPresensiHariIniEvent>(_onRefreshPresensiHariIni);
  }

  Future<void> _onFetchPresensiHariIni(
    FetchPresensiHariIniEvent event,
    Emitter<PresensiHariIniState> emit,
  ) async {
    emit(const PresensiHariIniLoading());
    try {
      final response = await getPresensiHariIniUseCase.execute();
      emit(
        PresensiHariIniLoaded(
          detail: response.detail,
          riwayatKoreksi: response.riwayatKoreksi,
        ),
      );
    } catch (e) {
      emit(PresensiHariIniError(e.toString()));
    }
  }

  Future<void> _onRefreshPresensiHariIni(
    RefreshPresensiHariIniEvent event,
    Emitter<PresensiHariIniState> emit,
  ) async {
    try {
      final response = await getPresensiHariIniUseCase.execute();
      emit(
        PresensiHariIniLoaded(
          detail: response.detail,
          riwayatKoreksi: response.riwayatKoreksi,
        ),
      );
    } catch (e) {
      emit(PresensiHariIniError(e.toString()));
    }
  }
}
