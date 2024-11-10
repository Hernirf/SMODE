import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:smode/models/login_form_model.dart';
import 'package:smode/models/user_model.dart';
import 'package:smode/shared/shared_values.dart';


class AuthService {
  Future<UserModel> login(LoginFormModel data) async {
    try {
      final res = await http.post(
        Uri.parse('$baseUrl/login'),
        body: data.toJson(),
      );
      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));
        user = user.copyWith(password: data.password);

        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final token = await getToken();
      final res = await http.post(Uri.parse('$baseUrl/logout'),
          headers: {'Authorization': token});

      if (res.statusCode == 200) {
        await clearLocalStorage();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
      await storage.write(key: 'token', value: user.token);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['token'] != null) {
        final LoginFormModel data = LoginFormModel(
            email: values['email'], password: values['password']);

        return data;
      } else {
        throw 'unauthenticated';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    String token = '';

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');

    if (value != null) {
      token = 'Bearer $value';
    }

    return token;
  }

  Future<void> clearLocalStorage() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }
}
