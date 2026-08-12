import 'package:equatable/equatable.dart';

abstract class KategoriAktivitasEvent extends Equatable {
  const KategoriAktivitasEvent();

  @override
  List<Object?> get props => [];
}

class FetchKategoriAktivitasEvent extends KategoriAktivitasEvent {
  final String? initialSelected;
  const FetchKategoriAktivitasEvent({this.initialSelected});

  @override
  List<Object?> get props => [initialSelected];
}

class SearchKategoriAktivitasEvent extends KategoriAktivitasEvent {
  final String query;
  const SearchKategoriAktivitasEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class SelectKategoriAktivitasEvent extends KategoriAktivitasEvent {
  final String selectedKategori;
  const SelectKategoriAktivitasEvent(this.selectedKategori);

  @override
  List<Object?> get props => [selectedKategori];
}
