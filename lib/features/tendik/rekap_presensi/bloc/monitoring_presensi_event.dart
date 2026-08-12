import 'package:equatable/equatable.dart';

abstract class MonitoringPresensiEvent extends Equatable {
  const MonitoringPresensiEvent();

  @override
  List<Object?> get props => [];
}

class FetchMonitoringPresensiEvent extends MonitoringPresensiEvent {}

class ChangeIndexMonitoringEvent extends MonitoringPresensiEvent {
  final int index;

  const ChangeIndexMonitoringEvent(this.index);

  @override
  List<Object?> get props => [index];
}
