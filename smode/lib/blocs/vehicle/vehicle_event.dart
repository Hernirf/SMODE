part of 'vehicle_bloc.dart';

sealed class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object> get props => [];
}

class VehicleGet extends VehicleEvent {}

class VehicleModeAman extends VehicleEvent {
  final String id;
  const VehicleModeAman(this.id);

  @override
  List<Object> get props => [id];
}

class RefreshCurrentModeEvent extends VehicleEvent {
  final String id;
  const RefreshCurrentModeEvent(this.id); // Event untuk refresh mode

   @override
  List<Object> get props => [id];
}


class VehicleModeMesin extends VehicleEvent {
  final String id;
  const VehicleModeMesin(this.id);

  @override
  List<Object> get props => [id];
}

class VehicleLocation extends VehicleEvent {
  final String id;
  const VehicleLocation(this.id);

  @override
  List<Object> get props => [id];
}
