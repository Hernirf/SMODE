import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:smode/models/deteksi_model.dart';
import 'package:smode/services/auth_service.dart';
import 'package:smode/shared/shared_values.dart';

class DeteksiService {
  Future<List<DeteksiModel>> getDeteksi(String id) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.post(Uri.parse('$baseUrl/detection/list'),
          headers: {'Authorization': token}, body: {'id': id});

      if (res.statusCode == 200) {
        return List<DeteksiModel>.from(
          jsonDecode(res.body).map(
            (deteksi) => DeteksiModel.fromJson(deteksi),
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
}
