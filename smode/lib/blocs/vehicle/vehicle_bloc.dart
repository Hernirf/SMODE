import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:smode/models/vehicle_location_model.dart';
import 'package:smode/models/vehicle_model.dart';
import 'package:smode/services/vehicle_service.dart';
// import 'package:smode/models/vehicle_location_model.dart';
// import 'package:smode/models/vehicle_model.dart';
// import 'package:smode/services/vehicle_service.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleInitial()) {
    on<VehicleEvent>((event, emit) async {
      if (event is VehicleGet) {
        try {
          emit(VehicleLoading());
          final vehicles = await VehicleService().getVehicle();
          emit(VehicleSuccess(vehicles));
        } catch (e) {
          emit(VehicleFailed(e.toString()));
        }
      }

      if (event is VehicleModeAman) {
        try {
          emit(VehicleLoading());
          await VehicleService().modeAman(event.id);
          final vehicles = await VehicleService().getVehicle();
          emit(VehicleSuccess(vehicles));
        } catch (e) {
          emit(VehicleFailed(e.toString()));
        }
      }

      if (event is VehicleModeMesin) {
        try {
          emit(VehicleLoading());
          await VehicleService().modeMesin(event.id);
          final vehicles = await VehicleService().getVehicle();
          emit(VehicleSuccess(vehicles));
        } catch (e) {
          emit(VehicleFailed(e.toString()));
        }
      }

      if (event is VehicleLocation) {
        try {
          emit(VehicleLoading());
          final location = await VehicleService().location(event.id);
          emit(VehicleLocationSuccess(location));
        } catch (e) {
          emit(VehicleFailed(e.toString()));
        }
      }
      if (event is RefreshCurrentModeEvent) {
        try {
          // Tambahkan logika untuk mengambil state terbaru
          emit(VehicleLoading());
          final vehicles = await VehicleService().getVehicle(); // Ambil data kendaraan terbaru
          emit(VehicleSuccess(vehicles)); // Emit state sukses dengan data terbaru
        } catch (e) {
          emit(VehicleFailed(e.toString()));
        }
      }
    });
  }
}
