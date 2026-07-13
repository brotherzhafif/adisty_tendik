import 'package:flutter_bloc/flutter_bloc.dart';
import 'global_error_event.dart';
import 'global_error_state.dart';

class GlobalErrorBloc extends Bloc<GlobalErrorEvent, GlobalErrorState> {
  GlobalErrorBloc() : super(GlobalErrorInitial()) {
    on<InitGlobalError>(_onInitGlobalError);
    on<ExecuteRetry>(_onExecuteRetry);
  }

  void _onInitGlobalError(
    InitGlobalError event,
    Emitter<GlobalErrorState> emit,
  ) {
    emit(
      GlobalErrorDisplay(
        message: event.message,
        statusCode: event.statusCode,
        onRetry: event.onRetry,
      ),
    );
  }

  Future<void> _onExecuteRetry(
    ExecuteRetry event,
    Emitter<GlobalErrorState> emit,
  ) async {
    final currentState = state;
    if (currentState is GlobalErrorDisplay) {
      emit(GlobalErrorRetryLoading());
      try {
        // Mengeksekusi fungsi callback retry yang dilempar oleh Dio Interceptor tadi
        await currentState.onRetry();
        emit(GlobalErrorRetrySuccess());
      } catch (e) {
        // Jika retry masih gagal, kembalikan ke tampilan error dengan info tambahan
        emit(
          GlobalErrorDisplay(
            message: currentState.message,
            statusCode: currentState.statusCode,
            onRetry: currentState.onRetry,
          ),
        );
      }
    }
  }
}
