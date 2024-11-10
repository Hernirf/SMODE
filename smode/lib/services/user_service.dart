import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:smode/services/auth_service.dart';
import 'package:smode/shared/shared_values.dart';
// import 'package:smode/services/auth_service.dart';
// import 'package:smode/shared/shared_values.dart';

class UserService {
  Future<void> update(String fCMToken) async {
    try {
      final token = await AuthService().getToken();
      final res = await http.put(
        Uri.parse('$baseUrl/user/update'),
        headers: {'Authorization': token},
        body: {"token": fCMToken},
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
