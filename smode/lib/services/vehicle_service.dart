import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:smode/models/vehicle_location_model.dart';
import 'package:smode/models/vehicle_model.dart';
import 'package:smode/services/auth_service.dart';
import 'package:smode/shared/shared_values.dart';


class VehicleService {
  Future<List<VehicleModel>> getVehicle() async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(Uri.parse('$baseUrl/vehicle/list'),
          headers: {'Authorization': token});

      if (res.statusCode == 200) {
        return List<VehicleModel>.from(
          jsonDecode(res.body).map(
            (vehicle) => VehicleModel.fromJson(vehicle),
          ),
        ).toList();
      } else if (res.statusCode == 404) {
        return [];
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> modeAman(String id) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.put(
        Uri.parse('$baseUrl/vehicle/modeaman'),
        headers: {'Authorization': token},
        body: {"id": id},
      );

      print(res.body);
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> modeMesin(String id) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.put(
        Uri.parse('$baseUrl/vehicle/modemesin'),
        headers: {'Authorization': token},
        body: {"id": id},
      );

      print(res.body);
      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<VehicleLocationModel> location(String id) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(Uri.parse('$baseUrl/vehicle/location'),
          headers: {'Authorization': token}, body: {'id': id});

      if (res.statusCode == 200) {
        return VehicleLocationModel.fromJson(jsonDecode(res.body));
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
