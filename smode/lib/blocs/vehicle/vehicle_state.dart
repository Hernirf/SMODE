part of 'vehicle_bloc.dart';

sealed class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object> get props => [];
}

final class VehicleInitial extends VehicleState {}

final class VehicleLoading extends VehicleState {}

final class VehicleFailed extends VehicleState {
  final String e;
  const VehicleFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class VehicleSuccess extends VehicleState {
  final List<VehicleModel> data;
  const VehicleSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class VehicleLocationSuccess extends VehicleState {
  final VehicleLocationModel data;
  const VehicleLocationSuccess(this.data);

  @override
  List<Object> get props => [data];
}
