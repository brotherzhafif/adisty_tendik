import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'kategori_aktivitas_event.dart';
import 'kategori_aktivitas_state.dart';

class KategoriAktivitasBloc
    extends Bloc<KategoriAktivitasEvent, KategoriAktivitasState> {
  KategoriAktivitasBloc() : super(const KategoriAktivitasInitial()) {
    on<FetchKategoriAktivitasEvent>(_onFetchKategori);
    on<SearchKategoriAktivitasEvent>(_onSearchKategori);
    on<SelectKategoriAktivitasEvent>(_onSelectKategori);
  }

  Future<void> _onFetchKategori(
    FetchKategoriAktivitasEvent event,
    Emitter<KategoriAktivitasState> emit,
  ) async {
    emit(const KategoriAktivitasLoading());
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/logbook_kategori_aktivitas.json',
      );
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> rawList = data['data'] as List<dynamic>? ?? [];
      final listKategori = rawList.map((e) => e.toString()).toList();

      final selected = (event.initialSelected != null &&
              event.initialSelected!.isNotEmpty &&
              listKategori.contains(event.initialSelected))
          ? event.initialSelected!
          : (listKategori.isNotEmpty ? listKategori.first : '');

      emit(
        KategoriAktivitasLoaded(
          listKategori: listKategori,
          filteredKategori: listKategori,
          selectedKategori: selected,
        ),
      );
    } catch (e) {
      emit(KategoriAktivitasError('Gagal memuat kategori: ${e.toString()}'));
    }
  }

  void _onSearchKategori(
    SearchKategoriAktivitasEvent event,
    Emitter<KategoriAktivitasState> emit,
  ) {
    if (state is KategoriAktivitasLoaded) {
      final currentState = state as KategoriAktivitasLoaded;
      final query = event.query.toLowerCase().trim();

      final filtered = query.isEmpty
          ? currentState.listKategori
          : currentState.listKategori
              .where((k) => k.toLowerCase().contains(query))
              .toList();

      emit(
        currentState.copyWith(
          filteredKategori: filtered,
          searchQuery: event.query,
        ),
      );
    }
  }

  void _onSelectKategori(
    SelectKategoriAktivitasEvent event,
    Emitter<KategoriAktivitasState> emit,
  ) {
    if (state is KategoriAktivitasLoaded) {
      final currentState = state as KategoriAktivitasLoaded;
      emit(currentState.copyWith(selectedKategori: event.selectedKategori));
    }
  }
}
