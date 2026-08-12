import 'package:equatable/equatable.dart';
import '../data/models/monitoring_presensi_model.dart';

abstract class MonitoringPresensiState extends Equatable {
  const MonitoringPresensiState();

  @override
  List<Object?> get props => [];
}

class MonitoringPresensiInitial extends MonitoringPresensiState {}

class MonitoringPresensiLoading extends MonitoringPresensiState {}

class MonitoringPresensiLoaded extends MonitoringPresensiState {
  final List<MonitoringTanggalModel> listTanggal;
  final int selectedIndex;

  const MonitoringPresensiLoaded({
    required this.listTanggal,
    this.selectedIndex = 0,
  });

  MonitoringTanggalModel get currentTanggal => listTanggal[selectedIndex];

  MonitoringPresensiLoaded copyWith({
    List<MonitoringTanggalModel>? listTanggal,
    int? selectedIndex,
  }) {
    return MonitoringPresensiLoaded(
      listTanggal: listTanggal ?? this.listTanggal,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [listTanggal, selectedIndex];
}

class MonitoringPresensiError extends MonitoringPresensiState {
  final String message;

  const MonitoringPresensiError(this.message);

  @override
  List<Object?> get props => [message];
}
