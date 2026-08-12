import 'package:equatable/equatable.dart';

abstract class KategoriAktivitasState extends Equatable {
  const KategoriAktivitasState();

  @override
  List<Object?> get props => [];
}

class KategoriAktivitasInitial extends KategoriAktivitasState {
  const KategoriAktivitasInitial();
}

class KategoriAktivitasLoading extends KategoriAktivitasState {
  const KategoriAktivitasLoading();
}

class KategoriAktivitasLoaded extends KategoriAktivitasState {
  final List<String> listKategori;
  final List<String> filteredKategori;
  final String selectedKategori;
  final String searchQuery;

  const KategoriAktivitasLoaded({
    required this.listKategori,
    required this.filteredKategori,
    required this.selectedKategori,
    this.searchQuery = '',
  });

  KategoriAktivitasLoaded copyWith({
    List<String>? listKategori,
    List<String>? filteredKategori,
    String? selectedKategori,
    String? searchQuery,
  }) {
    return KategoriAktivitasLoaded(
      listKategori: listKategori ?? this.listKategori,
      filteredKategori: filteredKategori ?? this.filteredKategori,
      selectedKategori: selectedKategori ?? this.selectedKategori,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        listKategori,
        filteredKategori,
        selectedKategori,
        searchQuery,
      ];
}

class KategoriAktivitasError extends KategoriAktivitasState {
  final String message;
  const KategoriAktivitasError(this.message);

  @override
  List<Object?> get props => [message];
}
